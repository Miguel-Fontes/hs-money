module Main where

import Transactions.Account
import Transactions.Transaction
import Persist.Serializable
import Persist.Persistable
import Persist.Initializor


main = do
    conn <- initializeDB
    acc <- (addIncome 1000 . addPayment 500 . addPayment 200) <$> query conn EmptyAccount
    print acc
    save conn ( acc )
    return ()