module LibIO
    ( parseIntStream
    ) where

import Data.Maybe (mapMaybe)
import Text.Read (readMaybe)

parseIntStream :: String -> [Int]
parseIntStream = mapMaybe readMaybe . words
