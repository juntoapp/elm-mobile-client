module Models exposing (..)

import Date exposing (Date)
import Task


type alias Model =
    { route : Route
    , routeLoaded : Maybe Date
    }


initialModel : Route -> Model
initialModel route =
    { route = route
    , routeLoaded = Nothing
    }


type Route
    = StartRoute
    | DashboardRoute
    | DashboardDateRoute String
    | LoadRoute
    | NotFoundRoute
