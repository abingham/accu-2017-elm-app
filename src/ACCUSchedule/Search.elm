module ACCUSchedule.Search exposing (search)

import ACCUSchedule.Model exposing (Model)
import ACCUSchedule.Types exposing (Proposal)


fields : Proposal -> List String
fields proposal =
    let
        fullName p =
            p.firstName ++ " " ++ p.lastName
    in
        [ proposal.text
        , proposal.title
        ]
            ++ (List.map fullName proposal.presenters)


search : String -> Model -> List Proposal
search term =
    let
        lterm =
            String.toLower term

        matching =
            String.toLower
                >> String.contains lterm

        fieldMatch =
            fields
                >> List.any matching
    in
        .proposals
            >> List.filter
                fieldMatch
