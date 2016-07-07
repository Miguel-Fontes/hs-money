module Persist.Initializor where

import Persist.Database
import Persist.Config
import qualified Persist.FileDB as F

-- Primeira implementação desconsidera outros bancos de dados
--  initializeDB :: (Database d) => IO d
initializeDB = do
    cfg <- readCfg
    let connector = getDbConnector (name cfg) dbs
        conn = connectToDb connector cfg
    return conn
    --return ()

connectToDb :: (Database d) => d -> Config -> d
connectToDb db cfg = connectDB db cfg

getDbConnector :: String -> Databases -> F.FileDB
getDbConnector db databases
    | db == "FileDB" = fileDB databases
    | otherwise = error "Database não existe!"

data Databases = Databases {fileDB :: F.FileDB}

dbs = Databases {fileDB = F.Disconnected}