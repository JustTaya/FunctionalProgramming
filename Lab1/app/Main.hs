module Main where

import Data.Dynamic
import Database.HDBC
import Database.HDBC.PostgreSQL (connectPostgreSQL)
import Prelude hiding (read)

main :: IO ()
main = do
  c <- connectPostgreSQL "host=localhost dbname=Lab1 user=postgres password=root"
  disconnect c
  print (dynTypeRep (toDyn c))
