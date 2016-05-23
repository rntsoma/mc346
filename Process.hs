module Process(
	readLines
)where

import Geometry

readLines :: String -> [Rect]
readLines str = [makeRect x | x <- lines str]