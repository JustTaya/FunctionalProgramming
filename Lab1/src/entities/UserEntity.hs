module UserEntity where

data UserEntity = UserEntity
  { uid :: Maybe Integer,
    name :: String,
    surname :: String,
    email :: String,
    password :: String,
    is_trainer :: Bool
  }

createUser :: IO UserEntity
createUser = do
  putStrLn "Enter schedule name:"
  _name <- getLine
  putStrLn "Enter schedule surname:"
  _surname <- getLine
  putStrLn "Enter software email:"
  _email <- getLine
  putStrLn "Enter software password:"
  _password <- getLine
  putStrLn "Enter is_trainer"
  _is_trainer <- getLine
  return
    UserEntity
      { uid = Nothing,
        name = _name,
        surname = _surname,
        email = _email,
        password = _password,
        is_trainer = read _is_trainer :: Bool
      }

printUser :: UserEntity -> IO ()
printUser class_entity = do
  putStrLn "Schedule:"
  putStr (" Id: " ++ show (uid class_entity))
  putStr (" Name: " ++ name class_entity)
  putStr (" Surname: " ++ surname class_entity)
  putStr (" Email: " ++ email class_entity)
  putStr (" Password: " ++ password class_entity)
  putStr (" Is_trainer: " ++ show (is_trainer class_entity))
  putStrLn ""
