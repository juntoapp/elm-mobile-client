module Dashboard.View exposing (..)

import Time
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)

import Theme
import Message exposing (Msg)
import Model exposing (Model)
-- import Dashboard.Calendar
-- import Dashboard.DayTitleBar


view : Model -> Html Msg
view model =
    div [ css 
            [ displayFlex
            , flexDirection column
            , flexWrap noWrap
            , justifyContent flexStart
            ] 
        ]
        [ div   [ css 
                    [ displayFlex
                    , flexDirection row
                    , flexWrap noWrap
                    , justifyContent center
                    ] 
                ]
                [ viewWeekDay "M"
                , viewWeekDay "T" 
                , viewWeekDay "W" 
                , viewWeekDay "T" 
                , viewWeekDay "F" 
                , viewWeekDay "S" 
                , viewWeekDay "S" 
                ]
        ]


viewWeekDay : String -> Html Msg
viewWeekDay txt =
    div [ css 
    [ width (pct 100)
    , textAlign center
    , color Theme.theme.colors.primary
    ]] [ text txt ]
