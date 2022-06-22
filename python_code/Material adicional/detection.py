from imageai.Detection import ObjectDetection
import os

execution_path = os.getcwd()


print(execution_path)

detector = ObjectDetection()
detector.setModelTypeAsRetinaNet()
detector.setModelPath("resnet50_coco_best_v2.1.0.h5")

detector.loadModel()

results = detector.detectObjectsFromImage(
    input_image="street.jpeg",
    output_image_path="resultado2.jpg"
)


for objetos in results:
    #print(objetos.keys())
    print(objetos.get("name"), " : ", objetos.get("percentage_probability"),  " : ", objetos.get("box_points"))
