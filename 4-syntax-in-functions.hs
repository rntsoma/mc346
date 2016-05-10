-- This function should print a single digit number as English text, or "unknown" if it's out of the range 0-9
englishDigit :: Int -> String
englishDigit x 
    | x <= 9 && x>=0 = xs !! x
    | otherwise = "unknown"
    where xs = ["zero","one","two","three","four","five","six","seven","eight","nine"]

-- given a tuple, divide fst by snd, using pattern matching. 
-- it should return undefined for division by zero
divTuple :: (Eq a, Fractional a) => (a, a) -> a
divTuple (_, 0) = error "undefined"
divTuple (x, y) = x/y

-- if the first three numbers in a list are all zero, return True
threeZeroList :: [Int] -> Bool
threeZeroList [] = False
threeZeroList [0,0,0] = True
threeZeroList (x:y:z:[_])
    | (x,y,z) == (0,0,0) = True
    | otherwise = False
threeZeroList (x:_) = False

--solving threeZeroList with case, maybe it's more elegant
-- if the first three numbers in a list are all zero, return True
--threeZeroList :: [Int] -> Bool
--threeZeroList list = 
--    case list of [] -> False
--                 [0,0,0] -> True
--                 (x:y:z:_)
--                    | (x,y,z) == (0,0,0) -> True
--                    | otherwise -> False
--                 (x:_) -> False