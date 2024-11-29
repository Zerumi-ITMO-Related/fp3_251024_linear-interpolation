module LibEval
  ( evalPoint,
  )
where

import LibInterpolation
import LibPoint
import LibSlidingWindow (addElement)

evalPoint :: String -> Interpolation -> (Interpolation, String)
evalPoint str (Interpolation window intFunc step) = (Interpolation newWindow intFunc step, show (intFunc newWindow))
  where
    point = mapPoint str
    newWindow = addElement point window
