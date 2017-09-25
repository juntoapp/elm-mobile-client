module Update exposing (..)

import Routing exposing (parseLocation)
import Date exposing (Date)
import Task
import Msgs


update msg model =
    case msg of
        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Task.perform Msgs.SetDate Date.now )

        Msgs.SetDate date ->
            ( { model | routeLoaded = Just date }, Cmd.none )

        _ ->
            ( model, Cmd.none )
