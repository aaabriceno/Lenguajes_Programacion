cantidadPares::[Int]->Int
cantidadPares [] = 0
cantidadPares (x:xs)
 | x `mod` 2 == 0 = 1 + cantidadPares xs
 | otherwise = cantidadPares xs

main::IO()
main = print(cantidadPares [0,1,2,3,4,5,6,8,10,12])