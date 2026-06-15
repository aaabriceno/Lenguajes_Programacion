primeros3::Int->[Int]->[Int]
primeros3 _ [] = []
primeros3 0 _ = []
primeros3 numero (x:xs) = x: primeros3 (numero-1) xs

main::IO()
main = print (primeros3 3 [-1,2..120] )