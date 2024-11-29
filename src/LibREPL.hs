module LibREPL
  ( read_,
    eval_,
    print_,
    loop_,
  )
where
import GHC.IO.Handle
import Control.Monad (unless)
import GHC.IO.Handle.FD
import LibEval
import LibSlidingWindow (SlidingWindow)
import LibPoint (Point)

-- | Read a line from the user
read_ :: IO String
read_ = putStr "Enter point (x, y)> "
     >> hFlush stdout
     >> getLine

-- | Evaluate the input
eval_ :: String -> SlidingWindow Point -> (SlidingWindow Point, String)
eval_ = evalPoint

-- | Print the result
print_ :: String -> IO ()
print_ = putStrLn

-- | Loop the read-eval-print cycle
loop_ :: SlidingWindow Point -> IO ()
loop_ window = do
  input <- read_
  unless (input == ":quit") $ do
    let result = eval_ input window
    print_ (snd result)
    loop_ (fst result)
