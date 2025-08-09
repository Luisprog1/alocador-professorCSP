module Tipos where
import qualified Data.Map as Map

data Resource = Projector | Laboratory | Acessibility | Whiteboard deriving(Show, Eq, Read)

data Class = Class {  
classId :: Int,
subject :: String,
course :: String,
professorId :: Int,
schedule :: [(Weekday, Int)],
quantity :: Int,
requirements :: [Resource]
} deriving (Show, Eq, Read)

data Classroom = Classroom { 
classroomCode :: String,
capacity :: Int,
block :: String,
resources :: [Resource],
roomSchedule :: ScheduleMap
} deriving (Show, Eq, Read)

data Allocation = Allocation { 
allocationId :: Int, 
allocClassId :: Int,
allocProfessorId :: Int,
allocClassroomCode :: String
}deriving (Show, Eq, Read)

data Weekday = Segunda | Terca | Quarta | Quinta | Sexta deriving (Show, Eq, Read, Ord)
type ScheduleMap = Map.Map Weekday [Int]
