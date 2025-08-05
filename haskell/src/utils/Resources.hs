module Utils.Resources where
import Tipos
import Data.Char (toLower)
import Data.List (nub, find)
import System.IO (hFlush, stdout)
import Text.Read (readMaybe)



resourcesMenu :: String
resourcesMenu = unlines [  "1. Projetor"
                         , "2. Laboratório"
                         , "3. Acessibilidade"
                         , "4. Quadro Branco"
                         ]


-- | Função auxiliar para converter uma string em um recurso. Usada no menu de recursos (ou requisitos).
parseResource :: String -> Resource
parseResource op = case op of
  "1"     -> Projector
  "2"    -> Laboratory
  "3"  -> Acessibility
  "4" -> Whiteboard
  _ -> error ("Recurso inexistente")

-- =========================
-- ADIÇÃO DE REQUISITOS DAS TURMAS
-- =========================

-- | Adiciona um recurso a uma turma com base no ID da turma.
addRequirements :: Resource -> Int -> [Class] -> IO [Class]
addRequirements resource classID clss = do
    let clss' = map (\c -> if classId c == classID then c {requirements = nub (resource : requirements c)} else c) clss
    return clss'

-- | Remove um recurso de uma turma com base no ID da turma.
removeRequirements :: Resource -> Int -> [Class] -> IO [Class]
removeRequirements resource classID clss= do
    let clss' = map (\c -> if classId c == classID then c { requirements = filter (/= resource) (requirements c) } else c) clss
    return clss'

-- | Verifica se o professor tem permissão para alterar os requisitos da turma.
verifyIfProfessorHasClass :: [Class] -> Int -> Int -> Int -> Maybe Bool
verifyIfProfessorHasClass classes typeId profId clssId =
  if typeId == 0 then Just True else do
  clss <- find (\c -> classId c == clssId) classes
  return (professorId clss == profId)


-- | Adiciona ou remove requisitos de uma turma.
change_requirements :: [Class] -> Int -> Int -> IO [Class]
change_requirements classes typeId profId = do
    putStrLn "Informe o ID da turma:"
    hFlush stdout
    classId <- getLine
    case verifyIfProfessorHasClass classes typeId profId (read classId) of
      Nothing -> do
        putStrLn "Turma não encontrada. Tente novamente."
        change_requirements classes typeId profId
      Just False -> do
        putStrLn "Você não tem permissão para alterar os requisitos desta turma."
        change_requirements classes typeId profId
      Just True ->
        case readMaybe classId :: Maybe Int of
          Nothing -> do
            putStrLn "ID inválido. Por favor, insira um número inteiro válido."
            change_requirements classes typeId profId
          Just classId -> do
            putStrLn "1. Adicionar"
            putStrLn "2. Remover"
            hFlush stdout
            op <- getLine
            case op of
              "1" -> do
                putStrLn resourcesMenu
                hFlush stdout
                req <- getLine
                clss' <- addRequirements (parseResource req) classId classes
                return clss'
              "2" -> do
                putStrLn resourcesMenu
                req <- getLine
                clss' <- removeRequirements (parseResource req) classId classes
                return clss'
              _ -> do
                putStrLn "Opção inválida. Tente novamente."
                change_requirements classes typeId profId
                
-- =========================
-- ADIÇÃO DE RECURSOS DAS SALAS
-- =========================

-- | Adiciona um recurso a uma sala de aula com base no código da sala.
addResources :: Resource -> String -> [Classroom] -> IO [Classroom]
addResources resource classroomCode' clssrms = do
    let clssrms' = map (\c -> if classroomCode c == classroomCode'
                                then c { resources = nub (resource : resources c) }
                                else c) clssrms
    return clssrms'

-- | Remove um recurso de uma sala de aula com base no código da sala.
removeResources :: Resource -> String -> [Classroom] -> IO [Classroom]
removeResources resource classroomCode' clssrms = do
    let clssrms' = map (\c -> if classroomCode c == classroomCode'
                                then c { resources = filter (/= resource) (resources c) }
                                else c) clssrms
    return clssrms'

-- | Verifica se o código da sala de aula existe na lista.
verifyIfClassroomExists :: [Classroom] -> String -> Maybe Bool
verifyIfClassroomExists classrooms classroomCode' = do
    _ <- find (\c -> classroomCode c == classroomCode') classrooms
    return True

-- | Adiciona ou remove recursos de uma sala de aula.
change_resources :: [Classroom] -> IO [Classroom]
change_resources classrooms = do
    putStrLn "Informe o código da sala de aula:"
    hFlush stdout
    classroomCode' <- getLine
    case verifyIfClassroomExists classrooms classroomCode' of
      Nothing -> do
        putStrLn "Sala de aula não encontrada. Tente novamente."
        change_resources classrooms
      Just True -> do
        putStrLn "1. Adicionar recurso"
        putStrLn "2. Remover recurso"
        hFlush stdout
        op <- getLine
        case op of
          "1" -> do
            putStrLn resourcesMenu
            hFlush stdout
            req <- getLine
            clssrms' <- addResources (parseResource req) classroomCode' classrooms
            putStrLn "Recurso adicionado com sucesso!"
            return clssrms'
          "2" -> do
            putStrLn resourcesMenu
            hFlush stdout
            req <- getLine
            clssrms' <- removeResources (parseResource req) classroomCode' classrooms
            putStrLn "Recurso removido com sucesso!"
            return clssrms'
          _ -> do
            putStrLn "Opção inválida. Tente novamente."
            change_resources classrooms
      Just False -> do
        putStrLn "Sala de aula não encontrada. Tente novamente."
        change_resources classrooms