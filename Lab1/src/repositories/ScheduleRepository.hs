module ScheduleRepository where

import qualified Data.ByteString.Char8 as BS
import Database.HDBC
import ScheduleEntity
import DefaultRepository

unpack :: [SqlValue] -> ScheduleEntity
unpack [SqlInteger _uid, SqlInteger _class_id, SqlByteString _start_datetime, SqlByteString _end_datetime, SqlInteger _trainer_id] =
  ScheduleEntity
    { uid = Just _uid,
      class_id = _class_id,
      start_datetime = BS.unpack _start_datetime,
      end_datetime = BS.unpack _end_datetime,
      trainer_id = _trainer_id
    }
unpack x = error $ "Unexpected result: " ++ show x

instance DefaultRepository ScheduleEntity where
  getAll conn = do
    result <- quickQuery' conn query []
    return $ map unpack result
    where
      query = "select * from schedule order by id"

  getById conn _uid = do
    result <- quickQuery' conn query [SqlInteger _uid]
    let rows = map unpack result
    return $
      if null rows
        then Nothing
        else Just (last rows)
    where
      query = "select * from schedule where id = ?"

  deleteAll conn _ = do
    changed <- run conn query []
    return $ changed == 1
    where
      query = "delete from workplaces"

  deleteById conn _uid _ = do
    changed <- run conn query [SqlInteger _uid]
    return $ changed == 1
    where
      query = "delete from schedule where id = ?"

  create conn entity = do
    _ <- run conn query [SqlInteger (class_id entity), SqlString (start_datetime entity), SqlString (end_datetime entity), SqlInteger (trainer_id entity)]
    result <- quickQuery' conn lastId []
    let rows = map unpack result
    return $ last rows
    where
      query = "insert into workplaces (class_id, start_datetime, end_datetime, trainer_id) values (?, ?, ?, ?)"
      lastId = "select * from schedule order by id desc limit 1"
