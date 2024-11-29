module LibPoint
  ( Point,
    mapPoint,
    showPoints,
  )
where

import Text.Printf

type Point = (Double, Double)

mapPoint :: String -> Point
mapPoint input = (read x, read y)
  where
    (x, y) = case words input of
      [xStr, yStr] -> (xStr, yStr)
      _ -> error "Invalid input"

-- Function to format a single number with 2 decimal places
formatNumber :: Double -> String
formatNumber = printf "%.2f"

-- Function to format a list of points
showPoints :: Maybe [Point] -> Maybe String
showPoints Nothing = Nothing
showPoints (Just points) = Just (unlines [unwords xCoords, unwords yCoords])
  where
    -- Split the points into separate lists for x and y coordinates
    (xs, ys) = unzip points
    -- Format each coordinate to 2 decimal places
    xCoords = map formatNumber xs
    yCoords = map formatNumber ys
