module LibREPL
  ( read_,
    eval_,
    print_,
    loop_,
  )
where

import Control.Monad (unless)
import GHC.IO.Handle
import GHC.IO.Handle.FD
import LibEval
import LibInterpolation

-- | Read a line from the user
read_ :: IO String
read_ =
  putStr "Enter point (x, y)> "
    >> hFlush stdout
    >> getLine

-- | Evaluate the input
eval_ :: String -> Interpolation -> (Interpolation, Maybe String)
eval_ = evalPoint

-- | Print the result
print_ :: Maybe String -> IO ()
print_ Nothing = return ()
print_ (Just str) = putStrLn str

-- | Loop the read-eval-print cycle
loop_ :: [Interpolation] -> IO ()
loop_ windows = do
  input <- read_
  unless (input == ":quit") $ do
    let (newWindows, results) = unzip $ map (eval_ input) windows
    mapM_ print_ results
    loop_ newWindows
