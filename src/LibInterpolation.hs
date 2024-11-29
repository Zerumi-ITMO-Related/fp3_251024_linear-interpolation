module LibInterpolation
  ( Interpolation,
    Interpolation (..),
    linearInterpolation,
    lagrangeInterpolation,
  )
where

import LibSlidingWindow
import LibPoint

data Interpolation = Interpolation
  { window :: SlidingWindow Point,
    func :: SlidingWindow Point -> Maybe [Double],
    step :: Double
  }

generateSequence :: (Num a, Ord a) => a -> a -> a -> [a]
generateSequence x stepSize threshold =
  takeWhile (< threshold) (iterate (+ stepSize) x)

-- Linear interpolation function
linearInterpolation :: Interpolation
linearInterpolation = Interpolation (newSlidingWindow 2) (linearInterpolationFunc 1.0) 1.0

linearInterpolationFunc :: Double -> SlidingWindow Point -> Maybe [Double]
linearInterpolationFunc stepSize sw =
  case getElements sw of
    [Just (x0, y0), Just (x1, y1)] -> Just [y0 + (x - x0) * (y1 - y0) / (x1 - x0) | x <- generateSequence x1 stepSize (x0 + stepSize)]
    _ -> Nothing

-- Lagrange interpolation function
lagrangeInterpolation :: Interpolation
lagrangeInterpolation = Interpolation (newSlidingWindow 4) (lagrangeInterpolationFunc 1.0) 1.0

lagrangeInterpolationFunc :: Double -> SlidingWindow Point -> Maybe [Double]
lagrangeInterpolationFunc stepSize sw =
  case getElements sw of
    [Just (x0, y0), Just (x1, y1), Just (x2, y2), Just (x3, y3)] ->
      Just
        [ y0 * ((x - x1) * (x - x2) * (x - x3)) / ((x0 - x1) * (x0 - x2) * (x0 - x3))
            + y1 * ((x - x0) * (x - x2) * (x - x3)) / ((x1 - x0) * (x1 - x2) * (x1 - x3))
            + y2 * ((x - x0) * (x - x1) * (x - x3)) / ((x2 - x0) * (x2 - x1) * (x2 - x3))
            + y3 * ((x - x0) * (x - x1) * (x - x2)) / ((x3 - x0) * (x3 - x1) * (x3 - x2))
          | x <- generateSequence x3 stepSize (x0 + stepSize)
        ]
    _ -> Nothing
