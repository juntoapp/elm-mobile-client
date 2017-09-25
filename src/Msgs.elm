module Msgs exposing (..)

import Navigation exposing (Location)
import Date exposing (Date)


type Msg
    = NoOp
    | SetDate Date
    | OnLocationChange Location
