module Persist.Persistable where

import Persist.Serializable
import Persist.Database

class (Serializable a) => Persistable a where
    query  :: (Database d) => d -> (a -> IO a)
    query  = queryDB

    save   :: (Database d) => d -> (a -> IO())
    save   = saveDB

    update :: (Database d) => d -> (a -> IO())
    update = updateDB

    delete :: (Database d) => d -> (a -> IO())
    delete = deleteDB

    get    :: (Database d) => d -> (a -> IO a)
    get    = getDB