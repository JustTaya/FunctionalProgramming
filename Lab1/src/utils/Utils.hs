module Utils where

import Database.HDBC


convRow :: [SqlValue] -> Integer
convRow [sqlId] = intId
  where
    intId = fromSql sqlId :: Integer
convRow x = error $ "Unexpected result: " ++ show x
