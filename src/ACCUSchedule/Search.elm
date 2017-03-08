module ACCUSchedule.Search exposing (search)

import ACCUSchedule.Model exposing (Model, presenters)
import ACCUSchedule.Types exposing (Presenter, Proposal)


lcontains : String -> String -> Bool
lcontains term text =
    String.contains (String.toLower term) (String.toLower text)


presentersMatch : String -> Model -> Proposal -> Bool
presentersMatch term model proposal =
    let
        pmatch p =
            lcontains term p.firstName
                || lcontains term p.lastName
    in
        List.any pmatch (presenters model proposal)


search : String -> Model -> List Proposal
search term model =
    let
        matches p =
            lcontains term p.text
                || lcontains term p.title
                || presentersMatch term model p
    in
        model.proposals
            |> List.filter
                matches
