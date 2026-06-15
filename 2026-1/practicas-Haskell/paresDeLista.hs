paresDeLista:: [Int] -> [Int]
paresDeLista [] = []
paresDeLista (x:xs) 
    | x `mod` 2 == 0 = x:paresDeLista xs
    | otherwise = paresDeLista xs

main::IO()
main = print(paresDeLista [1,2,3,4,5,6,7,8,9])