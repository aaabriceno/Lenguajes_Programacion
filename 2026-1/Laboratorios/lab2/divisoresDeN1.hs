divisor::Int -> Int -> Bool
divisor numero1 numero2
    | numero1 `mod` numero2 == 0 = True
    | otherwise = False

listaDivisoresDeN::Int->[Int]-> [Int]
listaDivisoresDeN numero [] = []
listaDivisoresDeN numero (x:xs)
    | divisor numero x = x:listaDivisoresDeN numero xs
    | otherwise = listaDivisoresDeN numero xs

main::IO()
main = print (listaDivisoresDeN 120 [1..120])

