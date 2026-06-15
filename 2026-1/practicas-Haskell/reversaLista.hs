import Text.XHtml (rev)
reversaLista::[Int]->[Int]
reversaLista [] = []
reversaLista [x] = [x]
reversaLista (x:xs) = reversaLista xs ++ [x]

main::IO()
main = print(reversaLista [1,2,3,4,5,6,7])