esPar::Int -> Bool
esPar numero 
    | numero `mod` 2  == 0 = True
    | otherwise = False
main::IO()
main = print (esPar 9)