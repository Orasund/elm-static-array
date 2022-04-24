module VerifyExamples.StaticArray.FromRecord0 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import StaticArray exposing (..)
import Array
import StaticArray.Length as Length







spec0 : Test.Test
spec0 =
    Test.test "#fromRecord: \n\n    fromRecord\n        { length = (Length.five |> Length.plus1)\n        , head = 0\n        , tail = Array.fromList [1,2,3,4,5]\n        }\n    --> fromList (Length.five |> Length.plus1) (0,[1,2,3,4,5])" <|
        \() ->
            Expect.equal
                (
                fromRecord
                    { length = (Length.five |> Length.plus1)
                    , head = 0
                    , tail = Array.fromList [1,2,3,4,5]
                    }
                )
                (
                fromList (Length.five |> Length.plus1) (0,[1,2,3,4,5])
                )