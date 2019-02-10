module Main exposing (..)

import Browser
import Html.Styled exposing (toUnstyled)

import Model exposing (Model)
import Message exposing (Msg)
import View exposing (view)



update : Msg -> Model -> Model
update msg model =
  model



main =
  Browser.sandbox 
  { init = Model.initialModel
  , update = update
  , view = view >> toUnstyled 
  }
