from tracking import tracking
import json
import os
import threading
import time
from os.path import dirname, join

import firebase_admin
from firebase_admin import credentials, firestore

cred = credentials.Certificate('C:/Users/PC/Downloads/yody_key.json')
firebase_admin.initialize_app(cred)
db = firestore.client()
callback_done = threading.Event()
class Firebase():
    def __init__(self):
        self.users_ref = db.collection(u'users').get()
        self.products_ref = db.collection(u'products').get()
        self.data_ai_ref = db.collection(u'data-ai').get()

docs = Firebase()
for user in docs.data_ai_ref:
    # ref = db.reference("/Books/Best_Sellers/")
    user.to_dict()["video"])



