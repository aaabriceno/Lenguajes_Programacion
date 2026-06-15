{-
Crea una función que reciba una listas y genere todas sus 
sublistas (recordar teoria de conjuntos)-}

sublistas :: [Int] -> [[Int]]
sublistas [] = [[]]
sublistas (x:xs) = sub_xs ++ agregar x sub_xs
  where
    sub_xs = sublistas xs

agregar :: Int -> [[Int]] -> [[Int]]
agregar _ [] = []
agregar x (y:ys) = (x:y) : agregar x ys

main :: IO ()
main = print (sublistas [1,2,3])