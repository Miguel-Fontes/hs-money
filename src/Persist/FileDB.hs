module Persist.FileDB (connect, FileDB(FileDBConnector, FileDB)) where

import Persist.Serializable
import Persist.Database
import Persist.Config

data FileDB = FileDB String | FileDBConnector

getName (FileDB name) = name

instance Database FileDB where
    queryDB  = query
    getDB    = get
    saveDB   = save
    updateDB = update
    deleteDB = delete
    connectDB = connect

connect :: Config -> FileDB
connect config = FileDB (name config)

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

