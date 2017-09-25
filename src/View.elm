module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model)
import Msgs exposing (Msg)
import Dashboard


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.StartRoute ->
            Dashboard.view model

        _ ->
            notFoundView model


notFoundView : Model -> Html Msg
notFoundView model =
    div []
        [ text "404" ]
