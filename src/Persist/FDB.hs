module Persist.FDB where

import Persist.Serializable
import Persist.Database
import Persist.Config

data FDB = FDBConn String | Disconnected deriving (Show)

getName (FDBConn name) = name

instance Database FDB where
    connectDB = connect
    queryDB   = query
    getDB     = get
    saveDB    = save
    updateDB  = update
    deleteDB  = delete
    infoDB    = info

info :: FDB -> String
info _ = "FDB"

connect :: FDB -> Config -> FDB
connect _ cfg = FDBConn (name cfg)

query :: (Serializable a) => FDB -> a -> IO a
query (db) _ = do
    db <- readFile (getName db)
    return (parse db)

get :: (Serializable a) => FDB -> a -> IO a
get _ = undefined

save :: (Serializable a) => FDB -> a -> IO()
save db = writeFile (getName db) . serialize

update :: (Serializable a) => FDB -> a -> IO()
update _ = undefined

delete :: (Serializable a) => FDB -> a -> IO()
delete _ = undefined