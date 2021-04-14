module Main where

import Data.List
import Database.HDBC
import Database.HDBC.PostgreSQL

import DefaultRepository

import ClassEntity
import ScheduleEntity
import UserEntity
import WorkplaceEntity

import ClassesRepository
import ScheduleRepository
import UsersRepository
import WorkplaceRepository

tables :: [[Char]]
tables = ["assignments", "classes", "schedule", "users", "workplaces"]

main :: IO ()
main = do
  c <- connectPostgreSQL "host=localhost dbname=FP_Lab1 user=postgres password=root"
  putStrLn "\nChoose entity:"
  putStrLn (intercalate "\n" tables)
  putStrLn "else exit\n"
  _name <- getLine
  putStrLn ("you said: " ++ _name)
  if _name `elem` tables
    then do
      putStrLn "\nChoose command:\nn - new\nu - update\nd - delete\ndi - delete by id\ng - get all\ng - get by id\nexit"
      command <- getLine
      putStrLn ("you said: " ++ command)
      if command == "exit"
        then do
          putStrLn "Unknown command"
          disconnect c
          main
        else do
          case command of
            "N" -> do
              putStrLn ("New " ++ _name)
              case _name of
                "classes" -> do
                  class_entity <- createClass
                  result <- create c class_entity :: IO ClassEntity
                  printClass result
                "schedule" -> do
                  schedule_entity <- createSchedule
                  result <- create c schedule_entity :: IO ScheduleEntity
                  printSchedule result
                "users" -> do
                  user_entity <- createUser
                  result <- create c user_entity :: IO UserEntity
                  printUser result
                "workplaces" -> do
                  workplaces_entity <- createWorkplace
                  result <- create c workplaces_entity :: IO WorkplaceEntity
                  printWorkplace result
  --            "d" -> do
  --              putStrLn ("Delete " ++ _name)
  --              putStrLn ("Get by id" ++ _name)
  --              putStrLn "Enter id:"
  --              _uid <- getLine
  --              let _id = (read _uid :: Integer)
  --              result <- removeAll c :: IO Bool
  --              putStrLn "Deleted"
  --            "di" -> do
  --              putStrLn ("Delete by id " ++ _name)
              commit c
              disconnect c
            "G" -> do
              putStrLn ("Get all " ++ _name)
              case _name of
                "classes" -> do
                  result <- getAll c :: IO [ClassEntity]
                  mapM_ printClass result
                "schedule" -> do
                  result <- getAll c :: IO [ScheduleEntity]
                  mapM_ printSchedule result
                "users" -> do
                  result <- getAll c :: IO [UserEntity]
                  mapM_ printUser result
                "workplaces" -> do
                  result <- getAll c :: IO [WorkplaceEntity]
                  mapM_ printWorkplace result
            "Gi" -> do
              putStrLn ("Get by id" ++ _name)
              putStrLn "Enter id:"
              _uid <- getLine
              let _id = (read _uid :: Integer)
              case _name of
                "classes" -> do
                  result <- getById c _id :: IO (Maybe ClassEntity)
                  mapM_ printClass result
                "schedule" -> do
                  result <- getById c _id :: IO (Maybe ScheduleEntity)
                  mapM_ printSchedule result
                "users" -> do
                  result <- getById c _id :: IO (Maybe UserEntity)
                  mapM_ printUser result
                "workplaces" -> do
                  result <- getById c _id :: IO (Maybe WorkplaceEntity)
                  mapM_ printWorkplace result
            _ -> do
                putStrLn "Unknown command"
                disconnect c
                main
    else if _name /= "exit"
      then putStrLn "Unknown command"
      else putStrLn "Exit"
