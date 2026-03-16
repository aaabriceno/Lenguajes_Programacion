--mayor de 4 numeros
mayor_de_4_numeros :: Int -> Int -> Int -> Int-> Int
mayor_de_4_numeros a b c d 
  | a > b && a > c && a > d = a
  | b > c && b > d = b
  | c > d = c
  | otherwise = d
main :: IO ()
main = print (mayor_de_4_numeros 1 21 4 6)