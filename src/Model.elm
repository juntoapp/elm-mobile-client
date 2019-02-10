module Model exposing (..)

import Time
import Task


type alias Model =
    { number : Int
    }


initialModel : Model
initialModel =
    Model 0


type Route
    = StartRoute
    | DashboardRoute
    | LoadRoute
    | NotFoundRoute
