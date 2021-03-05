module StaticArray exposing (StaticArray, append10, append2, append20, append4, append5, append8, get, length, push, resize, singleton, toArray)

{-| This module introduces the `StaticArray`. A static array is a non empty array fix a fixed size.
We can check the size in compile-time and ensure that the array is about as fast as a usual (dynamic) array in run time.
-}

import Array exposing (Array)
import StaticArray.Index exposing (Eight, EightPlus, Five, FivePlus, Four, FourPlus, Index, One, OnePlus(..), Ten, TenPlus, Twenty, TwentyPlus, Two, TwoPlus)
import StaticArray.Internal as Internal exposing (Index(..), Length(..), StaticArray(..))
import StaticArray.Length exposing (Length)


{-| A static array is an array with a fixed length.

```
singleElement : StaticArray One Int
singleElement =
    singleton 42

twoElements : StaticArray Two Int
twoElements =
    singleElement
    |> push 7
```

For constructing a static array you will need to push one element after another onto the array.
For bigger arrays this can consume quite a lot of time. Instead we recommend using `StaticArray.Builder`.

-}
type alias StaticArray n a =
    Internal.StaticArray n a


{-| Constructs an array with a single item.
-}
singleton : a -> StaticArray One a
singleton a =
    A ( a, Array.empty )


{-| Adds a element to the end of the array.
-}
push : a -> StaticArray n a -> StaticArray (OnePlus n) a
push a (A ( head, tail )) =
    A ( head, Array.push a tail )


{-| Adds two element to the end of the array.
-}
append2 : StaticArray Two a -> StaticArray n a -> StaticArray (TwoPlus n) a
append2 a1 (A ( h2, t2 )) =
    A ( h2, Array.append t2 (a1 |> toArray) )


{-| Adds four element to the end of the array.
-}
append4 : StaticArray Four a -> StaticArray n a -> StaticArray (FourPlus n) a
append4 a1 (A ( h2, t2 )) =
    A ( h2, Array.append t2 (a1 |> toArray) )


{-| Adds eight element to the end of the array.
-}
append8 : StaticArray Eight a -> StaticArray n a -> StaticArray (EightPlus n) a
append8 a1 (A ( h2, t2 )) =
    A ( h2, Array.append t2 (a1 |> toArray) )


{-| Adds five element to the end of the array.
-}
append5 : StaticArray Five a -> StaticArray n a -> StaticArray (FivePlus n) a
append5 a1 (A ( h2, t2 )) =
    A ( h2, Array.append t2 (a1 |> toArray) )


{-| Adds ten element to the end of the array.
-}
append10 : StaticArray Ten a -> StaticArray n a -> StaticArray (TenPlus n) a
append10 a1 (A ( h2, t2 )) =
    A ( h2, Array.append t2 (a1 |> toArray) )


{-| Adds twenty element to the end of the array.
-}
append20 : StaticArray Twenty a -> StaticArray n a -> StaticArray (TwentyPlus n) a
append20 a1 (A ( h2, t2 )) =
    A ( h2, Array.append t2 (a1 |> toArray) )


{-| Changes the size of the array. If the array gets bigger, then the first element of the array gets used as default value.

```
singleton 42
|> push 7
|> resize (Length.one |> Length.plus4)
|> toArray
|> Array.toList --> [42,7,42,42,42]
```

-}
resize : Length m -> StaticArray n a -> StaticArray m a
resize (C l) (A ( head, tail )) =
    let
        diff =
            (tail |> Array.length |> (+) 1) - l
    in
    if diff < 0 then
        A ( head, Array.append tail (Array.repeat diff head) )

    else
        A ( head, tail |> Array.slice 0 l )


{-| Transforms the static array into a dynamic array.
-}
toArray : StaticArray n a -> Array a
toArray (A ( head, tail )) =
    Array.append ([ head ] |> Array.fromList) tail


{-| Gets an element of the array. Note that it only allows an index that is in bound. Therefore eliminating Off-by-one errors.
-}
get : Index n -> StaticArray n a -> a
get (I n) (A ( head, tail )) =
    if n == 0 then
        head

    else
        tail
            |> Array.get (n - 1)
            |> Maybe.withDefault head


{-| Returns the length of an array.
-}
length : StaticArray n a -> Length n
length (A ( _, tail )) =
    tail |> Array.length |> (+) 1 |> C
