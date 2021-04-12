module ScheduleEntity where

data ScheduleEntity = ScheduleEntity
  { uid :: Integer,
    class_id :: Integer,
    start_datetime :: String,
    end_datetime :: String,
    trainer_id :: Integer
  }
