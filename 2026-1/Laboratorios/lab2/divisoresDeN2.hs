divisoresDeN::Int->[Int]
divisoresDeN numero = [x|x <- [1..numero], numero `mod` x == 0]

main::IO()
main = print (divisoresDeN 12)