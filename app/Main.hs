module Main where

import Transactions.Account
import Transactions.Transaction
import Persist.Serializable
import Persist.Persistable
import Persist.FileDB

-- Extrair para Modulo de inicialização de DB ----
import qualified Persist.FileDB as F
conn = F.connect "mydb.db"
--------------------------------------------------

main = do
    return ()