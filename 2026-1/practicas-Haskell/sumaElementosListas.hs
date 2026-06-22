suma::[Int]-> Int
suma [] = 0
suma (x:xs) = x + sum xs

main::IO()
main = print (suma [1..10])