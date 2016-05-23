module Geometry(
    area,
    Rect,
    makeRect
)where

data Rect = Rect{
    rectId :: Int,
    xMin   :: Int,
    xMax   :: Int,
    yMin   :: Int,
    yMax   :: Int
}deriving (Show, Eq)

area :: Rect -> Int
area (Rect _ xMin xMax yMin yMax) = (xMax - xMin) * (yMax - yMin)

makeRect :: String -> Rect
makeRect str = Rect rectId xMin xMax yMin yMax
    where (rectId:xMin:xMax:yMin:yMax:[])=[ read i | i<-words str]