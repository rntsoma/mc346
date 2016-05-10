{-
 - For this exercise, we are dealing with a type for colours of the rainbow
 - The typeclass is defined here, and note its English spelling.
 - For more information on how this is done, look ahead to:
 - http://learnyouahaskell.com/making-our-own-types-and-typeclasses
 -
 - Have a play with the Colour in ghci, try the succ and pred functions and so on.
 -}
data Colour = Red | Orange | Yellow | Green | Blue | Indigo | Violet
    deriving (Eq, Ord, Show, Bounded, Enum)   

{-
 - Again, you should be able to write these functions in one line, 
 - using the information from the chapter http://learnyouahaskell.com/types-and-typeclasses
 - and the chapter before
 -}

{-
 - The Colour typeclass is of type Ord
 - What is the "first" (or least) colour
 -}
firstColour = minBound :: Colour
lastColour = maxBound :: Colour

-- List the colours in reverse order
reverseColourOrder = reverse [Red .. Violet]

{-
 - Mix two colours together, to produce the average value of the two.
 - Example: paintMix Orange Green = Yellow
 - If necessary, favour the "higher" value when computing the average.
 - For example: paintMix Green Violet = Indigo
 - Hint: Integer division can be performed with the quot function: quot 7 2 = 3
 -}
paintMix c1 c2 = 
    if (mod (length [Red .. c1] + length [Red .. c2]) 2) == 0 
        then [Red .. Violet] !! ((quot (length [Red .. c1] + length [Red .. c2])  2)-1)
        else [Red .. Violet] !! (succ (quot (length [Red .. c1] + length [Red .. c2])  2)-1)
