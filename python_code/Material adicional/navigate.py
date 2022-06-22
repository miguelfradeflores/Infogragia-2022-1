import time
from selenium import webdriver
import os


dir = os.path.dirname(__file__)
print(dir)
chrome_driver_path = dir + "\chromedriver.exe"
driver = webdriver.Chrome(chrome_driver_path)
#driver = webdriver.Chrome("C:/Users/Miguel/Desktop\UPB/Infografia_2020/3er parcial")  # Optional argument, if not specified will search path.
driver.get('https://www.ruat.gob.bo/vehiculos/consultageneral/InicioBusquedaVehiculo.jsf')
time.sleep(5) # Let the user actually see something!
#search_box = driver.find_element_by_name('q')
box = driver.find_element_by_xpath("//*[@id='busqueda:frmBusquedaVehiculo:pnl-datosbusqueda:identificador-placapta:ruatInputText']")
box.send_keys('1456ABC')
captcha_box = driver.find_element_by_xpath("//*[@id=\"busqueda:frmBusquedaVehiculo:pnl-datosbusqueda:j_idt123:ruatCaptcha\"]")
captcha_box.send_keys("TEST")
#captcha_box.submit()
time.sleep(5) # Let the user actually see something!
driver.quit()
