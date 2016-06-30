module Persist.Database where

import Persist.Serializable

class Database d where
    queryDB  :: (Serializable a) => d -> a -> IO a
    getDB    :: (Serializable a) => d -> a -> IO a
    saveDB   :: (Serializable a) => d -> a -> IO ()
    updateDB :: (Serializable a) => d -> a -> IO ()
    deleteDB :: (Serializable a) => d -> a -> IO ()