module LibSlidingWindow
  ( SlidingWindow,
    newSlidingWindow,
    addElement,
    getElements,
  )
where

data SlidingWindow a = SlidingWindow Int [Maybe a] deriving (Show, Eq)

-- Create a new sliding window with a fixed size
newSlidingWindow :: Int -> SlidingWindow a
newSlidingWindow size = SlidingWindow size (replicate size Nothing)

-- Add an element to the sliding window
addElement :: a -> SlidingWindow a -> SlidingWindow a
addElement x (SlidingWindow size elems) = SlidingWindow size (take size (Just x : init elems))

-- Get the elements of the sliding window
getElements :: SlidingWindow a -> [Maybe a]
getElements (SlidingWindow _ elems) = elems
