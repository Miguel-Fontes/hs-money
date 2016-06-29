module Transactions.Money where

data Money = Money Float deriving (Eq, Read)

instance Num Money where
    (+) (Money x) (Money y) = Money (x + y)
    (*) (Money x) (Money y) = Money (x * y)
    (-) (Money x) (Money y) = Money (x - y)
    abs (Money x) = Money (abs x)
    signum (Money x) = Money 0
    fromInteger x = Money (fromIntegral x)

instance Show Money where
    show (Money x) = show x