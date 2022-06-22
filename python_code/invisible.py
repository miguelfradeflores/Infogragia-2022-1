import cv2
import numpy as np
import pandas as pd



cap = cv2.VideoCapture(0)

bg = None

color_low_1 = np.array([0,150,40], np.uint8)
color_upper_1 = np.array([8,255,250], np.uint8)
color_low_2 = np.array([170,150,40], np.uint8)
color_upper_2 = np.array([180,250,255], np.uint8)


while True:
	ret, frame = cap.read()
	if ret == False: break

	if bg is None:
		bg=frame

	frameHSV = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

	redMask1 = cv2.inRange(frameHSV, color_low_1, color_upper_1)
	redMask2 = cv2.inRange(frameHSV, color_low_2, color_upper_2)

	mask = cv2.add(redMask1, redMask2)
	mask = cv2.medianBlur(mask, 15)

	area_color = cv2.bitwise_and(bg, bg, mask=mask)
	inv_mask = cv2.bitwise_not(mask)
	sin_area_color = cv2.bitwise_and(frame, frame, mask=inv_mask)
	final_frame = cv2.addWeighted(area_color, 1, sin_area_color, 1, 0)

	cv2.imshow("frame", frame)
	# cv2.imshow("area_color", area_color)
	cv2.imshow("inv_mask", inv_mask)
	cv2.imshow("sin area color", sin_area_color)
	# cv2.imshow("mask", mask)
	cv2.imshow("fin", final_frame)

	if cv2.waitKey(28) & 0xFF == ord('q'):
		break




cap.release()
cap.destroyAllWindows()