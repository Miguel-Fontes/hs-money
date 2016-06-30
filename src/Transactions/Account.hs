module Transactions.Account where

import Persist.Serializable
import Persist.Persistable
import Transactions.Money
import Transactions.Transaction
import Transactions.Parser

import qualified Data.List as L

newtype Account = Account [Transaction] deriving (Show, Eq)

-- Instance de persistable. Possibilita persistir os dados da conta
instance Persistable Account

saldo :: Account -> Money
saldo (Account xs) = foldl step (Money 0) xs
    where step acc x = case x of
                           Payment p -> acc - p
                           Income i -> i + acc

emptyAccount :: Account
emptyAccount = Account []

-- Serialização.
-- A função 'parseAccount' está no módulo Transaction.Parser para isolar o código PARSEC
instance Serializable Account where
    serialize = serializeAccount
    parse = (readAccount . concat . parseAccount) -- Concat, já que estamos trabalhando só com uma conta. Remover futuramente.

serializeAccount :: Account -> String
serializeAccount (Account ts) = (("Account " ++) . (++"\n") . concat . L.intersperse ",") $ foldr step [] ts
    where step x acc = serialize x : acc

readTransaction :: (String, String) -> Transaction
readTransaction (t, v)
    | t == "Income" = Income $ Money (read v :: Float)
    | t == "Payment" = Payment $ Money (read v :: Float)

readAccount :: [(String, String)] -> Account
readAccount = Account . map readTransaction

-- Helper Functions
addIncome :: Money -> Account -> Account
addIncome m (Account xs) = Account (Income m : xs)

addPayment :: Money -> Account -> Account
addPayment p (Account xs) = Account (Payment p : xs)