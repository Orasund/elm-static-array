module StaticArray.Length exposing (Length, minus1, minus10, minus2, minus20, minus4, minus5, minus8, one, plus1, plus10, plus2, plus20, plus4, plus5, plus8)

{-| This module introduces the `Length` type. The length type is a integer but its value is known in compile time.
This way we can ensure that no index out of bounds error accures.
-}

import StaticArray.Index exposing (EightPlus, FivePlus, FourPlus, One, OnePlus, TenPlus, TwentyPlus, TwoPlus)
import StaticArray.Internal as Internal exposing (Length(..))


{-| A length represents the length of a static array

```
StaticArray.singelton 42
|> StaticArray.push 7
|> StaticArray.length
--> (one |> plus1)
```

-}
type alias Length n =
    Internal.Length n


{-| Length of a array with one element
-}
one : Length One
one =
    C 1


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
