factorial:: Int -> Int
factorial 0 = 1
factorial 1 = 1
factorial numero = numero * factorial(numero - 1)

main::IO()
main = print (factorial 5)


