from selenium import webdriver
import os
import time

dir = os.path.dirname(__file__)
print(dir)

chrome_driver = dir + "\chromedriver.exe"
driver = webdriver.Chrome(chrome_driver)

driver.get("https://bch.gestora.bo/ConsultaBono")
time.sleep(5)
campo_ci = driver.find_element_by_xpath("//*[@id=\"Parametro_numeroCarnetIdentidad\"]")
campo_ci.send_keys("6096568")


campo_templo = driver.find_element_by_xpath("//*[@id=\"Parametro_complemento\"]")
campo_templo.send_keys("-1B")