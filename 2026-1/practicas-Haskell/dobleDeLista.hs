dobleDeLista::[Int] -> [Int]
dobleDeLista [] = []
dobleDeLista (x:xs) = x*2 : dobleDeLista xs
main::IO()
main = print (dobleDeLista [1,2,3,4,5,6,42,23,34])
