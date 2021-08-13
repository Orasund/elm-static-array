module StaticArray exposing
    ( StaticArray, singleton, fromList, initialize
    , push, get, set, resize, length, map, indexedMap
    , toArray, toList, toRecord, fromRecord
    )

{-| This module introduces the `StaticArray`. A static array is a non empty array fix a fixed size.
We can check the size in compile-time and ensure that the array is about as fast as a usual (dynamic) array in run time.


# Constructor

@docs StaticArray, singleton, fromList, initialize


# Operations

@docs push, get, set, resize, length, map, indexedMap


# Conversion

@docs toArray, toList, toRecord, fromRecord

-}

import Array exposing (Array)
import StaticArray.Index exposing (Index, One, OnePlus(..))
import StaticArray.Internal as Internal exposing (Index(..), Length(..), StaticArray(..))
import StaticArray.Length exposing (Length)


{-| A static array is an array with a fixed length.

    singleElement : StaticArray One Int
    singleElement =
        singleton 42

    twoElements : StaticArray Two Int
    twoElements =
        singleElement
            |> push 7

-}
type alias StaticArray n a =
    Internal.StaticArray n a


{-| Constructs an array with a single item.
-}
singleton : a -> StaticArray One a
singleton a =
    A ( a, Array.empty )


{-| Constructs an array from a list

    import Array
    import StaticArray.Length as Length

    fromList Length.five 0 []
        |> toArray
        --> Array.repeat 5 0

-}
fromList : Length n -> a -> List a -> StaticArray n a
fromList (C l) head tail =
    let
        diff =
            (tail |> List.length |> (+) 1) - l
    in
    if diff < 0 then
        A ( head, List.append tail (List.repeat (abs diff) head) |> Array.fromList )

    else
        A ( head, tail |> Array.fromList |> Array.slice 0 l )


{-| Initiate an array and fill it.

    import StaticArray.Length as Length

    initialize Length.five (\i -> i*i)
    --> fromList Length.five 0 [1,4,9,16]

-}
initialize : Length n -> (Int -> a) -> StaticArray n a
initialize (C l) fun =
    A ( fun 0, Array.initialize (l - 1) ((+) 1 >> fun) )


{-| Adds an element to the end of the array.
-}
push : a -> StaticArray n a -> StaticArray (OnePlus n) a
push a (A ( head, tail )) =
    A ( head, Array.push a tail )


{-| Changes the size of the array. If the array gets bigger, then the first element of the array gets used as default value.

    import StaticArray.Length as Length
    import Array

    singleton 42
        |> push 7
        |> resize (Length.one |> Length.plus4)
        |> toArray
        |> Array.toList --> [42,7,42,42,42]

-}
resize : Length m -> StaticArray n a -> StaticArray m a
resize (C l) (A ( head, tail )) =
    let
        diff =
            (tail |> Array.length |> (+) 1) - l
    in
    if diff < 0 then
        A ( head, Array.append tail (Array.repeat (abs diff) head) )

    else
        A ( head, tail |> Array.slice 0 (l - 1) )


{-| Transforms the static array into a dynamic array.
-}
toArray : StaticArray n a -> Array a
toArray (A ( head, tail )) =
    Array.append ([ head ] |> Array.fromList) tail


{-| Transforms the static array into a list.
-}
toList : StaticArray n a -> List a
toList =
    toArray >> Array.toList


{-| Exposes the underlying record of the array

    import StaticArray.Length as Length
    import StaticArray.Index exposing (Five,OnePlus)

    array : StaticArray (OnePlus Five) Int
    array =
        fromList (Length.five |> Length.plus1) 0
            [1,2,3,4,5]

    array |> toRecord |> fromRecord --> array

-}
toRecord : StaticArray n a -> { length : Length n, head : a, tail : Array a }
toRecord (A ( head, tail )) =
    { length = C <| (tail |> Array.length) + 1
    , head = head
    , tail = tail
    }


{-| Constructs a static array from its components.
If the Length is bigger then the number of elements provided, the additional element will be filled with duplicates of head.

    import StaticArray.Length as Length
    import Array

    fromRecord
        { length = (Length.five |> Length.plus1)
        , head = 0
        , tail = Array.fromList [1,2,3,4,5]
        }
    --> fromList (Length.five |> Length.plus1) 0 [1,2,3,4,5]

-}
fromRecord : { length : Length n, head : a, tail : Array a } -> StaticArray n a
fromRecord record =
    let
        (C l) =
            record.length

        diff =
            (record.tail |> Array.length |> (+) 1) - l
    in
    if diff < 0 then
        A ( record.head, Array.append record.tail (Array.repeat (abs diff) record.head) )

    else
        A ( record.head, record.tail |> Array.slice 0 l )


{-| Gets an element of the array. Note that it only possible if the index is in bound. Therefore eliminating Off-by-one errors.
-}
get : Index n -> StaticArray n a -> a
get (I n) (A ( head, tail )) =
    if n == 0 then
        head

    else
        tail
            |> Array.get (n - 1)
            |> Maybe.withDefault head


{-| Sets an element of the array.
-}
set : Index n -> a -> StaticArray n a -> StaticArray n a
set (I n) a (A ( head, tail )) =
    A <|
        if n == 0 then
            ( a, tail )

        else
            ( head, tail |> Array.set (n - 1) a )


{-| Updates all elements of an array.
-}
map : (a -> b) -> StaticArray n a -> StaticArray n b
map fun (A ( head, tail )) =
    A ( fun head, tail |> Array.map fun )


{-| Same as map but with an index.
-}
indexedMap : (Index n -> a -> b) -> StaticArray n a -> StaticArray n b
indexedMap fun (A ( head, tail )) =
    A ( fun (I 0) head, tail |> Array.indexedMap (\n -> fun (I (n - 1))) )


{-| Returns the length of an array.
-}
length : StaticArray n a -> Length n
length (A ( _, tail )) =
    tail |> Array.length |> (+) 1 |> C
