posNegCero::Int -> String
posNegCero numero
    | numero > 0 = "Es positivo"
    | numero < 0 = "Es negativo"
    | otherwise = "Es cero"

main::IO()
main = print (posNegCero (0))