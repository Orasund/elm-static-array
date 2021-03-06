module VerifyExamples.StaticArray.Resize0 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import StaticArray exposing (..)
import Array
import StaticArray.Length as Length







spec0 : Test.Test
spec0 =
    Test.test "#resize: \n\n    singleton 42\n        |> push 7\n        |> resize (Length.one |> Length.plus4)\n        |> toArray\n        |> Array.toList\n    --> [42,7,42,42,42]" <|
        \() ->
            Expect.equal
                (
                singleton 42
                    |> push 7
                    |> resize (Length.one |> Length.plus4)
                    |> toArray
                    |> Array.toList
                )
                (
                [42,7,42,42,42]
                )