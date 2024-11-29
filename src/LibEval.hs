module LibEval
  ( evalPoint,
  )
where

import LibInterpolation hiding (name, step, window)
import LibPoint
import LibSlidingWindow (addElement)

evalPoint :: String -> Interpolation -> (Interpolation, Maybe String)
evalPoint str (Interpolation name window intFunc step) = (Interpolation name newWindow intFunc step, result)
    where
        point = mapPoint str
        newWindow = addElement point window
        result = case showPoints (intFunc newWindow) of
            Just s  -> Just (name ++ " interpolation: \n" ++ s)
            Nothing -> Nothing
