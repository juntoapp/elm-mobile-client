module DashboardCalendar exposing (..)

import Date exposing (Date)
import Date.Extra as Date exposing (Interval(..))
import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Msgs
import Models


calendarDays : Models.Model -> List (Html Msgs.Msg)
calendarDays model =
    let
        result =
            case model.routeLoaded of
                Just date ->
                    generateCalendar date model

                _ ->
                    [ text "failed" ]
    in
        result


generateCalendar : Date -> Models.Model -> List (Html Msgs.Msg)
generateCalendar date model =
    let
        firstRow =
            genRow [ Date.add Week -1 date ]

        secondRow =
            genRow [ date ]

        thirdRow =
            genRow [ Date.add Week 1 date ]
    in
        [ (div [ class "calendar__weekdays" ] (List.map (dayToHtml model) firstRow))
        , (div [ class "calendar__weekdays" ] (List.map (dayToHtml model) secondRow))
        , (div [ class "calendar__weekdays" ] (List.map (dayToHtml model) thirdRow))
        ]


dayToHtml : Models.Model -> Date -> Html Msgs.Msg
dayToHtml model date =
    let
        res =
            case model.routeLoaded of
                Just day ->
                    let
                        order =
                            Date.compare date day
                    in
                        if order == EQ then
                            div [ class "calendar__weekday--today" ] [ (text << toString << Date.day) date ]
                        else if order == LT then
                            div [ class "calendar__weekday--past" ] [ (text << toString << Date.day) date ]
                        else
                            div [ class "calendar__weekday" ] [ (text << toString << Date.day) date ]

                _ ->
                    div [ class "calendar__weekday" ] [ (text << toString << Date.day) date ]
    in
        res


genRow : List Date -> List Date
genRow row =
    if List.length row == 7 then
        row
    else
        let
            headDate =
                case List.head row of
                    Just x ->
                        if weekDay x > 0 then
                            [ (Date.add Day -1 x) ]
                        else
                            []

                    _ ->
                        []

            tailDate =
                case lastElem row of
                    Just x ->
                        if weekDay x < 6 then
                            [ (Date.add Day 1 x) ]
                        else
                            []

                    _ ->
                        []
        in
            genRow (List.concat [ headDate, row, tailDate ])


lastElem : List a -> Maybe a
lastElem list =
    case list of
        [] ->
            Nothing

        [ last ] ->
            Just last

        head :: rest ->
            lastElem rest


weekDay : Date -> Int
weekDay d =
    case Date.dayOfWeek d of
        Date.Mon ->
            0

        Date.Tue ->
            1

        Date.Wed ->
            2

        Date.Thu ->
            3

        Date.Fri ->
            4

        Date.Sat ->
            5

        Date.Sun ->
            6
