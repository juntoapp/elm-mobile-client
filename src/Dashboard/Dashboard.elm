module Dashboard.Dashboard exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Msgs exposing (..)
import Models exposing (..)


view : Models.Model -> Html Msg
view model =
    div []
        [ text "hallo Welt" ]
