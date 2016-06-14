doubleMe x = x+x
doubleUs x y = doubleMe x + doubleMe y
doubleSmallNumber x = 
    if x>100 
        then x 
        else doubleMe x

--Chap2
penultimate l = last(init l)

find k l = l !! k

isPalindrome l = 
    if l == reverse l 
        then True
        else False

duplicate xs = 
    concat [[x1, x1] | x1 <- xs]

--ziplike xs ys =
--    [(x1, y1) | x1 <- xs, let y1 = ys !! (x1-1)]

splitAtIndex k l = 
    (take k l, drop k l)

dropK k l =
    concat [take (k) l, drop (k+1) l]

slice i k l =
    take (k-i) (drop i l)

insertElem x k l = 
    take k l ++ [x] ++ drop k l

--rotate n l = drop n l ++ take n l

capital :: String -> String  
capital "" = "Empty string, whoops!"  
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]

bmiTell :: (RealFloat a) => a -> a -> String  
bmiTell weight height  
    | bmi <= skinny = "You're underweight, you emo, you!"  
    | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"  
    | bmi <= fat    = "You're fat! Lose some weight, fatty!"  
    | otherwise     = "You're a whale, congratulations!"  
    where bmi = weight / height ^ 2  
          skinny = 18.5  
          normal = 25.0  
          fat = 30.0  

multList n [] = []
multList n (x:xs) = n*x : multList n xs
tripleList = multList 3

higherOrderSum intApplication a b
  | a == b = (intApplication b)
  | otherwise = (intApplication a) + (higherOrderSum intApplication (a+1) b)

intApplication a = 2*a

data Person = Person { firstName :: String  
                     , lastName :: String  
                     , age :: Int  
                     , height :: Float  
                     , phoneNumber :: String  
                     , flavor :: String  
                     } deriving (Show)   

rotate k l = (drop k l) ++ (take k l)