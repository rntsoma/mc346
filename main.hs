-- Reads rectangles and outputs them

import System.IO
import Geometry
import Process

-- | 'main' runs the main program
main :: IO ()
main = do
  contents <- getContents
  --putStrLn $ process $ lines contents
  putStrLn $ show $ readLines contents

--process :: [String] -> String
--process = unlines . map ("linha: " ++) 