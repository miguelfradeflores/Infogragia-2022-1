from flask import Flask, render_template

app = Flask(__name__)


@app.route("/")
def home():
    texto = "Cadena de texto para poner menus"

    return render_template("index.html", 
        nuevo_texto = texto
    
    )


@app.route("/pagina", methods=["POST"])
def pagina2():
    texto = "Cadena de texto para poner menus"

    return render_template("pagina.html", 
        nuevo_texto = texto,
        imagen_cargada = 'static/black.jpeg'
    )

if __name__ ==  '__main__':
    app.run(debug=True)
