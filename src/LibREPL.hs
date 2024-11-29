module LibREPL
  ( read_,
    eval_,
    print_,
    loop_,
  )
where

import Control.Monad (unless)
import Data.Maybe
import GHC.IO.Handle
import GHC.IO.Handle.FD
import LibEval
import LibInterpolation hiding (window)
import LibSlidingWindow
import Text.Read

-- | Read a line from the user
read_ :: IO String
read_ =
  putStr "Enter point (x, y)> "
    >> hFlush stdout
    >> getLine

-- | Validate the input
validate_ :: String -> Bool
validate_ str = case words str of
  [x, y] -> isJust (readMaybe x :: Maybe Double) && isJust (readMaybe y :: Maybe Double)
  _ -> False

validateGrowingX :: String -> Interpolation -> Bool
validateGrowingX input (Interpolation _ window _ _) = case words input of
  [xStr, _] -> case head (getElements window) of
    Just (x0, _) -> x0 < read xStr
    _ -> True
  _ -> False

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
  unless (input == ":quit") $
    if validate_ input && validateGrowingX input (head windows)
      then do
        let (newWindows, results) = unzip $ map (eval_ input) windows
        mapM_ print_ results
        loop_ newWindows
      else do
        putStrLn "Invalid input. Please enter a valid point (x, y). X should be greater than the previous X."
        loop_ windows
