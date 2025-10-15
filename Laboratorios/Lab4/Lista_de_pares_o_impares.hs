{-
Cree una función que ingrese dos elementos, una lista de números y un indicador (par o
impar) la cual retorna la lista de los pares/impares según corresponda (no usar función odd
ni even).
-}

lista_par_o_impar :: [Int] -> String -> [Int]
lista_par_o_impar [] _ = []
lista_par_o_impar (x:xs) indicador 
  | indicador == "par"   && x`mod`2 == 0 = x:lista_par_o_impar xs indicador
  | indicador == "impar" && x`mod`2 /= 0 = x:lista_par_o_impar xs indicador
  | otherwise = lista_par_o_impar xs indicador
  
main::IO()
main = print (lista_par_o_impar [1,2,3,4,5,6,7] "par")