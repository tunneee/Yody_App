import json
import os
import threading
import time
from os.path import dirname, join
from dotenv import load_dotenv

import firebase_admin
from firebase_admin import credentials, firestore

dotenv_path = join(dirname(__file__), '.env')
load_dotenv(dotenv_path)
FB_KEY = os.environ.get("FB")


# RUN THIS FIRST
class Firebase():
    cred = credentials.Certificate(FB_KEY)
    firebase_admin.initialize_app(cred)
    callback_done = threading.Event()

    def __init__(self):
        self.db = firestore.client()
        self.user_ref = self.db.collection(u'users')
        self.data_ai_ref = self.db.collection(u'data-ai')

    def getUserByID(self, id):
        """Query data by user ID

        Args:
            `id`: user ID
        Returns:
            An array of users
        """
        query = self.user_ref.where(u'bio', u'==', f'{id}')
        return query.stream()

    def onsnapshot(self, snapshot, changes, read_time):

        if changes.length == 0:
            print(u'No changes.')
        else:
            for change in changes:
                newdata = {
                    'userID': change.document.id,
                    'productID': change.document.get('productID'),
                }
                self.append_data(
                    newdata,
                    "./dataset/AiDataTrain.json"
                )
            self.callback_done.set()

    def check_realtime_update(self, options: bool, time_interval: int):
        """Check for realtime update. Its run in a loop and check for new data. 
        Args:
            - 'options': True or False. If True, it will check for new data.
            - 'time_interval': time interval in seconds. The time interval is used to check for new data.

        """
        if options:
            while(True):
                time.sleep(time_interval)
                self.data_ai_ref.on_snapshot(self.onsnapshot)

    def append_data(self, data, filedir):
        with open(filedir, 'w') as outfile:
            file_data = json.load(outfile)
            file_data["data_user"].append(data)
            outfile.seek(0)
            json.dump(data, outfile, indent=4)
