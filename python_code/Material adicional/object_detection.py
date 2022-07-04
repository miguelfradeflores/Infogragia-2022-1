from imageai.Detection import ObjectDetection
import os


execution_path = os.getcwd()

detector = ObjectDetection()
detector.setModelTypeAsRetinaNet()
detector.setModelPath(os.path.join(
    execution_path,
    "resnet50_coco_best_v2.1.0.h5"))

detector.loadModel()
detections = detector.detectObjectsFromImage(
    input_image=os.path.join(execution_path, "street.jpeg"),
    output_image_path=os.path.join(execution_path, "result.jpg")
)

for object in detections:
    print(object["name"], " : ", object["porcentage_probability"])