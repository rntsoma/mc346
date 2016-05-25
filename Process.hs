--Modulo responsavel por calcular a maior area possivel

module Process(
    readLines,
    process
)where

import Geometry

--Le multiplas linhas da entrada (no caso o arquivo .in) e cria retangulos
readLines :: String -> [Rect]
readLines str = [makeRect x | x <- lines str]

--Verifica se dois retangulos sao compativeis de acordo com a especificacao do projeto
compatible :: Rect -> Rect -> Bool
compatible (Rect _ xMin1 xMax1 yMin1 yMax1) (Rect _ xMin2 xMax2 yMin2 yMax2)
    | xMax1 < xMin2 && yMax1 < yMin2 = True
    | xMax2 < xMin1 && yMax2 < yMin1 = True
    | otherwise = False

--Funcao principal do problema, calcula os valores otimos possiveis com cada retangulo.
--Comeca a analise a partir de um unico retangulo, e vai incrementando ate acabarem os retangulos.
--A ideia por tras eh PD, mas nao estou (ainda) habituado a este padrao de projeto de algoritmo.
--Os argumentos da funcao sao explicados na linha abaixo
--Lista rect, lista otimos, acumulador max
process :: [Rect] -> [(Int, [Rect])] -> Int -> Int
process [] _ val 
    | val == 0 = 0
    | otherwise = val
process listRect listOtimo acc
    | listOtimo == [] = process (tail listRect) (listOtimo ++ [(area (head listRect), [head listRect])]) (acc+area (head listRect))
    | otherwise = process newListRect newListOtimo (maximum [x | x <- map fst newListOtimo])
    where newListRect = tail listRect
          target = area (head listRect)
          rect = head listRect
          boolList = compatibleList rect (extractAllLists listOtimo)
          newListOtimo = newFinal target listOtimo boolList rect []

--Checa se um retangulo e compativel com outros retangulos de uma lista
checkCompatibility :: Rect -> [Rect] -> Bool
checkCompatibility target list =
    if elem False [x | x <- map (compatible target) list]
        then False
        else True

--Extrai a lista de retangulos de uma tupla.
--Uso tuplas neste programa apenas para representar a seguinte estrutura:
--(Area, Lista de retangulos compatives)
extractList :: (Int, [Rect]) -> [Rect]
extractList (num, list) = list

--Extrai as listas de retangulos da lista de tuplas "otimas"
extractAllLists :: [(Int, [Rect])] -> [[Rect]]
extractAllLists tupleList = [x | x <- map extractList [y | y<-tupleList]]

--Verifica com quais listas maximas de retangulos o retangulo atual eh compativel
compatibleList :: Rect -> [[Rect]] -> [Bool]
compatibleList target listLists = [checkCompatibility target x | x <- listLists]

--Gera uma nova tupla
generateNewTuple :: (Int, [Rect]) -> Int -> Rect -> (Int, [Rect])
generateNewTuple (valor, list) v rect = (valor+v, list ++ [rect])

--Gera uma nova tupla de valores otimos.
--As explicacoes para os parametros se encontra na linha abaixo
--target, tuple list, compatible list, rectangle, acumulator
newFinal :: Int -> [(Int, [Rect])] -> [Bool] -> Rect -> [(Int, [Rect])] -> [(Int, [Rect])]
newFinal v [] _ rect acc = reverse ((v, [rect]):acc)
newFinal v tupleList boolList rect acc
    | (head boolList) == True = newFinal v (tail tupleList) (tail boolList) rect ((generateNewTuple (head tupleList) v rect) : acc)
    | otherwise = newFinal v (tail tupleList) (tail boolList) rect ((head tupleList) : acc)

--Observacoes:
--Acho que o algoritmo esta quadratico
--Colocar mais comentarios depois que aocrdar, que nao estejam em go horse
--Explicar a ideia do algoritmo
--Debugar o codigo para passar em mais testes