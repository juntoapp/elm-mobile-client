module Main exposing (..)

import Html exposing (Html, div, text)
import Html.Events exposing (onInput, onClick)
import Navigation exposing (Location)
import Date
import Msgs
import Routing
import Models
import View
import Update
import Task


subscriptions : Models.Model -> Sub Msgs.Msg
subscriptions model =
    Sub.none


init : Location -> ( Models.Model, Cmd Msgs.Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( Models.initialModel currentRoute, Task.perform Msgs.SetDate Date.now )


main : Program Never Models.Model Msgs.Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = subscriptions
        }
