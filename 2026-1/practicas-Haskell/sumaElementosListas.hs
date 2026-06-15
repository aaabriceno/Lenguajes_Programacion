suma::[Int]-> Int
suma [] = 0
suma (x:xs) = sum (xs) + x

main::IO()
main = print (suma [1..10])