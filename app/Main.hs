module Main (main) where

import LibInterpolation
import LibREPL

-- | Welcome message
welcomeInvite :: IO ()
welcomeInvite =
  putStrLn "fp3_251024_linear-interpolation REPL. Type :quit to exit."
    >> putStrLn "Enter a point (x, y) to calculate the distance from the origin."
    >> putStrLn "x and y should be decimal numbers. Example: 3.0 4.0"

-- Main function to read input lazily, parse it, and print the integers
main :: IO ()
main = welcomeInvite >> loop_ [linearInterpolation, lagrangeInterpolation]
