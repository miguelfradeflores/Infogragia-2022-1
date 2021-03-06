import cv2
import sys

# Get user supplied values
imagePath = "abba.png"
cascPath = "haarcascade_frontalface_default.xml"

# Create the haar cascade
faceCascade = cv2.CascadeClassifier(cascPath)

# Read the image
image = cv2.imread(imagePath)
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# Detect faces in the image
faces = faceCascade.detectMultiScale(
    gray,
    scaleFactor=1.1,
    minNeighbors=5,
    minSize=(30, 30)
    #flags = cv2.CV_HAAR_SCALE_IMAGE
)

print("Found {} faces!".format(len(faces)))

print(faces)
# Draw a rectangle around the faces
for (x, y, w, h) in faces:
    cv2.rectangle(image, (x, y), (x+w, y+h), (0, 255, 0), 2)
    # noseX = x+(w/2)
    # noseY = y +(h/2)
    # noseSizeX = noseX+20
    # noseSizeY = noseY+20
    # print(noseX,noseY,noseSizeX,noseSizeY)
    # cv2.rectangle(image, (x, y), (noseSizeX, noseSizeY), (0, 0,255 ), 2)
cv2.imshow("Faces found", image)
cv2.waitKey(0)
