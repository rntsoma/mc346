-- Le retangulos e imprime a maior area possivel

import System.IO
import Process

-- | 'main' runs the main program
main :: IO ()
main = do
  contents <- getContents
  putStrLn $ show $ process (readLines contents) [] 0 