module Persist.Initializor where

import Persist.Database
import Persist.Config
import qualified Persist.FileDB as F

-- Primeira implementação desconsidera outros bancos de dados
--initializeDB :: (Database d) => IO d
initializeDB = do
    cfg <- readCfg

    let conn = connectToDb cfg

    return conn

--connectToDb :: (Database d) => Config -> d
connectToDb cfg
    | database cfg == "FileDB" = (connectDB cfg :: F.FileDB)
    | otherwise = error "Database inexistente"

