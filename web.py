from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.common.by import By

from webdriver_manager.chrome import ChromeDriverManager
import time 
import cv2 
import argparse
import os

try:
    from PIL import Image
    from PIL import ImageEnhance
    from PIL import ImageFilter
except ImportError:
    import Image 
import pytesseract
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files (x86)\Tesseract-OCR\tesseract'

from scipy import misc,ndimage

# Fuction read text
def ocr_core(filename):
    text = pytesseract.image_to_string( Image.open('more-contrast.png'))
    return text

driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()))




driver.get("https://ruat.gob.bo/vehiculos/consultadetallada/InicioBusquedaVehiculo.jsf")
driver.implicitly_wait(0.5)

searchIdBox = driver.find_element(by=By.NAME, value="busqueda:frmBusquedaVehiculo:pnl-datosbusqueda:identificador-placapta:ruatInputText")
searchOwnerBox = driver.find_element(by=By.NAME, value="busqueda:frmBusquedaVehiculo:pnl-datosbusqueda:certificadoPropiedad:ruatInputText")
searchButton = driver.find_element(by=By.NAME, value="busqueda:frmBusquedaVehiculo:pnl-datosbusqueda:j_idt118")
image = driver.find_element(by=By.XPATH, value="/html/body/div[3]/div[3]/div/form[1]/div/div[2]/span[2]/div/div[2]/div[1]/img[2]")


# get image
with open('captcha.png', 'wb') as file:
    file.write(image.screenshot_as_png)
image = Image.open('captcha.png')

imageL = image.convert('L')
bw1 = imageL.point(lambda p: p > 191 and 255)
bw1.save("point-point.png")
bw2 = imageL.point(lambda p: p > 120 and 255)
bw2.save("point.png")



enh = ImageEnhance.Contrast(imageL)
imageLC = enh.enhance(1.8)
imageLC.save("more-contrast.png")
imageLCC = enh.enhance(3.6)
imageLCC.save("more-more-contrast.png")
time.sleep(5)
# im1 = imageL.filter(ImageFilter.CONTOUR).show("Con")
# im1 = imageL.filter(ImageFilter.DETAIL).show("De")
# im1 = imageL.filter(ImageFilter.SMOOTH).show("smo")


print("captcha Original")
print("Original :",ocr_core("captcha.png"))

print("captcha Contraste")
print("contrast 1.8:",ocr_core("more-contrast.png"))

print("captcha Contraste")
print("contrast 3.6:",ocr_core("more-more-contrast.png"))

print("captcha point")
print("contrast 191:",ocr_core("point-point.png"))

print("captcha point")
print("contrast 120:",ocr_core("point.png"))


# other library 
img = cv2.imread('point-point.png',flags=0) 
img_blur = cv2.GaussianBlur(img,(5,5), sigmaX=0, sigmaY=0)
cv2.imwrite("imagebluer.png", img_blur)

sobelxy = cv2.Sobel(src=img_blur, ddepth=cv2.CV_64F, dx=1, dy=1, ksize=5)
cv2.imwrite("sobel.png", sobelxy)

edges = cv2.Canny(image=img_blur, threshold1=100, threshold2=200)
cv2.imwrite("edge.png", edges)


print("captcha edges")
print("Edge:",ocr_core("edge.png"))
# Thhresholding
img = cv2.imread('more-contrast.png', cv2.IMREAD_GRAYSCALE)
th,dst = cv2.threshold(img, 0, 255, cv2.THRESH_BINARY)
cv2.imwrite("threshold.png", dst)

# Thhresholding
image = cv2.imread('captcha.png')
img_gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
ret, thresh = cv2.threshold(img_gray, 150, 255, cv2.THRESH_BINARY)
cv2.imwrite('thres.png', thresh)
print("captcha thres")
print("thres :",ocr_core("thres.png"))

image = Image.open('thres.png')
enh = ImageEnhance.Contrast(image)
imageLC = enh.enhance(0.2)
imageLC.save("less-contrast.png")
print("thres-less :",ocr_core("less-contrast.png"))


sr = cv2.dnn_superres.DnnSuperResImpl_create()
sr.readModel("EDSR_x4.pb")
sr.setModel("edsr", 4)

image = cv2.imread("point-point.png")
print("[INFO] w: {}, h: {}".format(image.shape[1], image.shape[0]))
start = time.time()
upscaled = sr.upsample(image)
end = time.time()
print("[INFO] super resolution took {:.6f} seconds".format(	end - start))
print("[INFO] w: {}, h: {}".format(upscaled.shape[1],	upscaled.shape[0]))
im = Image.fromarray(upscaled)
im.save("upscaled.png")

print("captcha resolution")
print("resolution:",ocr_core("upscaled.png"))


searchIdBox.send_keys("6416HTE")
# searchButton.click()


title = driver.title
print(title)
time.sleep(100)


driver.quit()

