module StaticArray.Builder exposing (Builder, add, add10, add2, add20, add4, add5, add8, addAndBuild, init)

import Array
import StaticArray.Index exposing (EightPlus, FivePlus, FourPlus, One, OnePlus, TenPlus, TwentyPlus, TwoPlus)
import StaticArray.Internal exposing (StaticArray(..))


{-| Fast way to initate a StaticArray.
This way you have about the same performance as when initiating a regular array with a list.

```
init
|> add8 0 [1,2,3,4,5,6,7]
|> addAndBuild 8
```

-}
type Builder n a
    = Builder (List a)


{-| initiate the builder
-}
init : Builder One a
init =
    Builder []


{-| Adds a element to the builder
-}
add : a -> Builder n a -> Builder (OnePlus n) a
add a (Builder l) =
    Builder (a :: l)


{-| Adds two elements to the builder
-}
add2 : a -> a -> Builder n a -> Builder (TwoPlus n) a
add2 a b (Builder l) =
    Builder (b :: a :: l)


{-| Adds 4 elements: first element given as arugment, remaining 3 as list.

if the list contains not enough elements, it will be filled up with the argument given.

-}
add4 : a -> List a -> Builder n a -> Builder (FourPlus n) a
add4 a list (Builder l) =
    let
        n : Int
        n =
            3
    in
    Builder
        ((if (list |> List.length) < n then
            List.repeat n a

          else
            list |> List.take n |> List.reverse
         )
            ++ a
            :: l
        )


{-| Adds 8 elements: first element given as arugment, remaining 7 as list.

if the list contains not enough elements, it will be filled up with the argument given.

-}
add8 : a -> List a -> Builder n a -> Builder (EightPlus n) a
add8 a list (Builder l) =
    let
        n : Int
        n =
            7
    in
    Builder
        ((if (list |> List.length) < n then
            List.repeat n a

          else
            list |> List.take n |> List.reverse
         )
            ++ a
            :: l
        )


{-| Adds 5 elements: first element given as arugment, remaining 4 as list.

if the list contains not enough elements, it will be filled up with the argument given.

-}
add5 : a -> List a -> Builder n a -> Builder (FivePlus n) a
add5 a list (Builder l) =
    let
        n : Int
        n =
            4
    in
    Builder
        ((if (list |> List.length) < n then
            List.repeat n a

          else
            list |> List.take n |> List.reverse
         )
            ++ a
            :: l
        )


{-| Adds 10 elements: first element given as arugment, remaining 9 as list.

if the list contains not enough elements, it will be filled up with the argument given.

-}
add10 : a -> List a -> Builder n a -> Builder (TenPlus n) a
add10 a list (Builder l) =
    let
        n : Int
        n =
            9
    in
    Builder
        ((if (list |> List.length) < n then
            List.repeat n a

          else
            list |> List.take n |> List.reverse
         )
            ++ a
            :: l
        )


{-| Adds 20 elements: first element given as arugment, remaining 19 as list.

if the list contains not enough elements, it will be filled up with the argument given.

-}
add20 : a -> List a -> Builder n a -> Builder (TwentyPlus n) a
add20 a list (Builder l) =
    let
        n : Int
        n =
            19
    in
    Builder
        ((if (list |> List.length) < n then
            List.repeat n a

          else
            list |> List.take n |> List.reverse
         )
            ++ a
            :: l
        )


{-| Adds the last element and then returns the finished array.

```
init
|> addAndBuild 42
--> StaticArray.singelton 42
```

-}
addAndBuild : a -> Builder n a -> StaticArray n a
addAndBuild a (Builder l) =
    case a :: l |> List.reverse of
        [] ->
            --dead branch
            A ( a, Array.empty )

        head :: tail ->
            A ( head, tail |> Array.fromList )
