module UserEntity where

data UserEntity = UserEntity
  { uid :: Integer,
    name :: String,
    surname :: String,
    email :: String,
    password :: String,
    is_trainer :: Bool
  }
