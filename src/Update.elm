module Update exposing (..)
import Routing exposing (parseLocation)
import Msgs

update msg model =
    case msg of
        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )


        _ ->
            (model, Cmd.none)
