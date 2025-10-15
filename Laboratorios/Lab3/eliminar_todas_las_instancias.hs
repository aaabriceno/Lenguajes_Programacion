--Escribir una funcion que elimine todas las instancias de un numero en una lista
eliminar_todo :: Int-> [Int] -> [Int]
eliminar_todo _ [] = []
eliminar_todo numero (x:xs)
  | numero == x = eliminar_todo numero xs
  | otherwise   = x : eliminar_todo numero xs
main :: IO ()
main = print ( eliminar_todo 2 [2,2,22,2,5,67])