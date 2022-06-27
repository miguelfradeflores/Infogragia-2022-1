from pickle import FRAME
from cv2 import cvtColor
import numpy as np
import cv2


print("Hello world in python!")

variable_numericas = 3453234567897868
variable_double = 53453.2342

print(variable_numericas, variable_double)
print(type(variable_double), type(variable_numericas))

variable_string = "Algun texto"

print(type(variable_string), variable_string)
variable_booleano = True
variable_arreglo = [1,2,3,4, 6]

print(type(variable_booleano), variable_booleano)
print(type(variable_arreglo), variable_arreglo)

variable_dictionary = {
    "altura": 1.63,
    "edad": 27,
    "nombre": "Marcel"
}

print(type(variable_dictionary), variable_dictionary, variable_dictionary["edad"])

print(len(variable_arreglo))

compre_list = [
    i for i in variable_arreglo if isinstance(i,int) and i%2 ==0
]

print(compre_list)

if variable_booleano:
    print("esta bloque esta en el if")
    for k,v in variable_dictionary.items():
        print(k, v)
else:
    print("esta parte esta ejecutada en el else")

print(variable_dictionary.keys())
print(variable_dictionary.get("apellido", "Barrero"))


# fondo =  cv2.imread("1.jpg")

# #print(fondo)


# cv2.imshow("fondo", fondo)

# fondo_gray = cv2.cvtColor(fondo, cv2.COLOR_RGB2GRAY )
# cv2.imshow("fondo2", fondo_gray)
# fondo_hsv = cv2.cvtColor(fondo, cv2.COLOR_RGB2HSV)
# cv2.imshow("fondo_hsv", fondo_hsv)
# print(fondo_hsv)

# cv2.waitKey(0)

def vacia(x):
    pass

cam = cv2.VideoCapture(0)
cv2.namedWindow("Barra_colores")
cv2.createTrackbar("low_hue", "Barra_colores", 0, 180, vacia)
cv2.createTrackbar("up_hue", "Barra_colores", 179, 1790, vacia)
cv2.createTrackbar("low_sat", "Barra_colores", 0, 255, vacia)
cv2.createTrackbar("up_sat", "Barra_colores", 255, 255, vacia)
cv2.createTrackbar("low_val", "Barra_colores", 0, 255, vacia)
cv2.createTrackbar("up_val", "Barra_colores", 255, 255, vacia)



# rango naranja segun Mauricio
# low = np.array([10, 50, 50])
# up = np.array([30, 200, 200])

low2 = np.array([140, 150, 150])
up2 = np.array([150, 255, 255])



while True:

    _, frame = cam.read()
    # print(frame.shape)

    # hl = cv2.getTrackbarPos("low_hue", "Barra_colores")
    # hu = cv2.getTrackbarPos("up_hue", "Barra_colores")
    # sl = cv2.getTrackbarPos("low_sat", "Barra_colores")
    # su = cv2.getTrackbarPos("up_sat", "Barra_colores")
    # vl = cv2.getTrackbarPos("low_val", "Barra_colores")
    # vu = cv2.getTrackbarPos("up_val", "Barra_colores")

    width, height, _ = frame.shape

    cw2 = int(width/2)
    ch2 = int(height/2)



    # print(np.shape(frame))

   
    # low = np.array([hl,sl,vl ])
    # up = np.array([hu,su,vu ])
    # mascara_de_color = cv2.inRange(frame,low, up)
    # cv2.imshow("Mascara naranja", mascara_de_color)

    frame_hsv = cv2.cvtColor(frame, cv2.COLOR_RGB2HSV)
    cv2.imshow("frame_hsv", frame_hsv)

    pixel_center = frame_hsv[ch2, cw2]
    print(pixel_center)
    pixel_center_BGR = frame[cw2,ch2]
    hue_value = pixel_center[0]
    b,g, r = int(pixel_center_BGR[0]), int(pixel_center_BGR[1]), int(pixel_center_BGR[2])


    cv2.putText(frame, "COLOR", (10,70), 0, 1.5, (b,g,r), 5)
    cv2.circle(frame, (ch2,cw2), 8, (255,0,0), 5)
    cv2.imshow("camara", frame)
    mascara_de_color2 = cv2.inRange(frame,np.array([b-10,g-10,r-10]), np.array([b+5,g+25,r+25]))
    cv2.imshow("Mascara morada", mascara_de_color2)

    key = cv2.waitKey(1)
    if key ==27:
        break

cam.release()
cv2.destroyAllWindows()
