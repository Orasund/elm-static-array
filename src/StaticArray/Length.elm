module StaticArray.Length exposing
    ( Length, one, plus1, minus1, toInt
    , two, four, five, eight, ten, twenty
    , plus2, plus4, plus5, plus8, plus10, plus20
    , minus2, minus4, minus5, minus8, minus10, minus20
    )

{-| This module introduces the `Length` type. The length type is an integer but its value is known in compile time.
This way we can ensure that no index out of bounds error occurs.


# Basics

@docs Length, one, plus1, minus1, toInt


# Constructors

@docs two, four, five, eight, ten, twenty


# Addition

@docs plus2, plus4, plus5, plus8, plus10, plus20


# Subtraction

@docs minus2, minus4, minus5, minus8, minus10, minus20

-}

import StaticArray.Index exposing (Eight, EightPlus, Five, FivePlus, Four, FourPlus, One, OnePlus, Ten, TenPlus, Twenty, TwentyPlus, Two, TwoPlus)
import StaticArray.Internal as Internal exposing (Length(..))


{-| A length represents the length of a static array

    import StaticArray

    StaticArray.singleton 42
        |> StaticArray.push 7
        |> StaticArray.length
        --> two

-}
type alias Length n =
    Internal.Length n


{-| Converts a length into int

    four
        |> toInt
        --> 4

-}
toInt : Length n -> Int
toInt (C n) =
    n


{-| Length of an array with one element
-}
one : Length One
one =
    C 1


{-| Length of an array with two elements
-}
two : Length Two
two =
    C 2


{-| Length of an array with four elements
-}
four : Length Four
four =
    C 4


{-| Length of an array with five elements
-}
five : Length Five
five =
    C 5


{-| Length of an array with eight elements
-}
eight : Length Eight
eight =
    C 8


{-| Length of an array with ten elements
-}
ten : Length Ten
ten =
    C 10


{-| Length of an array with twenty elements
-}
twenty : Length Twenty
twenty =
    C 20


{-| Increases the length by one
-}
plus1 : Length n -> Length (OnePlus n)
plus1 (C n) =
    C (n + 1)


{-| Increases the length by two
-}
plus2 : Length n -> Length (TwoPlus n)
plus2 (C n) =
    C (n + 2)


{-| Increases the length by four
-}
plus4 : Length n -> Length (FourPlus n)
plus4 (C n) =
    C (n + 4)


{-| Increases the length by eight
-}
plus8 : Length n -> Length (EightPlus n)
plus8 (C n) =
    C (n + 8)


{-| Increases the length by five
-}
plus5 : Length n -> Length (FivePlus n)
plus5 (C n) =
    C (n + 5)


{-| Increases the length by ten
-}
plus10 : Length n -> Length (TenPlus n)
plus10 (C n) =
    C (n + 10)


{-| Increases the length by twenty
-}
plus20 : Length n -> Length (TwentyPlus n)
plus20 (C n) =
    C (n + 20)


{-| Decreases the length by one
-}
minus1 : Length (OnePlus n) -> Length n
minus1 (C n) =
    C (n - 1)


{-| Decreases the length by two
-}
minus2 : Length (TwoPlus n) -> Length n
minus2 (C n) =
    C (n - 2)


{-| Decreases the length by four
-}
minus4 : Length (FourPlus n) -> Length n
minus4 (C n) =
    C (n - 4)


{-| Decreases the length by eight
-}
minus8 : Length (EightPlus n) -> Length n
minus8 (C n) =
    C (n - 8)


{-| Decreases the length by five
-}
minus5 : Length (FivePlus n) -> Length n
minus5 (C n) =
    C (n - 5)


{-| Decreases the length by ten
-}
minus10 : Length (TenPlus n) -> Length n
minus10 (C n) =
    C (n - 10)


{-| Decreases the length by twenty
-}
minus20 : Length (TwentyPlus n) -> Length n
minus20 (C n) =
    C (n - 20)
