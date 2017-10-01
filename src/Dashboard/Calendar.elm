module Dashboard.Calendar exposing (..)

import Date exposing (Date)
import Date.Extra as Date exposing (Interval(..))
import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Msgs
import Models


view : Models.Model -> Result error Date -> Html Msgs.Msg
view model paramSelectedDay =
    case model.routeLoaded of
        Just today ->
            case paramSelectedDay of
                Ok selectedDay ->
                    div []
                        ([ div
                            [ class "calendar__weekdays calendar__weekdays--title" ]
                            ([ "M", "T", "W", "T", "F", "S", "S" ]
                                |> List.map (\x -> div [ class "calendar__weekday calendar__weekday--title" ] [ text x ])
                            )
                         ]
                            ++ (generateDays selectedDay today)
                        )

                _ ->
                    div []
                        ([ div
                            [ class "calendar__weekdays calendar__weekdays--title" ]
                            ([ "M", "T", "W", "T", "F", "S", "S" ]
                                |> List.map (\x -> div [ class "calendar__weekday calendar__weekday--title" ] [ text x ])
                            )
                         ]
                            ++ (generateDays today today)
                        )

        _ ->
            div [] [ text "failed to generate calendar" ]


generateDays : Date -> Date -> List (Html Msgs.Msg)
generateDays selectedDay today =
    let
        firstRow =
            genRow [ Date.add Week -1 selectedDay ]

        secondRow =
            genRow [ selectedDay ]

        thirdRow =
            genRow [ Date.add Week 1 selectedDay ]
    in
        [ (div [ class "calendar__weekdays" ] (List.map (dayToHtml selectedDay today) firstRow))
        , (div [ class "calendar__weekdays" ] (List.map (dayToHtml selectedDay today) secondRow))
        , (div [ class "calendar__weekdays" ] (List.map (dayToHtml selectedDay today) thirdRow))
        ]


dayToHtml : Date -> Date -> Date -> Html Msgs.Msg
dayToHtml selectedDay today day =
    let
        time =
            case compareDates day today of
                EQ ->
                    "calendar__weekday--today "

                LT ->
                    "calendar__weekday--past "

                GT ->
                    ""

        selected =
            if (selectedDay == day) then
                "calendar__weekday--selected "
            else
                ""

        classes =
            (time ++ selected)
    in
        div [ class ("calendar__weekday " ++ classes) ] [ a [ href (daySelectionPath (Just day)) ] [ (text << toString << Date.day) day ] ]


daySelectionPath : Maybe Date -> String
daySelectionPath datemaybe =
    case datemaybe of
        Just date ->
            "#dashboard/" ++ (dateToString date)

        _ ->
            "#dashboard/"


compareDates : Date -> Date -> Order
compareDates x y =
    compare (timeStampToInteger x) (timeStampToInteger y)


timeStampToInteger : Date -> Int
timeStampToInteger x =
    Result.withDefault 0
        (String.toInt
            (""
                ++ (toString (Date.year x))
                ++ (String.padLeft 2 '0' (toString (Date.monthNumber x)))
                ++ (String.padLeft 2 '0' (toString (Date.day x)))
            )
        )


dateToString : Date -> String
dateToString x =
    (""
        ++ (toString (Date.year x))
        ++ "-"
        ++ (String.padLeft 2 '0' (toString (Date.monthNumber x)))
        ++ "-"
        ++ (String.padLeft 2 '0' (toString (Date.day x)))
    )


genRow : List Date -> List Date
genRow row =
    if List.length row == 7 then
        row
    else
        let
            headDate =
                case List.head row of
                    Just x ->
                        if weekDayToNum x > 0 then
                            [ (Date.add Day -1 x) ]
                        else
                            []

                    _ ->
                        []

            tailDate =
                case listLastElem row of
                    Just x ->
                        if weekDayToNum x < 6 then
                            [ (Date.add Day 1 x) ]
                        else
                            []

                    _ ->
                        []
        in
            genRow (List.concat [ headDate, row, tailDate ])


weekDayToNum : Date -> Int
weekDayToNum d =
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


listLastElem : List a -> Maybe a
listLastElem list =
    case list of
        [] ->
            Nothing

        [ last ] ->
            Just last

        head :: rest ->
            listLastElem rest
