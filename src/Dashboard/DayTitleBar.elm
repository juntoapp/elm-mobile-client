module Dashboard.DayTitleBar exposing (..)

import Date exposing (Date)
import Date.Extra as Date exposing (Interval(..))
import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Msgs
import Models


labels =
    { today = "today"
    , yesterday = "yesterday"
    , tomorrow = "tomorrow"
    , dbyesterday = "day before yesterday"
    , datomorrow = "day after tomorrow"
    , blank = ""
    , fail = "unable to get current timestamp"
    }


view : Models.Model -> Result error Date -> Html Msgs.Msg
view model paramSelectedDay =
    case model.routeLoaded of
        Nothing ->
            printBar labels.blank labels.fail

        Just today ->
            case paramSelectedDay of
                Err errMsg ->
                    let
                        formatedDate =
                            formateDate today
                    in
                        printBar labels.today formatedDate

                Ok selectedDay ->
                    let
                        formatedDate =
                            formateDate selectedDay

                        relationToToday =
                            processRelation today selectedDay
                    in
                        printBar relationToToday formatedDate


formateDate : Date -> String
formateDate date =
    (toString (Date.dayOfWeek date) ++ ", " ++ toString (Date.month date) ++ " " ++ toString (Date.day date))


processRelation : Date -> Date -> String
processRelation ptoday pselectedDay =
    let
        today =
            removeTimeFromDate ptoday

        selectedDay =
            removeTimeFromDate pselectedDay
    in
        if (Date.compare selectedDay today == EQ) then
            labels.today
        else if (Date.compare selectedDay today == LT) then
            case (Date.diff Day selectedDay today) of
                1 ->
                    labels.yesterday

                2 ->
                    labels.dbyesterday

                _ ->
                    labels.blank
        else
            case (Date.diff Day selectedDay today) of
                (-1) ->
                    labels.tomorrow

                (-2) ->
                    labels.datomorrow

                _ ->
                    labels.blank


removeTimeFromDate : Date -> Date
removeTimeFromDate x =
    Date.fromParts (Date.year x) (Date.month x) (Date.day x) 0 0 0 0


printBar : String -> String -> Html Msgs.Msg
printBar relation formatedDate =
    if relation == labels.blank then
        div [ class "calendar__dayTitleBar" ]
            [ span [ class "calendar__selectedDay" ] [ text formatedDate ]
            ]
    else
        div [ class "calendar__dayTitleBar" ]
            [ span [ class "calendar__selectedDay" ] [ text formatedDate ]
            , span [ class "calendar__selectedDay" ] [ text "•" ]
            , span [ class "calendar__selectedDay" ] [ text relation ]
            ]
