module ClassEntity where

data ClassEntity = ClassEntity
  { uid :: Maybe Integer,
    name :: String,
    description :: String
  }

createClass :: IO ClassEntity
createClass = do
  putStrLn "Enter class name:"
  _name <- getLine
  putStrLn "Enter class description:"
  _description <- getLine
  return
    ClassEntity
      { uid = Nothing,
        name = _name,
        description = _description
      }


printClass :: ClassEntity -> IO ()
printClass class_entity = do
  putStrLn "Class:"
  putStrLn ("Id" ++ show (uid class_entity))
  putStr (" Name" ++ name class_entity)
  putStr (" Annotation" ++ description class_entity)
