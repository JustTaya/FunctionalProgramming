module ClassesRepository where

import ClassEntity
import DefaultRepository
import qualified Data.ByteString.Char8 as BS
import Database.HDBC

unpack :: [SqlValue] -> ClassEntity
unpack [SqlInteger _uid, SqlByteString _name, SqlByteString _description] =
  ClassEntity
    { uid = Just _uid,
      name = BS.unpack _name,
      description = BS.unpack _description
    }
unpack x = error $ "Unexpected result: " ++ show x

instance DefaultRepository ClassEntity where
  getAll conn = do
    result <- quickQuery' conn query []
    return $ map unpack result
    where
      query = "select * from classes order by id"

  getById conn _uid = do
    result <- quickQuery' conn query [SqlInteger _uid]
    let rows = map unpack result
    return $
      if null rows
        then Nothing
        else Just (last rows)
    where
      query = "select * from classes where id = ?"

  deleteAll conn _ = do
    changed <- run conn query []
    return $ changed == 1
    where
      query = "delete from classes"

  deleteById conn _uid _ = do
    changed <- run conn query [SqlInteger _uid]
    return $ changed == 1
    where
      query = "delete from classes where id = ?"

  create conn entity = do
    _ <- run conn query [SqlString (name entity), SqlString (description entity)]
    result <- quickQuery' conn lastId []
    let rows = map unpack result
    return $ last rows
    where
      query = "insert into classes (name, description) values (?, ?)"
      lastId = "select * from classes order by id desc limit 1"
