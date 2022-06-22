import tkinter as tk
from turtle import width
from typing import Text


window = tk.Tk()
window.geometry("400x500")
#window.resizable(width=500, height=400)
window.title("Sistema de facturas")
Text(window, "")

button = tk.Button(window, text="Cargar csv", width=30)
# button.pack()
button.grid(row=3)
l1 = tk.Label(window, text = "Nombre del archivo")
l1.grid(row=2, column=0)
e1 = tk.Entry(window)
e1.grid(row=2, column=1)

window.mainloop()