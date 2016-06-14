--Modulo responsavel por dados relacionados a geometria

module Geometry(
    area,
    Rect(..),
    makeRect,
    getRectId
)where

--Criacao de um novo tipo, representa o retangulo
data Rect = Rect{
    rectId :: Int,
    xMin   :: Int,
    xMax   :: Int,
    yMin   :: Int,
    yMax   :: Int
}deriving (Show, Eq)

--Calcula a area do retangulo
area :: Rect -> Int
area (Rect _ xMin xMax yMin yMax) = (xMax - xMin) * (yMax - yMin)

--Cria um retangulo a partir de coordenadas e de um id
makeRect :: String -> Rect
makeRect str = Rect rectId xMin xMax yMin yMax
    where (rectId:xMin:xMax:yMin:yMax:[])=[ read i | i<-words str]

--Retorna o id do retangulo
getRectId ::Rect -> Int
getRectId (Rect id _ _ _ _) = id