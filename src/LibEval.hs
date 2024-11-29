module LibEval
  ( evalPoint,
  )
where
import LibPoint
import LibApprox
import LibSlidingWindow (addElement, SlidingWindow)

evalPoint :: String -> SlidingWindow Point -> (SlidingWindow Point, String)
evalPoint str window = (newWindow, show newWindow)
  where
    point = mapPoint str
    newWindow = addElement point window
