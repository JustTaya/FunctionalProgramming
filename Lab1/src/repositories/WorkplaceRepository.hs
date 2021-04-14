module WorkplaceRepository where

import qualified Data.ByteString.Char8 as BS
import Database.HDBC
import DefaultRepository
import WorkplaceEntity

unpack :: [SqlValue] -> WorkplaceEntity
unpack [SqlInteger _uid, SqlInteger _class_id, SqlInteger _trainer_id, SqlByteString _role] =
  WorkplaceEntity
    { uid = Just _uid,
      class_id = _class_id,
      trainer_id = _trainer_id,
      role = BS.unpack _role
    }
unpack x = error $ "Unexpected result: " ++ show x

instance DefaultRepository WorkplaceEntity where
  getAll conn = do
    result <- quickQuery' conn query []
    return $ map unpack result
    where
      query = "select * from workplaces order by id"

  getById conn _uid = do
    result <- quickQuery' conn query [SqlInteger _uid]
    let rows = map unpack result
    return $
      if null rows
        then Nothing
        else Just (last rows)
    where
      query = "select * from workplaces where id = ?"

  deleteAll conn _ = do
    changed <- run conn query []
    return $ changed == 1
    where
      query = "delete from workplaces"

  deleteById conn _uid _ = do
    changed <- run conn query [SqlInteger _uid]
    return $ changed == 1
    where
      query = "delete from workplaces where id = ?"

  create conn entity = do
    _ <- run conn query [SqlInteger (class_id entity), SqlInteger (trainer_id entity), SqlString (role entity)]
    result <- quickQuery' conn lastId []
    let rows = map unpack result
    return $ last rows
    where
      query = "insert into workplaces (class_id, trainer_id, role) values (?, ?, ?)"
      lastId = "select * from workplaces order by id desc limit 1"
