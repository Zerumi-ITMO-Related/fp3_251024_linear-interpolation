module LibEval
  ( evalPoint,
  )
where

import LibInterpolation hiding (step, window)
import LibPoint
import LibSlidingWindow (addElement)

evalPoint :: String -> Interpolation -> (Interpolation, Maybe String)
evalPoint str (Interpolation window intFunc step) = (Interpolation newWindow intFunc step, showPoints (intFunc newWindow))
  where
    point = mapPoint str
    newWindow = addElement point window
