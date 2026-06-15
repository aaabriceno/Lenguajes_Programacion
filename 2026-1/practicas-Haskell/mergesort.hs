-- Mergesort en Haskell
-- Divide la lista en mitades, ordena cada una, y mezcla.

-- Mezcla dos listas YA ordenadas en una sola ordenada
merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
    | x <= y    = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys

-- Parte una lista en dos mitades
divide :: [a] -> ([a], [a])
divide xs = splitAt (length xs `div` 2) xs

-- Mergesort: caso base lista vacia o de 1 elemento; si no, divide y mezcla
mergesort :: Ord a => [a] -> [a]
mergesort []  = []
mergesort [x] = [x]
mergesort xs  = merge (mergesort izq) (mergesort der)
  where (izq, der) = divide xs

-- Prueba
main :: IO ()
main = do
    print (mergesort [5,2,9,1,5,6,3])   -- [1,2,3,5,5,6,9]
    print (mergesort "mergesort")        -- "eegmorrst"
