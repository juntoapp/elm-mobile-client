module Dashboard exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Msgs
import Models
import DashboardCalendar


view : Models.Model -> Html Msgs.Msg
view model =
    div [ class "dashboard" ]
        [ header model ]


header : Models.Model -> Html Msgs.Msg
header model =
    div
        [ class "dashboard__header" ]
        [ calendar model
        ]


calendar : Models.Model -> Html Msgs.Msg
calendar model =
    div []
        ([ div
            [ class "calendar__weekdays--title" ]
            ([ "M", "T", "W", "T", "F", "S", "S" ]
                |> List.map (\x -> div [ class "calendar__weekday--title" ] [ text x ])
            )
         ]
            ++ (DashboardCalendar.calendarDays model)
        )
