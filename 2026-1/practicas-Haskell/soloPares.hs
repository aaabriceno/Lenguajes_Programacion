soloPares::[Int]->[Int]
soloPares [] = []
soloPares (x:xs)
    | even x = x:soloPares xs
    | otherwise = soloPares xs

main::IO()
main = print(soloPares [2,3,4,5,6])