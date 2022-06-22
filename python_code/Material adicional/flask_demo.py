from flask import Flask, render_template, request, url_for
from flask_restful import Api, Resource
import pandas as pd
import json



app = Flask(__name__)
api = Api(app)


@app.route('/', methods=["POST", "GET"])
def home_page():
    if request.method=="GET":
        print("Entrando por el get")
    else:
        print("Entrando por el metodo post")

    texto = "Bienvenido a mi pagina web con flask meiante una variable"
    return render_template("index.html", texto_adicional=texto, booleano=True, imagen = "black.jpeg" )


@app.route("/metal", methods=["POST","GET"])
def mostartPaginaMetal():
    if request.method == 'POST':
       return render_template("Metal.html")

    else:
        pass
 

@app.route("/index", methods=["POST","GET"])
def mostrarIndice():
    texto = "Ya he cambiado de pagina mediante un nuevo metodo"
    return render_template("index.html", texto_adicional=texto, booleano=False )




class Alumnos(Resource):
    def get(self):
        alumnos = pd.read_csv("alumnos.csv")
        alumnos = alumnos.to_dict()
        return {"alumnos": json.dumps(alumnos)}, 200

api.add_resource(Alumnos, "/alumnos")


if __name__ == "__main__":
    app.run()