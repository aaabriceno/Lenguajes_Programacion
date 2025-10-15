--Indicar si un numero es par o impar (Imprimir texto)
num_par_impar :: Int -> String
num_par_impar numero 
  | numero `mod` 2 == 0 = "Numero par"
  | otherwise = "Numero impar"
  
main::IO()
main = print(num_par_impar (13))