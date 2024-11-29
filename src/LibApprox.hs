module LibApprox(
    linearInterpolation,
) where

type Point = (Double, Double)

-- Linear interpolation function
linearInterpolation :: Point -> Point -> Double -> Double
linearInterpolation (x0, y0) (x1, y1) x = y0 + (x - x0) * (y1 - y0) / (x1 - x0)

