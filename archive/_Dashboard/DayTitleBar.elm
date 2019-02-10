module Dashboard.DayTitleBar exposing (..)

import Time
-- import Time.Extra as Date exposing (Interval(..))
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


view : Models.Model -> Result error Time.Posix -> Html Msgs.Msg
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
                            labels.blank
                    in
                        printBar relationToToday formatedDate


toMonthString : Time.Month -> String
toMonthString month =
  case month of
    Time.Jan -> "Jan"
    Time.Feb -> "Feb"
    Time.Mar -> "Mar"
    Time.Apr -> "Apr"
    Time.May -> "May"
    Time.Jun -> "Jun"
    Time.Jul -> "Jul"
    Time.Aug -> "Aug"
    Time.Sep -> "Sep"
    Time.Oct -> "Oct"
    Time.Nov -> "Nov"
    Time.Dec -> "Dec"

toWeekdayString : Time.Weekday -> String
toWeekdayString weekday =
  case weekday of
    Time.Mon -> "Mon"
    Time.Tue -> "Tue"
    Time.Wed -> "Wed"
    Time.Thu -> "Thu"
    Time.Fri -> "Fri"
    Time.Sat -> "Sat"
    Time.Sun -> "Sun"

formateDate : Time.Posix -> String
formateDate date =
    (toWeekdayString (Time.toWeekday Time.utc date) ++ ", " ++ toMonthString (Time.toMonth Time.utc date) ++ " " ++ String.fromInt (Time.toDay Time.utc date))


-- processRelation : Date -> Date -> String
-- processRelation ptoday pselectedDay =
--     let
--         today =
--             removeTimeFromDate ptoday

--         selectedDay =
--             removeTimeFromDate pselectedDay
--     in
--         if (Time.compare selectedDay today == EQ) then
--             labels.today
--         else if (Time.compare selectedDay today == LT) then
--             case (Time.diff Time.Day selectedDay today) of
--                 1 ->
--                     labels.yesterday

--                 2 ->
--                     labels.dbyesterday

--                 _ ->
--                     labels.blank
--         else
--             case (Time.diff Time.Day selectedDay today) of
--                 (-1) ->
--                     labels.tomorrow

--                 (-2) ->
--                     labels.datomorrow

--                 _ ->
--                     labels.blank


-- removeTimeFromDate : Date -> Date
-- removeTimeFromDate x =
--     Time.fromParts (Time.year x) (Time.month x) (Time.day x) 0 0 0 0


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
