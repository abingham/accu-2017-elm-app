module ACCUSchedule.Types exposing (..)

import Date
import Time
import Uuid


-- TODO: What about things like lunch, special sessions, etc?


type alias Presenter =
    { firstName : String
    , lastName : String
    }


type alias Presentation =
    { id : Uuid.Uuid
    , title : String
    , description : String
    , presenters : List Presenter
    }


type alias Session =
    { time : Time.Time
    , length : Time.Time
    , presentation : Presentation
    }


type alias Room =
    { name : String
    , sessions : List Session
    }


type alias Day =
    { date : Date.Date
    , rooms : List Room
    }


emptyDay : Date.Date -> Day
emptyDay date =
    { date = date, rooms = [] }


type alias Schedule =
    { days : List Day
    }


emptySchedule : Schedule
emptySchedule =
    { days = []
    }


addDay : Day -> Schedule -> Schedule
addDay day schedule =
    { schedule | days = day :: schedule.days }



-- type ConversionDetails
--     = Initiated StatusLocator
--     | InProgress InProgressDetails
--     | Complete CompleteDetails
--     | Error String
