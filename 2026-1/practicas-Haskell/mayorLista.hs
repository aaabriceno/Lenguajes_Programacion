mayorLista::[Int]-> Int
mayorLista [] = 0
mayorLista [x] = x
mayorLista (x:y:xs) = 
    if x < y then mayorLista (y:xs)
    else mayorLista (x:xs)


main::IO()
main = print( mayorLista [1..12])
