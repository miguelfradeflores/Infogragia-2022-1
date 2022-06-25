import cv2
import numpy as np

cap = cv2.VideoCapture(0)
cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 768)

color = "Undifined"


while True:
    _, frame = cap.read()

    hsv_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

    height, width, _ = frame.shape

    cx = int(width/2)
    cy = int(height/2) 

    pixel_center = hsv_frame[cy,cx]
    hue_value = pixel_center[0]
    if hue_value <=5:
        corlor = "red"
    elif hue_value <=22:
        color = "orange"
    elif hue_value <= 33:
        color = "yellow"
    elif hue_value<=78:
        color = "green"
    elif hue_value<=131:
        color = "blue"
    elif hue_value<=178:
        color = "violet"
    else:
        color = "red"

    print(pixel_center)
    pixel_center_bgr = frame[cy,cx]
    b,g,r = int(pixel_center_bgr[0]),int(pixel_center_bgr[1]),int(pixel_center_bgr[2])

    cv2.putText(frame, color, (10,70), 0,1.5,(b,g,r),5)

    cv2.circle(frame, (cx,cy), 5, (255,0,0), 3 )

    cv2.imshow("Frame", frame)
    key = cv2.waitKey(1)
    if key == 27:
        break

cap.release()
cv2.destroyAllWindows()

