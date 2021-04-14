module ScheduleEntity where

data ScheduleEntity = ScheduleEntity
  { uid :: Maybe Integer,
    class_id :: Integer,
    start_datetime :: String,
    end_datetime :: String,
    trainer_id :: Integer
  }

createSchedule :: IO ScheduleEntity
createSchedule = do
  putStrLn "Enter schedule class_id:"
  _class_id <- getLine
  putStrLn "Enter schedule start_datetime:"
  _start_datetime <- getLine
  putStrLn "Enter software end_datetime:"
  _end_datetime <- getLine
  putStrLn "Enter software trainer_id:"
  _trainer_id <- getLine
  return
    ScheduleEntity
      { uid = Nothing,
        class_id = read _class_id :: Integer,
        start_datetime = _start_datetime,
        end_datetime = _end_datetime,
        trainer_id = read _trainer_id :: Integer
      }


printSchedule :: ScheduleEntity -> IO ()
printSchedule class_entity = do
  putStrLn "Schedule:"
  putStrLn ("Id" ++ show (uid class_entity))
  putStr ("Class_id" ++ show (class_id class_entity))
  putStr ("Start_datetime" ++ start_datetime class_entity)
  putStr (" End_datetime" ++ end_datetime class_entity)
  putStr ("Trainer_id" ++ show (trainer_id class_entity))
  putStrLn ""
