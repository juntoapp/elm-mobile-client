module Main exposing (..)

import Html exposing (Html, div, text)
import Html.Events exposing (onInput, onClick)
import Msgs
import Routing
import Models
import View exposing (..)
import Update exposing (..)
import Navigation exposing (Location)



initialModel : Models.Route -> Models.Model
initialModel route =
    { route = route }

subscriptions : Models.Model -> Sub Msgs.Msg
subscriptions model =
    Sub.none



init : Location -> ( Models.Model, Cmd Msgs.Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.none )



main : Program Never Models.Model Msgs.Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
