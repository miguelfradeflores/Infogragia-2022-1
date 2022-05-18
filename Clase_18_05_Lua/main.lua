-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
print("Hello world!")

numero = 5

print( numero )

caracteres = "s"
cadena2 = "mas texto"

print(caracteres, cadena2)

arreglo = {23, 22}

print( arreglo[3] )

print(true)

persona = {
	edad = 27,
	estatura = 1.89
}

print( persona["edad"] )


print( type(cadena2), type( numero ), type( arreglo ), type(persona), type(false), type(print ) )

if (25>30 and true) or persona.estatura < 1.5 then 
	print( "eSTOY DENTRO DEL IF" )
elseif persona.edad == 27 then
	print( "Estoy en el elseif" )
else
	print( "Estoy en el else" )
end
print( "Dimensiones del arreglo", #persona)

for i=1, -1,1  do
	print( i )
end

for k,v in pairs(persona) do
	print(k,v)
end

for i,v in ipairs(arreglo) do
	print(i,v)
end


for i=1, #arreglo do
	print(arreglo[i])
end

i=1

while i<10 do
	print("Iteracion de I:",i)
	i= i+1
end

j=1

repeat
	print( j )
	j = j+1
until j>5


function sumar( a ,b  )
	return a+b
end

print(sumar(4,7))


function factorial(n)
	resultado = 1
	for i =1, n,1 do
		resultado = resultado * i
	end
	return resultado
end

function factorial2 (n)

	if n==0 then
		return 1
	else
		return n * factorial2(n-1)  -- 6 * factorial(6-1) -- 6 * 5 *factoorial(5-1) -- 30 * factorial(4)
	end
end
print("Factorial de N", factorial(5))

print("Factorial recursivo", factorial2(6))

function fibonacci(n)

	a = 0
	b = 1
	c = 1
	d = 2

	for i=1, n, 1 do
		resultado = a + b
		a = b
		b = resultado
	end
	return resultado
end


function fibonacci2(n)
	if n == 0 then 
		return 0
	elseif n==1 then
		return 1
	else
		return fibonacci2(n-1) + fibonacci2(n-2)
	end
end

print("fibonacci2", fibonacci2(8))
print("fibonacci1", fibonacci(8))