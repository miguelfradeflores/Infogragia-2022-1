from platform import release
from turtle import width
import numpy as np
import cv2

print('Hello world')
dicti = {
    'nombre':'Juda',
    'altura':12,
    'edad':22
}
print(dicti.keys())
print(dicti.get('apellido','Villalta'))
print(dicti)

# fondo = cv2.imread("1.jpg")

# print(fondo)

# cv2.imshow("fondo",fondo)
# fondo_gray = cv2.cvtColor(fondo,cv2.COLOR_RGB2GRAY)
# cv2.imshow("fondo_gray",fondo_gray)

# fondo_hsv = cv2.cvtColor(fondo,cv2.COLOR_RGB2HSV)
# cv2.imshow("fondo_hsv",fondo_hsv)

# cv2.waitKey(10000)

def vacia(x):
    pass

cam = cv2.VideoCapture(0)
# cv2.namedWindow("Barra colores")
# cv2.createTrackbar("low_hue","Barra colores",0,180,vacia)
# cv2.createTrackbar("up_hue","Barra colores",179,1790,vacia)
# cv2.createTrackbar("low_sat","Barra colores",0,255,vacia)
# cv2.createTrackbar("up_sat","Barra colores",255,255,vacia)
# cv2.createTrackbar("low_val","Barra colores",0,255,vacia)
# cv2.createTrackbar("up_val","Barra colores",255,255,vacia)

low = np.array([50,50,50])
up = np.array([70,250,200])

while True:
    _,frame = cam.read()
    # hl = cv2.getTrackbarPos("low_hue","Barra colores")
    # hu = cv2.getTrackbarPos("up_hue","Barra colores")
    # sl = cv2.getTrackbarPos("low_sat","Barra colores")
    # su = cv2.getTrackbarPos("up_sat","Barra colores")
    # vl = cv2.getTrackbarPos("low_val","Barra colores")
    # vu = cv2.getTrackbarPos("up_val","Barra colores")

    width,height,_=frame.shape

    cw2 = int(width/2)
    ch2 = int(height/2)



    # frame_hsv = cv2.cvtColor(frame,cv2.COLOR_RGB2HSV)
    # cv2.imshow("camara hsv",frame_hsv)

    pixel_center = frame_hsv[cw2,ch2]
    # print(pixel_center)
    pixel_center_BGR=frame[cw2,ch2]
    hue_value = pixel_center[0]
    b,g,r = int(pixel_center_BGR[0]),int(pixel_center_BGR[1]),int(pixel_center_BGR[2])

    # cv2.putText(frame,"COLOR",(10,70),0,1.5,(b,g,r),5)
    cv2.circle(frame,(ch2,cw2),4,(255,0,0),5)

    
    low = np.array([b-10,g-10,r-10])
    up = np.array([b+5,g+25,r+25])
    cv2.imshow("camara",frame)


    mascara_color=cv2.inRange(frame,low,up)
    cv2.imshow('Mascara Color',mascara_color)



    key = cv2.waitKey(1)
    if key == 27:
        break

cam.release()
cv2.destroyAllWindows()