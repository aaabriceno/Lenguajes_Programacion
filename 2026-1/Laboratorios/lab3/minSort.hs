{-Escribir una función que implemente el algoritmo como descrito abajo.
minsort :: [Int] ->; [Int]
Para una lista vacía, el algoritmo retorna la lista vacía. Para una lista no vacía, el algoritmo min
sort primero calcula el mínimo de la lista, borra el mínimo de la lista y luego llama a sí mismo
con la lista restante. De la secuencia de mínimos calculados construye la lista ordenada.-}

minSort::[Int]->[Int]
minSort [] = []
minSort xs = minimoDeLista xs: minSort (eliminarPrimeraOcurrencia (minimoDeLista xs) xs )
--primero buscamos el menor elemento de toda la lista.
--ese minimo lo colocamos al inicio de la nueva lista ordenada
--luego eliminamos solo la primera vez que aparece ese minimo en la lista original.
--despues llama otra vez a minSort con la lista restante hasta que ya no queden elementos.

minimoDeLista::[Int] -> Int
minimoDeLista [x] = x
minimoDeLista (x:xs) 
    | x <= minimoDeLista xs = x
    --comparamos x con el minimo del resto de la lista.
    --si x es menor o igual entonces x pasa a ser el minimo total.
    | otherwise = minimoDeLista xs

eliminarPrimeraOcurrencia::Int->[Int]->[Int]
eliminarPrimeraOcurrencia _ [] = []

eliminarPrimeraOcurrencia numero (x:xs) 
    | numero == x = xs
    | otherwise = x:eliminarPrimeraOcurrencia numero xs

main :: IO ()
main = do
  print (minSort [4,1,3,2])
  print (minSort [10,5,8,1,9])
  print (minSort [])
  print (minSort [12,34,56,-20,-45,97])