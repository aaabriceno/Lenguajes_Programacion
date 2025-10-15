{-
Cree una función que reciba una lista y evalúe si esta está ordenada en forma descendente
(devuelve verdadero o falso).
-}

verificar_lista_descendente:: [Int] -> Bool
verificar_lista_descendente [] = True
verificar_lista_descendente [x] = True
verificar_lista_descendente (x:y:xs) 
  | x < y = False
  | otherwise = verificar_lista_descendente(y:xs)

main ::IO()
main = print (verificar_lista_descendente [12,11,10,3,2])
