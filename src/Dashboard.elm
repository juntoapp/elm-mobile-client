module Dashboard exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Date exposing (Date)
import Msgs
import Models


view : Models.Model -> Html Msgs.Msg
view model =
    div [ class "dashboard" ]
        [ calendar model ]


calendar : Models.Model -> Html Msgs.Msg
calendar model =
    div
        [ class "dashboard__header" ]
        [ div [ class "calendar__weekdays--title" ]
            ([ "M", "T", "W", "T", "F", "S", "S" ]
                |> List.map (\x -> div [ class "calendar__weekday--title" ] [ text x ])
            )
        , div
            [ class "calendar__weekdays" ]
            [ calendarDays model ]
        ]


calendarDays : Models.Model -> Html Msgs.Msg
calendarDays model =
    let
        today =
            case model.routeLoaded of
                Just date ->
                    Date.day date

                _ ->
                    1
    in
        (text << toString) today
