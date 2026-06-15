--multiplicar todos los elementos de una lista
productoLista::[Int] -> Int
productoLista [] = 1
productoLista (x:xs) = x * productoLista(xs) 

main::IO()
main = print(productoLista [1,2,3])