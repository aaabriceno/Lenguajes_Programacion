longitud_camino :: [(Float, Float)] -> Float
longitud_camino [] = 0
longitud_camino [_] = 0
longitud_camino ((x1,y1):(x2,y2):xs) =
  sqrt ((x2 - x1)^2 + (y2 - y1)^2) + longitud_camino ((x2,y2):xs)

main :: IO ()
main = print (longitud_camino [(1,2),(4,6),(7,10)])
