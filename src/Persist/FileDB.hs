module Persist.FileDB where

import Persist.Serializable
import Persist.Database
import Persist.Config

data FileDB = FileDBConn String | Disconnected deriving (Show)

getName (FileDBConn name) = name

instance Database FileDB where
    connectDB = connect
    queryDB   = query
    getDB     = get
    saveDB    = save
    updateDB  = update
    deleteDB  = delete
    infoDB    = info

info :: FileDB -> String
info _ = "FileDB"

connect :: FileDB -> Config -> FileDB
connect _ cfg = FileDBConn (name cfg)

query :: (Serializable a) => FileDB -> a -> IO a
query (db) _ = do
    db <- readFile (getName db)
    return (parse db)

get :: (Serializable a) => FileDB -> a -> IO a
get _ = undefined

save :: (Serializable a) => FileDB -> a -> IO()
save db = writeFile (getName db) . serialize

update :: (Serializable a) => FileDB -> a -> IO()
update _ = undefined

delete :: (Serializable a) => FileDB -> a -> IO()
delete _ = undefined