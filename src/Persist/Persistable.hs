module Persist.Persistable where

import Persist.Serializable

class (Serializable a) => Persistable a where
    query :: a -> IO a
    query _ = do
        db <- readFile "myDB.db"
        return (parse db)

    save :: a -> IO()
    save = writeFile "myDB.db" . serialize

    update :: a -> IO()
    update = undefined

    delete :: a -> IO()
    delete = undefined