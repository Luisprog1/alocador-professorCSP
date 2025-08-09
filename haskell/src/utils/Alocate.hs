module Utils.Alocate where

import Utils.Schedule 
import Tipos
import Data.List as List
import Data.Map as Map


checkResources :: Eq a => [a] -> [a] -> Bool
checkResources requisitos recursos = all (\x -> elem x recursos) requisitos

allocateClass :: Class -> Classroom -> Bool
allocateClass clss classroom 
    | checkResources (requirements clss) (resources classroom)
    && (quantity clss <= capacity classroom)
    && not (isAnyOccupation classroom clss) = True
    | otherwise = False 
  
        
type AllocationSolution = Either Class [Allocation]
-- | Função principal: agora apenas chama as funções auxiliares.
backtrackAllocate :: Int -> [Class] -> [Classroom] -> (AllocationSolution, Int, [Classroom])
backtrackAllocate currentId [] classrooms = (Right [], currentId, classrooms)
backtrackAllocate currentId (clss:restClasses) classrooms =
    -- | Apenas chama a função 'tryAllocateClass'.
     -- | 'classrooms' é passado duas vezes para representar 'allRooms' e 'availableRooms' iniciais.
     tryAllocateClass currentId clss restClasses classrooms classrooms
     
-- | Tenta alocar uma turma em uma lista de salas.
-- | A função agora recebe a lista completa de salas, a lista de salas a tentar, e as classes restantes.
tryAllocateClass :: Int -> Class -> [Class] -> [Classroom] -> [Classroom] -> (AllocationSolution, Int, [Classroom])
tryAllocateClass currentId clss restClasses allRooms [] = (Left clss, currentId, allRooms)
tryAllocateClass currentId clss restClasses allRooms (room:otherRooms) =
    if allocateClass clss room
    then
        let newSchedule = Map.fromListWith (++) (List.map (\(day, hour) -> (day, [hour])) (schedule clss))
            updatedRoom = room {
            roomSchedule = Map.unionWith (++) (roomSchedule room) newSchedule
            }
            updatedAllRooms = replaceRoom allRooms updatedRoom
            (subAllocation, finalSubId, finalRooms) = backtrackAllocate (currentId + 1) restClasses updatedAllRooms
        in
        case subAllocation of
            Right subAlloc -> (Right (createAllocation currentId clss room : subAlloc), finalSubId, finalRooms)
            Left conflictCls -> (Left conflictCls, currentId, allRooms)
    else
        tryAllocateClass currentId clss restClasses allRooms otherRooms

-- | Substitui uma sala atualizada na lista de todas as salas.
replaceRoom :: [Classroom] -> Classroom -> [Classroom]
replaceRoom [] _ = []
replaceRoom (r:rs) updatedR
    | classroomCode r == classroomCode updatedR = updatedR : rs
    | otherwise = r : replaceRoom rs updatedR
     
-- | Cria um objeto 'Allocation'.
createAllocation :: Int -> Class -> Classroom -> Allocation
createAllocation allocId clss classroom =
    Allocation {
        allocationId = allocId,
        allocClassId = classId clss,
        allocProfessorId = professorId clss,
        allocClassroomCode = classroomCode classroom
        }   