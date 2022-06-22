from Flask import Flask, render_template, request
from flask_restful import Resource, Api, reqparse
import pandas as pd
import ast
# from ocr_core import ocr_core
import json

# define a folder to store and later serve the images
UPLOAD_FOLDER = '/uploads/'

# allow files of a specific type
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg'])

app = Flask(__name__)
api = Api(app)

class Users(Resource):
    def get(self):
        data = pd.read_csv("alumnos.csv")
        data = data.to_dict()
        return {'data': json.dumps(data)}, 200  # return data and 200 OK



# function to check the file extension
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route("/")
def home():
    #return "Hola from flask server in port 5000"
    print("hola mundo")
    extracted_text = ocr_core("handWritten.png")
    #return render_template("upload.html", extracted_text=extracted_text)
    return "Hello world!"

@app.route('/upload', methods=['GET', 'POST'])
def upload_page():
    if request.method == 'POST':
        # check if there is a file in the request
        print("on posting")
        print("request", request)
        print(request.files)
        print(request.form)
        if 'file' not in request.files:
            print("no files")

            return render_template('upload.html', msg='No file selected')
        file = request.files['file']
        # if no file is selected
        if file.filename == '':
            print("invalid file name")
            data = pd.read_csv("alumnos.csv")
            data = data.to_dict()
            return {'data': data}
#            return render_template('upload.html', msg='No file selected')

        if file and allowed_file(file.filename):

            # call the OCR function on it
            extracted_text = ocr_core(file)

            # extract the text and display it
            return render_template('upload.html',
                                   msg='Successfully processed',
                                   extracted_text=extracted_text,
                                   img_src=UPLOAD_FOLDER + file.filename)
    elif request.method == 'GET':

        return render_template('upload.html')


api.add_resource(Users, '/users')  # add endpoint
if __name__ == "__main__":
    # root.info("mostrar logs")
    app.run()
