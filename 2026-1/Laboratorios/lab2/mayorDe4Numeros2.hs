mayorDe4Numeros::Int->Int->Int->Int->Int
mayorDe4Numeros a b c d = max(max(max a b) c) d

main::IO()
main = print (mayorDe4Numeros 23 35 12 300)