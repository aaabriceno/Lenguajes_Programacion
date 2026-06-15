-- Multiplicacion de matrices en Haskell
-- Una matriz es una lista de filas: [[Int]]

type Matriz = [[Int]]

-- Transpuesta: convierte filas en columnas
-- [[1,2],[3,4]] -> [[1,3],[2,4]]
transpuesta :: Matriz -> Matriz
transpuesta []       = []
transpuesta ([]:_)   = []
transpuesta xss      = map head xss : transpuesta (map tail xss)

-- Producto punto de dos vectores (filas): suma de productos
-- [1,2,3] . [4,5,6] = 1*4 + 2*5 + 3*6 = 32
productoPunto :: [Int] -> [Int] -> Int
productoPunto xs ys = sum (zipWith (*) xs ys)

-- Multiplicacion de matrices A (n x m) por B (m x p) -> (n x p)
-- Cada elemento = producto punto de fila de A con columna de B
multMatriz :: Matriz -> Matriz -> Matriz
multMatriz a b = [[ productoPunto fila col | col <- transpuesta b ] | fila <- a ]

-- Prueba
main :: IO ()
main = do
    let a = [[1,2,3],
             [4,5,6]]            -- 2 x 3
    let b = [[7,8],
             [9,10],
             [11,12]]            -- 3 x 2
    putStrLn "A * B ="
    mapM_ print (multMatriz a b) -- esperado: [[58,64],[139,154]]
