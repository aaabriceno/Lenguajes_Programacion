--Calculadora basica suma - resta - multiplicacion - division
--suma :: Int -> Int -> Int
suma a b = a + b

--resta :: Int -> Int -> Int
resta a b = a - b

--multi :: Int -> Int -> Int
multi a b = a * b

--divi :: Int -> Int -> Int
divi a b = a `div` b

main :: IO()
main = do
  print (suma 12 3)
  print (resta 12 4)
  print (multi 3 4)
  print (divi 6 3)