module LibPoint
  ( Point,
    mapPoint,
  )
where

type Point = (Double, Double)

mapPoint :: String -> Point
mapPoint input = (read x, read y)
  where
    (x, y) = case words input of
      [xStr, yStr] -> (xStr, yStr)
      _ -> error "Invalid input"
