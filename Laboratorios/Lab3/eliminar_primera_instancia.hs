--Escribir una funcion que elimine la primera instancia de un numero en una lista
eliminar_instancia :: Int-> [Int] -> [Int]
eliminar_instancia _ [] = []
eliminar_instancia numero (x:xs)
  | numero == x = xs
  | otherwise   = x : eliminar_instancia numero xs
main :: IO ()
main = print ( eliminar_instancia 2 [12,2,22,12,5,67])