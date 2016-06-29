module Transactions.Tests where

import Test.Hspec
import Test.QuickCheck
import Transactions.Transaction
import Transactions.Account
import Transactions.Money

severalPayments = [Payment (Money x) | x <- [100 .. 150]]
myIncome = [Income (Money x) | x <- [3000]]

test :: IO ()
test = hspec $ do
  describe "Transactions" $ do
    context "Tipo e instâncias" $ do
        it "na instance eq == deverá retornar False para Income x Payment" $ do
            (Income (Money 100) == Payment (Money 100)) `shouldBe` False
            (Payment (Money 100) == Income (Money 100)) `shouldBe` False
    context "Movimentos e saldo" $ do
        it "addIncome deverá adicionar criar um novo income e adiciona-lo à lista" $ do
            let income = addIncome 1000 (Account [])
            income `shouldBe` (Account [Income (Money 1000)])
        it "addPayment deverá criar um novo pagamento e adiciona-lo à lista" $ do
            let payment = addPayment 500 (Account [])
            payment `shouldBe` (Account [Payment (Money 500)])
    context "sAccount" $ do
        it "saldo deve calcular corretamente o saldo da conta com payments e incomes" $ do
            let transactions = Account [Income (Money 3000), Payment (Money 255), Payment (Money 2000), Income (Money 100)]
            saldo transactions `shouldBe` Money 845
        it "" $ do
            pendingWith "Implementar"

{-    context "Context" $ do
        it "" $ do
            pendingWith "Implementar" -}