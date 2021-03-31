module UsersRepository where

import UserEntity
import DefaultRepository
import qualified Data.ByteString.Char8 as BS
import Database.HDBC
  
unpack :: [SqlValue] -> UserEntity
unpack [SqlInteger _uid, SqlByteString _name, SqlByteString _surname, SqlByteString _email, SqlByteString _password, SqlBool _is_trainer] =
  UserEntity
    { uid = _uid,
      name = BS.unpack _name,
      surname = BS.unpack _surname,
      email = BS.unpack _email,
      password = BS.unpack _password,
      is_trainer = _is_trainer
    }
unpack x = error $ "Unexpected result: " ++ show x

instance DefaultRepository UserEntity where
  getAll conn = do
      result <- quickQuery' conn query []
      return $ map unpack result
      where
        query = "select * from users order by id"
        
  getById conn _uid = do
      result <- quickQuery' conn query [SqlInteger _uid]
      let rows = map unpack result
      return $
        if null rows
          then Nothing
          else Just (last rows)
      where
        query = "select * from users where id = ?"
        
  deleteAll conn _ = do
      changed <- run conn query []
      return $ changed == 1
      where
        query = "delete from users"
        
  deleteById conn _uid _ = do
      changed <- run conn query [SqlInteger _uid]
      return $ changed == 1
      where
        query = "delete from users where id = ?"
        
  create conn entity = do
      _ <- run conn query [SqlString (name entity), SqlString (surname entity), SqlString (email entity), SqlString (password entity), SqlBool (is_trainer entity)]
      result <- quickQuery' conn lastId []
      let rows = map unpack result
      return $ last rows
      where
        query = "insert into users (name, surname, email, password, is_trainer) values (?, ?, ?, ?, ?)"
        lastId = "select * from users order by id desc limit 1"