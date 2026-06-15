import Language.Haskell.TH (prim)
perteneceLista::[Int]->Int->Bool
perteneceLista [] numero = False
perteneceLista (x:xs) numero
 | x == numero = True
 | otherwise = perteneceLista xs numero

main::IO()
main = print(perteneceLista [1,2,3,4,5] 6)