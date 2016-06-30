module Persist.FileDB (connect) where

import Persist.Serializable
import Persist.Database

data FileDB = FileDB String

getName (FileDB name) = name

instance Database FileDB where
    queryDB  = query
    getDB    = get
    saveDB   = save
    updateDB = update
    deleteDB = delete

connect :: String -> FileDB
connect nome = FileDB nome

query :: (Serializable a) => FileDB -> a -> IO a
query db _ = do
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

