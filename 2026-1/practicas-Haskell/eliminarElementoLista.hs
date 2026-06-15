{-
Definir la función que reciba un número (elemento) y una 
lista de números, y devuelva la lista 
sin el elemento en mención.-}



{-
eliminarPosicion :: Int -> [Int] -> [Int]
eliminarPosicion _ [] = []
eliminarPosicion 1 (_:xs) = xs
eliminarPosicion n (x:xs) = x : eliminarPosicion (n-1) xs
-}

eliminarElemento :: Int -> [Int] -> [Int]
eliminarElemento _ [] = []
eliminarElemento n (x:xs)
 | n == x = eliminarElemento n xs
 | otherwise = x : eliminarElemento n xs

main :: IO ()
main = print (eliminarElemento 3 [1,3,2,3,4,3,5])