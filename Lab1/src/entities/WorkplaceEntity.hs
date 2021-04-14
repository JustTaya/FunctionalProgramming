module WorkplaceEntity where

data WorkplaceEntity = WorkplaceEntity
  { uid :: Maybe Integer,
    class_id :: Integer,
    trainer_id :: Integer,
    role :: String
  }

createWorkplace :: IO WorkplaceEntity
createWorkplace = do
  putStrLn "Enter schedule class_id:"
  _class_id <- getLine
  putStrLn "Enter schedule trainer_id:"
  _trainer_id <- getLine
  putStrLn "Enter software role:"
  _role <- getLine
  return
    WorkplaceEntity
      { uid = Nothing,
        class_id = read _class_id :: Integer,
        trainer_id = read _trainer_id :: Integer,
        role = _role
      }

printWorkplace :: WorkplaceEntity -> IO ()
printWorkplace class_entity = do
  putStrLn "Schedule:"
  putStr ("Id" ++ show (uid class_entity))
  putStr (" Role" ++ role class_entity)
