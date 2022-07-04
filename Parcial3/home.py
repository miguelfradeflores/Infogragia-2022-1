from click import style
import pandas as pd
from flask import Flask, render_template,request,redirect,url_for
import os
from os.path import join,dirname,realpath
import sys
from pyecharts import options as opts
from pyecharts.charts import Bar,Scatter,Pie,Line

app = Flask(__name__)

UPLOAD_FOLDER = 'static/files'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

file_path = ''
styleGraph = ''
params = {}

def analizeCSV():
    global str_col,num_col,data
    data = pd.read_csv(file_path)
    str_col=list(data.select_dtypes(include=['string']))
    num_col=list(data.select_dtypes(include=['number']))
    str_col_names=list(data.select_dtypes(exclude=['number']).columns)
    num_col_names=list(data.select_dtypes(include=['number']).columns)
    return str_col_names,num_col_names
def ShowGraph():
    global styleGraph,colA,colB,data
    c = None
    if styleGraph=='Scatter':
        c = (
            Scatter()
            .set_global_opts(
                title_opts = opts.TitleOpts (title = "Scatter graph"),
                xaxis_opts=opts.AxisOpts(type_="value"),
                yaxis_opts=opts.AxisOpts(type_="value"),
            )
        )
        for i in range(0,len(colA)):
            c.add_xaxis(list(data[colA[i]]))
            c.add_yaxis(series_name='Conf '+str(i),y_axis=list(data[colB[i]]))
    elif styleGraph=='Lineal':
        c = (
            Line()
            .set_global_opts(
                    title_opts = opts.TitleOpts (title = "Grafica lineal"),
                    xaxis_opts=opts.AxisOpts(type_="value"),
                    yaxis_opts=opts.AxisOpts(type_="value"),
            )
        )
        for i in range(0,len(colA)):
            c.add_xaxis(list(data[colA[i]]))
            c.add_yaxis(series_name='Conf '+str(i),y_axis=list(data[colB[i]]))
    elif styleGraph=='Bar':
        c = (
        Bar()
            .add_xaxis (list(data[colA[0]]))
            .set_global_opts (title_opts = opts.TitleOpts (title = "Barras", subtitle = "Extraidas CSV"))
        )
        for col in colB:
            c.add_yaxis(col,list(data[col]))
    elif styleGraph=='BarY':
        c = (
        Bar()
            .add_xaxis (list(data[colA[0]]))
            .set_global_opts (title_opts = opts.TitleOpts (title = "Barras", subtitle = "Extraidas CSV"))
        )
        for col in colB:
            c.add_yaxis(col,list(data[col]))
        c = c.reversal_axis()
    elif styleGraph=='Pie':
        c = (
            Pie()
            .set_global_opts(
                    title_opts = opts.TitleOpts (title = "Grafica lineal"),
                    
            )
        )
        data_pair = [list(z) for z in  list(zip(list(data[colA[0]]),list(data[colB[0]])))]
        c.add(series_name=colA[0],data_pair=data_pair,)
    return c.dump_options_with_quotes()
@app.route("/")
def homePage():
    return render_template('Inicio.html')

@app.route("/app")
def appPage():
    return render_template('graphs.html',params = params)

@app.route("/app",methods=['POST'])
def uploadFiles():
    global file_path
    upload_file = request.files['file']
    if upload_file.filename == '':
        return redirect(url_for('appPage'))   
         
    if upload_file.filename != '':
        file_path = os.path.join(app.config['UPLOAD_FOLDER'],'file.csv')
        upload_file.save(file_path)
    return redirect(url_for('loadAttrPag'))

@app.route('/app/attr')
def loadAttrPag():
    global params
    strCol,numCol = analizeCSV()
    params['strCol']=strCol
    params['numCol']=numCol
    return render_template('graphs.html',params = params)

@app.route('/app/attrGet',methods=["POST"])
def buildData():
    global styleGraph,colA,colB
    colA = request.form.getlist('colA[]')
    colB = request.form.getlist('colB[]')
    styleGraph = request.form.get('style')
    print(colA, file=sys.stderr)
    print(colB, file=sys.stderr)
    return ShowGraph()



if __name__ == '__main__':
    app.run(debug=True)