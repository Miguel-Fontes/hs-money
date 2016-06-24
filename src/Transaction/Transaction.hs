module Transaction.Transaction where

import Persist.Persist

data Money = Money Float deriving (Eq, Read)

instance Num Money where
    (+) (Money x) (Money y) = Money (x + y)
    (*) (Money x) (Money y) = Money (x * y)
    (-) (Money x) (Money y) = Money (x - y)
    abs (Money x) = Money (abs x)
    signum (Money x) = Money 0
    fromInteger x = Money (fromIntegral x)

instance Show Money where
    show (Money x) = "R$ " ++ show x

data Transaction = Income Money
                 | Payment Money
                 deriving (Show, Read)

instance Eq Transaction where
    Income  x  == Income y  = x == y
    Payment x  == Payment y = x == y
    Payment _  == Income _  = False
    Income  _  == Payment _ = False

saldo :: [Transaction] -> Money
saldo = foldl step (Money 0)
    where step acc x = case x of
                           Payment p -> acc - p
                           Income i -> i + acc

addIncome :: Money -> [Transaction] -> [Transaction]
addIncome m xs = (Income m : xs)

addPayment :: Money -> [Transaction] -> [Transaction]
addPayment p xs = (Payment p : xs)

newtype Account a = Account a deriving (Show, Eq, Read)

instance Monad Account where
    return = Account
    fail msg = error msg
    Account x >>= f = f x

instance Functor Account where
    fmap f (Account x) = Account (f x)

instance Applicative Account where
    pure = Account
    Account x <*> Account y = Account (x y)

instance (Show a, Read a) => Serializable (Account a) where
    serialize = show
    parse = read