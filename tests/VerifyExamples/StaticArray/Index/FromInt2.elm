module VerifyExamples.StaticArray.Index.FromInt2 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import StaticArray.Index exposing (..)
import StaticArray.Length as Length







spec2 : Test.Test
spec2 =
    Test.test "#fromInt: \n\n    fromInt Length.one -1\n    --> Nothing" <|
        \() ->
            Expect.equal
                (
                fromInt Length.one -1
                )
                (
                Nothing
                )