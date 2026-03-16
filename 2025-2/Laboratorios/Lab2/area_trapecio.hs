--Indicar el area de un trapecio
area_trapecio :: Float -> Float -> Float -> Float
area_trapecio base_mayor base_menor altura = ((base_mayor + base_menor)/2 * altura)
  
main::IO()
main = print (area_trapecio 12 8 3.5)