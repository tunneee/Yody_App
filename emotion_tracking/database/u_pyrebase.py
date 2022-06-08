import pyrebase
config = {
  "apiKey": "AIzaSyC0rCAiuRmtsnCzMOX1Ij-Vx6pGDSufb54",
  "authDomain": "yody-app.firebaseapp.com",
  "databaseURL": "https://yody-app-default-rtdb.firebaseio.com",
  "projectId": "yody-app",
  "storageBucket": "yody-app.appspot.com",
  "messagingSenderId": "419899455899",
  "appId": "1:419899455899:web:9c570a1f6867ec5648893e",
  "measurementId": "G-96X28M1EYB"
}

firebase = pyrebase.initialize_app(config)
storage = firebase.storage()
print(storage.child("Recording_Cam/48XTOwsH71M62uNHQQrTv5i7gXJ3-2022-06-04T23-30-02-526882").get_url(None))
