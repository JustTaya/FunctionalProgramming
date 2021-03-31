module WorkplaceEntity where

data WorkplaceEntity = WorkplaceEntity
  { uid :: Integer,
    class_id :: Integer,
    trainer_id :: Integer,
    name :: String,
    role :: String
  }
