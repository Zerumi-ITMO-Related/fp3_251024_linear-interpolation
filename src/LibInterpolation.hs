module LibInterpolation
  ( Interpolation,
    Interpolation (..),
    linearInterpolation,
  )
where

import LibSlidingWindow

type Point = (Double, Double)

data Interpolation = Interpolation
  { window :: SlidingWindow Point,
    func :: SlidingWindow Point -> [Double],
    step :: Double
  }

linearInterpolation :: Interpolation
linearInterpolation = Interpolation (newSlidingWindow 2) (linearInterpolationFunc 1.0) 1.0

-- Linear interpolation function
generateSequence :: (Num a, Ord a) => a -> a -> a -> [a]
generateSequence x step threshold =
  takeWhile (< threshold) (iterate (+ step) x)

linearInterpolationFunc :: Double -> SlidingWindow Point -> [Double]
linearInterpolationFunc step interp =
  case getElements interp of
    [Just (x0, y0), Just (x1, y1)] -> [y0 + (x - x0) * (y1 - y0) / (x1 - x0) | x <- generateSequence x1 step (x0 + step)]
    _ -> [0.0]
