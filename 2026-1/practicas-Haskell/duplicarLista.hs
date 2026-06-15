duplicarLista::[Int]->[Int]
duplicarLista [] = []
duplicarLista xs = [x*2| x <- xs]

main::IO()
main = print(duplicarLista [1,2,3,4,5,6])