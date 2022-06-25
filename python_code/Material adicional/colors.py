import cv2
import numpy as np

# azul
#lower = np.array([90,100,20])
#upper = np.array([131,255,255])


lower = np.array([100, 100, 20])
upper = np.array([115, 200, 250])

video = cv2.VideoCapture(0)

while True:

    success, img = video.read()
    image = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
    mask = cv2.inRange(image, lower, upper)

    countour, hierachy = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    if countour != 0:
        for i in countour:
            if cv2.contourArea(i) >500:
                x,y,w,h = cv2.boundingRect(i)
                cv2.rectangle(img,  (x, y), (x+w, y+h), (0,0,255), 3   )


    cv2.imshow("mask", mask)
    cv2.imshow("cam", img)

    key = cv2.waitKey(1)
    if key == 27:
        break

video.release()
cv2.destroyAllWindows()    
