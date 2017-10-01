module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model)
import Msgs exposing (Msg)
import Dashboard.View


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.DashboardRoute ->
            Dashboard.View.view model ""

        Models.DashboardDateRoute selectedDate ->
            Dashboard.View.view model selectedDate

        _ ->
            notFoundView model


notFoundView : Model -> Html Msg
notFoundView model =
    div []
        [ text "404" ]
