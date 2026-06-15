import Language.Haskell.TH (SumAlt)
sumaLista::[Int]->Int
sumaLista [] = 0
sumaLista (x:xs) = x + sumaLista(xs)

main::IO()
main = print(sumaLista [1,2,3,4,5,65,7])