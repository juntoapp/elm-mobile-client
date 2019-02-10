module View exposing (view)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)

import Model exposing (Model)
import Message exposing (Msg)

import Dashboard.View


view : Model.Model -> Html Msg
view model =
   div [] [ 
       layout (Dashboard.View.view model)
    ]




layout : Html Msg -> Html Msg
layout page = 
    div 
    [ css 
        [ margin (px 0)
        , padding (px 0)
        , border2 (px 1) solid
        , maxWidth (px 1200)
        ]
    ]
    [ page ]


-- layout : Html Msg -> Html Msg
-- layout page = 
--     div 
--     [ css 
--         [ margin (px 12)
--         , backgroundColor theme.primary
--         , color (rgb 250 250 250)
--         , hover
--             [ backgroundColor theme.secondary
--             , textDecoration underline
--             ]  ]]
--         [ page ]