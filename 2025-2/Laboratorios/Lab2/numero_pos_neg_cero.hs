--Indicar si un numero es positivo, negativo o cero
pos_neg_cero :: Int -> String
pos_neg_cero a 
  | a > 0 = "Numero positivo"
  | a == 0 = "Cero"
  | otherwise = "Numero negativo"

main::IO()
main = do  
  print( pos_neg_cero (-23))
  print( pos_neg_cero (0))
  print( pos_neg_cero (2))