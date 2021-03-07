module StaticArray.Index exposing
    ( Index, range, first, last, fromModBy, fromLessThen, increase, decrease, toInt, setLength
    , One(..), Two, Three, Four, Five, Seven, Eight, Nine, Ten, Twenty
    , OnePlus(..), TwoPlus, FourPlus, FivePlus, EightPlus, TenPlus, TwentyPlus
    )

{-| This module contains the `Index` type which can be though of as a range type.
A value of type `Index n` is in between `0` and `n`.

This type will be replaced in compile type with an Int. Resulting in no performance loss.

@docs Index, range, first, last, fromModBy, fromLessThen, increase, decrease, toInt, setLength
@docs One, Two, Three, Four, Five, Seven, Eight, Nine, Ten, Twenty
@docs OnePlus, TwoPlus, FourPlus, FivePlus, EightPlus, TenPlus, TwentyPlus

-}

import StaticArray.Internal as Internal exposing (Index(..), Length(..))


{-| An Index is integer between 0 and n-1
-}
type alias Index n =
    Internal.Index n


{-| Returns the list of all indexes of an array with length n
-}
range : Length n -> List (Index n)
range (C const) =
    List.range 0 const
        |> List.map I


{-| The first index of an array
-}
first : Index n
first =
    I 0


{-| The last element of an array with length n
-}
last : Length n -> Index n
last (C const) =
    I const


{-| Construct an Index by wrapping higher values

    import StaticArray.Length as Length

    fromModBy (Length.one |> Length.plus2) 3
    --> first --0

-}
fromModBy : Length n -> Int -> Index n
fromModBy (C const) =
    modBy const >> I


{-| Construct an Index by cutting off higher values

    import StaticArray.Length as Length exposing (Length)
    import StaticArray.Index exposing (OnePlus,Two)

    length : Length (OnePlus Two)
    length =
        (Length.one |> Length.plus2)

    fromLessThen length 3
    --> last length --2

-}
fromLessThen : Length n -> Int -> Index n
fromLessThen (C const) =
    min const >> I


{-| Increases the index by one. You can not increase the last index.
-}
increase : Length n -> Index n -> Maybe (Index n)
increase (C const) (I n) =
    if n + 1 < const then
        Just <| I (n + 1)

    else
        Nothing


{-| Increases the index by one. You can not decrease the first index.
-}
decrease : Index n -> Maybe (Index n)
decrease (I n) =
    if n == 0 then
        Nothing

    else
        Just <| I (n - 1)


{-| Convert to Integer. You can convert it back by using either `fromModBy` or `fromLessThen`
-}
toInt : Index n -> Int
toInt (I n) =
    n


{-| Change the range of the index. If the length is smaller then the index, it returns Nothing.
-}
setLength : Length m -> Index n -> Maybe (Index m)
setLength (C const) (I n) =
    if n <= const then
        Just (I n)

    else
        Nothing



--------------------------------------------------------------------------------


{-| -}
type OnePlus a
    = OnePlus a


{-| -}
type alias TwoPlus a =
    OnePlus (OnePlus a)


{-| -}
type alias FourPlus a =
    TwoPlus (TwoPlus a)


{-| -}
type alias EightPlus a =
    FourPlus (FourPlus a)


{-| -}
type alias FivePlus a =
    OnePlus (FourPlus a)


{-| -}
type alias TenPlus a =
    FivePlus (FivePlus a)


{-| -}
type alias TwentyPlus a =
    TenPlus (TenPlus a)


{-| -}
type One
    = One


{-| -}
type alias Two =
    OnePlus One


{-| -}
type alias Three =
    OnePlus Two


{-| -}
type alias Four =
    OnePlus Three


{-| -}
type alias Five =
    OnePlus Four


{-| -}
type alias Six =
    OnePlus Five


{-| -}
type alias Seven =
    OnePlus Six


{-| -}
type alias Eight =
    OnePlus Seven


{-| -}
type alias Nine =
    OnePlus Eight


{-| -}
type alias Ten =
    OnePlus Nine


{-| -}
type alias Twenty =
    TenPlus Ten
