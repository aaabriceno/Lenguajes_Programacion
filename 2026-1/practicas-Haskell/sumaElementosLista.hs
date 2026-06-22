type Lista = [Int]
a::Lista
a = [1,2,3,4,5,6,7,8,9]


sumarElementosLista::[Int]->Int
sumarElementosLista [] = 0
sumarElementosLista (x:xs) = foldl (+) x xs

main::IO()
main = print (sumarElementosLista a)