longitudLista::[Int]->Int
longitudLista [] = 0
longitudLista (x:xs) = 1 + longitudLista(xs)


main::IO()
main = print(longitudLista [1,4])