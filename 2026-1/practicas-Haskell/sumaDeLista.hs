sumaDeLista::[Int] -> Int
sumaDeLista [] = 0
sumaDeLista (x:xs) = x + sumaDeLista xs

main::IO()
main = print (sumaDeLista [1,2,3,4,5,6,7])