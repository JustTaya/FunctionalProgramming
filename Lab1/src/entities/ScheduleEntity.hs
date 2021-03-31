module ScheduleEntity where

--import Data.Time

data UserEntity = UserEntity
  { uid :: Integer,
    class_id :: Integer,
--    start_datetime :: UTCTime,
--    end_datetime :: UTCTime,
    trainer_id :: Integer
  }
