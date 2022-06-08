import cv2
import os
from deepface import DeepFace


def emotion_tracking(my_path):
    faceCascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
    cap = cv2.VideoCapture(my_path)

    # creating value model training
    value = {
        'angry':0,
        'disgust':0,
        'fear':0,
        'happy':0,
        'sad':0,
        'surprise':0,
        'neutral':0
    }

    # frame
    while(cap.isOpened()):
        ret,frame = cap.read()
    #     frame = cv2.flip(frame,1)
        if ret:
            try:
                result = DeepFace.analyze(frame,actions = ['emotion'])
                if result['dominant_emotion'] in ['angry', 'disgust', 'fear', 'happy', 'sad', 'surprise', 'neutral']:
                    value[result['dominant_emotion']]+=1
            except:
                continue
        else:
            break
    print(value)

    # After the loop release the cap object
    cap.release()
    # Destroy all the windows
    cv2.destroyAllWindows()

    new_value = dict(sorted(value.items(), key=lambda item: item[1], reverse= True))
    print(new_value)
    check_value_key = list(new_value.keys())
    print(check_value_key)
    if check_value_key[0] == 'neutral':
        if new_value[list(new_value.keys())[1]] != 0:
            ans_training = check_value_key[1]
        else:
            ans_training = 'newtral'
    answer = ans_training
    return anser

