module Models exposing (..)

import Date exposing (Date)
import Task


type alias Model =
    { route : Route
    , routeLoaded : Maybe Date
    }


type Route
    = StartRoute
    | LoadRoute
    | NotFoundRoute
