module Theme exposing (..)

import Css exposing (..)

type alias ThemeColors =  
    { primary : Color
    , secondary: Color
    , tertiary: Color
    }


theme : { colors : ThemeColors, fontSizes: List Int }
theme =
    { colors = 
        { primary = rgb 255 87 34
        , secondary = rgb 250 240 230
        , tertiary = rgb 250 240 230
        }
    , fontSizes = 
        [ 14
        , 16 
        , 20
        , 24
        ]
    }

