{-# LANGUAGE ExistentialQuantification #-}

module Persist.Initializor where

import Persist.Database
import Persist.Config
import qualified Persist.FileDB as F

data Connector = forall d. (Database d, Show d) => Connector d

-- A cada novo DB, será necessário adicionar um novo item nessa lista.
-- Posso refatorar?
dbs = [Connector F.Disconnected]

instance Show Connector where
    show (Connector d) = show d

instance Database Connector where
    connectDB (Connector d) cfg = Connector $ connectDB d cfg
    queryDB   (Connector d) a   =             queryDB   d a
    getDB     (Connector d) a   =             getDB     d a
    saveDB    (Connector d) a   =             saveDB    d a
    updateDB  (Connector d) a   =             updateDB  d a
    deleteDB  (Connector d) a   =             deleteDB  d a
    infoDB    (Connector d)     =             infoDB      d

initializeDB :: IO Connector
initializeDB = do
    cfg <- readCfg
    let connector = getDbConnector (database cfg) dbs
        conn = connectToDb connector cfg
    return conn

connectToDb :: Connector -> Config -> Connector
connectToDb (Connector db) cfg = Connector (connectDB db cfg)

getDbConnector :: String -> [Connector] -> Connector
getDbConnector _ [] = error "Database não existe!"
getDbConnector db ((Connector conn):t)
    | db == infoDB conn = Connector conn
    | otherwise = getDbConnector db t