module Main where

import Transactions.Account
import Transactions.Transaction
import Persist.Serializable
import Persist.Persistable
import Persist.Initializor


main = do
    conn <- initializeDB
    save conn ( Account [Income 1000] )
    return ()