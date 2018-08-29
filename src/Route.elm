module Route exposing (Route(..), fromUrl, parser)

import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, int, map, oneOf, s, string)


type Route
    = Home
    | Blog Int
    | User String
    | Comment String Int
    | NotFound


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Home Parser.top
        , map Home (s "")
        , map Blog (s "blog" </> int)
        , map User (s "user" </> string)
        , map Comment (s "user" </> string </> s "comment" </> int)
        ]


fromUrl : Url -> Maybe Route
fromUrl url =
    Parser.parse parser url
