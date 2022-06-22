from flask import Flask, render_template


UPLOAD_FOLDER = '/static/'

# allow files of a specific type
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg'])

app = Flask(__name__)
@app.route("/")
def home():

    texto="Una cadena muy grande de texto"
    msg = "Otra nueva forma de pasar parametros"
    return render_template("home.html", 
        texto=texto, 
        msg=msg,
        img_src = "/static/black.jpeg"
        )

if __name__ == "__main__":
    app.run(debug=True)
