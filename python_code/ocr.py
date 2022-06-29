try:
    from PIL import Image
except ImportError:
    import Image
import pytesseract
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract'

def ocr_core(file):

    text = pytesseract.image_to_string(Image.open(file))
    return text


print( ocr_core("descarga.png"))
