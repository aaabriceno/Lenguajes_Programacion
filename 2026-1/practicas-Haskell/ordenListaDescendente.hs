{-
Cree una función que reciba una lista y
 evalúe si esta está ordenada en forma 
 descendente (devuelve verdadero o falso).
-}

ordenListaDescendente::[Int] -> Bool
ordenListaDescendente [] = True
ordenListaDescendente [x] = True
ordenListaDescendente (x:y:xs) 
 | x < y = False
 | otherwise = ordenListaDescendente (y:xs) 

main::IO()
main = print(ordenListaDescendente[12,1,2,1,0])