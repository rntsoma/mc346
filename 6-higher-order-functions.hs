-- Sum the numbers between two inclusive values recursively, assuming a < b when the function is first called
-- Example: sumInts 0 1 = 1
--          sumInts 1 3 = 6
sumInts :: Int -> Int -> Int
sumInts a b
    | a == b = a
    | a > b = 0
    | otherwise = (a+b) + sumInts (a+1) (b-1)

sumInts' :: Int -> Int -> Int
sumInts' a b = foldl (\ acumulador x -> acumulador+x) 0 [a..b]

-- Define a square function
sq :: Int -> Int
sq x = x*x

-- Sum the squares between two numbers. This function should be similar to the sumInts function
sumSquares :: Int -> Int -> Int
sumSquares a b
    | b > 0 || b < 0 = a*a + sumSquares b 0
    | otherwise = a*a

-- Define a higher order sum function which accepts an (Int -> Int) function to apply to all integers between two values.
-- Again this should look similar to the sumInts and sumSquares functions
higherOrderSum :: (Int -> Int) -> Int -> Int -> Int
higherOrderSum intApplication a b = sum (map intApplication [a..b])

-- Define the square sum in terms of higherOrderSum
hoSumSquares :: Int -> Int -> Int
hoSumSquares = higherOrderSum (sq)

-- Define the sum between two values in terms of higherOrderSum
-- Note there is no parameter on the function definition
-- Try to use a lambda if possible
hoSumInts :: Int -> Int -> Int
hoSumInts = higherOrderSum (\ a -> a) 

-- Create a new higher order method which generalises over the function provided by sumInts (That is, parameterize (+) :: Int -> Int -> Int) between a and b
-- This will give the ability to perform utilities such as the prodcut of all squares (or any other Int -> Int function) between a and b
-- You will also need to generalise the base case
-- You can also define the function signature yourself, which leaves you free to define the parameters and their order
-- To be clear, your function will need to handle:
--  - A start value, a :: Int
--  - A end value, b :: Int
--  - A function to apply to each value, op :: Int -> Int
--  - A function to apply between each value, f :: Int -> Int -> Int
--  - A value to return in the base case when a > b, z :: Int
higherOrderSequenceApplication :: Int -> Int -> (Int -> Int) -> (Int -> Int -> Int) -> Int
higherOrderSequenceApplication a b op f
    | a >= b = op a
    | otherwise = f (op a) (higherOrderSequenceApplication (a+1) b op f)
--Ex: higherOrderSequenceApplication 1 3 (\a -> 2*a) (+)
--inicio=1 fim=3 == [1,2,3]; op=2*valor == [2,4,6]; f = + == 2+4+6=12

-- Define a factorial method using the higherOrderSequenceAppliction
hoFactorial :: Int -> Int
hoFactorial = undefined