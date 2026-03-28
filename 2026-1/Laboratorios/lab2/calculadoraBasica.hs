suma::Int->Int->Int
suma numero1 numero2 = numero1 + numero2

resta::Int->Int->Int
resta numero1 numero2 = numero1 - numero2

multiplicacion:: Int->Int->Int
multiplicacion numero1 numero2 = numero1 * numero2

division::Int->Int->Int
division numero1 numero2 = numero1 `div` numero2

main::IO()
main = do
    print(suma 12 12)
    print(resta 23 12)
    print( multiplicacion 12 34)
    print( division 456 13)