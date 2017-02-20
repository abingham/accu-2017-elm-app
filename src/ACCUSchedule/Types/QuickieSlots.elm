module ACCUSchedule.Types.QuickieSlots exposing (..)


type QuickieSlot
    = Slot1
    | Slot2
    | Slot3
    | Slot4


ordinal : QuickieSlot -> Int
ordinal slot =
    case slot of
        Slot1 ->
            1

        Slot2 ->
            2

        Slot3 ->
            3

        Slot4 ->
            4

toString : QuickieSlot -> String
toString slot =
    case slot of
        Slot1 ->
            "Slot 1"
        Slot2 ->
            "Slot 2"
        Slot3 ->
            "Slot 3"
        Slot4 ->
            "Slot 4"
