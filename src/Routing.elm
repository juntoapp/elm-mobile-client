module Routing exposing (..)

import Navigation exposing (Location)
import Models
import UrlParser exposing (..)





matchers : Parser (Models.Route -> a) a
matchers =
    oneOf
        [ map Models.IndexRoute top
        , map Models.LoadRoute (s "load")
        ]

parseLocation : Location -> Models.Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            Models.NotFoundRoute
