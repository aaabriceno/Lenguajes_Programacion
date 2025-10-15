--Generar los divisores de un numero
divisores_de_n :: Int -> [Int]
divisores_de_n numero = [x | x <- [1..numero], numero `mod` x == 0]

main :: IO()
main = print (divisores_de_n 122)