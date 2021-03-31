module ScheduleRepository where

import ScheduleEntity
import Database.HDBC


--unpack :: [SqlValue] -> ScheduleEntity
--unpack [SqlInteger _uid, SqlByteString _class_id, SqlUTCDateTimeT _start_datetime, SqlUTCDateTimeT _end_datetime, SqlInteger _trainer_id] =
--  ScheduleEntity
--    { uid = _uid,
--      class_id = _class_id,
--      start_datetime = _start_datetime,
--      end_datetime = _end_datetime,
--      trainer_id = _trainer_id
--    }
--unpack x = error $ "Unexpected result: " ++ show x

--instance DefaultRepository ClassEntity where
--  getAll conn = do
--    result <- quickQuery' conn query []
--    return $ map unpack result
--    where
--      query = "select * from classes order by id"
--
--  getById conn _uid = do
--    result <- quickQuery' conn query [SqlInteger _uid]
--    let rows = map unpack result
--    return $
--      if null rows
--        then Nothing
--        else Just (last rows)
--    where
--      query = "select * from classes where id = ?"
--
--  deleteAll conn _ = do
--    changed <- run conn query []
--    return $ changed == 1
--    where
--      query = "delete from classes"
--
--  deleteById conn _uid _ = do
--    changed <- run conn query [SqlInteger _uid]
--    return $ changed == 1
--    where
--      query = "delete from classes where id = ?"
--
--  create conn entity = do
--    let _name = name entity
--    let _description = name entity
--    _ <- run conn query [SqlString _name, SqlString _description]
--    result <- quickQuery' conn lastId []
--    let rows = map unpack result
--    return $ last rows
--    where
--      query = "insert into classes (name, description) values (?, ?)"
--      lastId = "select * from classes order by id desc limit 1"