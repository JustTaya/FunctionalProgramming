module WorkplaceRepository where

import WorkplaceEntity
import DefaultRepository
import qualified Data.ByteString.Char8 as BS
import Database.HDBC

unpack :: [SqlValue] -> WorkplaceEntity
unpack [SqlInteger _uid, SqlByteString _name, SqlByteString _description] =
  WorkplaceEntity
    { uid = _uid,
      name = BS.unpack _name,
      description = BS.unpack _description
    }
unpack x = error $ "Unexpected result: " ++ show x