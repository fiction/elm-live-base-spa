module Main exposing (Model, init, main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (href)
import Route exposing (Route(..))
import Url exposing (Url)



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url
    , route : Maybe Route
    }


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        newRoute =
            Route.fromUrl url
    in
    ( Model key url newRoute, Cmd.none )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked (Browser.Internal url) ->
            let
                route =
                    Route.fromUrl url
            in
            ( { model | route = route }
            , Nav.pushUrl model.key (Url.toString url)
            )

        LinkClicked (Browser.External href) ->
            ( model, Nav.load href )

        UrlChanged url ->
            ( { model
                | url = url
              }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "Elm SPA"
    , body =
        [ page model.route model.url
        , ul []
            [ li [] [ a [ href "/" ] [ text "Home" ] ]
            , viewLink "/blog/1"
            , viewLink "/blog/23"
            , viewLink "/user/jono"
            , viewLink "/user/jono/comment/1"
            ]
        ]
    }


page : Maybe Route -> Url -> Html Msg
page maybeRoute url =
    case maybeRoute of
        Just Home ->
            div
                []
                [ h1 [] [ text "Home" ]
                , text "The current URL is: "
                , b [] [ text (Url.toString url) ]
                ]

        Just (Blog blogId) ->
            div
                []
                [ h1 [] [ text "Blog" ]
                , text "The current URL is: "
                , b [] [ text (Url.toString url) ]
                ]

        Just (User user) ->
            div
                []
                [ h1 [] [ text user ]
                , text "The current URL is: "
                , b [] [ text (Url.toString url) ]
                ]

        Just (Comment user commentId) ->
            div
                []
                [ h1 [] [ text (user ++ " comment") ]
                , text "The current URL is: "
                , b [] [ text (Url.toString url) ]
                ]

        Just NotFound ->
            div
                []
                [ h1 [] [ text "Nothing" ]
                , text "The current URL is: "
                , b [] [ text (Url.toString url) ]
                ]

        Nothing ->
            div
                []
                [ h1 [] [ text "404" ]
                , text "The current URL is: "
                , b [] [ text (Url.toString url) ]
                ]


viewLink : String -> Html Msg
viewLink path =
    li [] [ a [ href path ] [ text path ] ]
