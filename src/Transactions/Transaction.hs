module Transactions.Transaction where

import Persist.Serializable
import Transactions.Money

data Transaction = Income Money
                 | Payment Money
                 deriving (Show, Read)

instance Eq Transaction where
    Income  x  == Income y  = x == y
    Payment x  == Payment y = x == y
    Payment _  == Income _  = False
    Income  _  == Payment _ = False

instance Serializable Transaction where
    serialize = serializeTransaction
    parse     = undefined

serializeTransaction :: Transaction -> String
serializeTransaction (Payment x) = "Payment " ++ show x
serializeTransaction (Income x)  = "Income "  ++ show x



