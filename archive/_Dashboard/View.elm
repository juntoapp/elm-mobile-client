module Dashboard.View exposing (..)

import Time
import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Msgs
import Models
-- import Dashboard.Calendar
-- import Dashboard.DayTitleBar


view : Models.Model -> String -> Html Msgs.Msg
view model selectedDate =
    div [ class "dashboard" ]
        [ div
            [ class "dashboard__header" ]
            [ topHeadBar
            -- , Dashboard.Calendar.view model (Time.fromString selectedDate)
            -- , Dashboard.DayTitleBar.view model (Time.fromString selectedDate)
            ]
        ]


topHeadBar : Html Msgs.Msg
topHeadBar =
    div [ class "topHeadBar" ]
        -- [ a [ href (Dashboard.Calendar.daySelectionPath Nothing) ] [ text "today" ] ]
        []