ultimoElemento::[Int]->Int
ultimoElemento [x] = x
ultimoElemento (_:xs) = ultimoElemento xs 

main::IO()
main = print(ultimoElemento [1,2,3,4,5,6])