mayorDeNumeros::Int->Int->Int->Int->Int
mayorDeNumeros a b c d
    | a >= b && a >= c && a >= d = a
    | b >= a && b >= c && b >= d = b
    | c >= a && c >= b && c >= d = c
    | otherwise = d

main::IO()
main = print (mayorDeNumeros 11 12 12 1)