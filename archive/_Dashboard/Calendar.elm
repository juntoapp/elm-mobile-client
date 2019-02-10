module Dashboard.Calendar exposing (..)

import Time
-- import Time.Extra as Date exposing (Interval(..))
import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Msgs
import Models


view : Models.Model -> Result error Time.Posix -> Html Msgs.Msg
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


generateDays : Time.Posix -> Time.Posix -> List (Html Msgs.Msg)
generateDays selectedDay today =
    let
        firstRow =
            genRow [ Time.add Week -1 selectedDay ]

        secondRow =
            genRow [ selectedDay ]

        thirdRow =
            genRow [ Time.add Week 1 selectedDay ]
    in
        [ (div [ class "calendar__weekdays" ] (List.map (dayToHtml selectedDay today) firstRow))
        , (div [ class "calendar__weekdays" ] (List.map (dayToHtml selectedDay today) secondRow))
        , (div [ class "calendar__weekdays" ] (List.map (dayToHtml selectedDay today) thirdRow))
        ]


dayToHtml : Time.Posix -> Time.Posix -> Time.Posix -> Html Msgs.Msg
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
        div [ class ("calendar__weekday " ++ classes) ] [ a [ href (daySelectionPath (Just day)) ] [ (text << toString << Time.day) day ] ]


daySelectionPath : Maybe Time.Posix -> String
daySelectionPath datemaybe =
    case datemaybe of
        Just Time.Posix ->
            "#dashboard/" ++ (dateToString date)

        _ ->
            "#dashboard/"


compareDates : Time.Posix -> Time.Posix -> Order
compareDates x y =
    compare (timeStampToInteger x) (timeStampToInteger y)


timeStampToInteger : Time.Posix -> Int
timeStampToInteger x =
    Result.withDefault 0
        (String.toInt
            (""
                ++ (String.fromInt (Time.toYear Time.utc x))
                ++ (String.padLeft 2 '0' (String.fromInt (toMonthInt x)))
                ++ (String.padLeft 2 '0' (String.fromInt (Time.toDay x)))
            )
        )


dateToString : Time.Posix -> String
dateToString x =
    (""
        ++ (String.fromInt (Time.toYear Time.utc x))
        ++ "-"
        ++ (String.padLeft 2 '0' (toMonthInt x))
        ++ "-"
        ++ (String.padLeft 2 '0' (String.fromInt (Time.toDay x)))
    )


genRow : List Time.Posix -> List Time.Posix
genRow row =
    if List.length row == 7 then
        row
    else
        let
            headDate =
                case List.head row of
                    Just x ->
                        if weekDayToInt x > 0 then
                            [ (Time.add Day -1 x) ]
                        else
                            []

                    _ ->
                        []

            tailDate =
                case listLastElem row of
                    Just x ->
                        if weekDayToInt x < 6 then
                            [ (Time.add Day 1 x) ]
                        else
                            []

                    _ ->
                        []
        in
            genRow (List.concat [ headDate, row, tailDate ])


weekDayToInt : Time.Posix -> Int
weekDayToInt d =
    case Time.toWeekday d of
        Time.Mon -> 0
        Time.Tue -> 1
        Time.Wed -> 2
        Time.Thu -> 3
        Time.Fri -> 4
        Time.Sat -> 5
        Time.Sun -> 6

toMonthInt : Time.Posix -> String
toMonthInt time =
  case time.toMonth of
    Time.Jan -> 1
    Time.Feb -> 2
    Time.Mar -> 3
    Time.Apr -> 4
    Time.May -> 5
    Time.Jun -> 6
    Time.Jul -> 7
    Time.Aug -> 8
    Time.Sep -> 9
    Time.Oct -> 10
    Time.Nov -> 11
    Time.Dec -> 12


listLastElem : List a -> Maybe a
listLastElem list =
    case list of
        [] ->
            Nothing

        [ last ] ->
            Just last

        head :: rest ->
            listLastElem rest
