module Transaction.Tests where

import Test.Hspec
import Test.QuickCheck
import Transaction.Transaction

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
            let income = addIncome 1000 []
            income `shouldBe` [Income (Money 1000)]
        it "addPayment deverá criar um novo pagamento e adiciona-lo à lista" $ do
            let payment = addPayment 500 []
            payment `shouldBe` [Payment (Money 500)]
        it "saldo deve calcular corretamente em list com payments e incomes" $ do
            let transactions = [Income (Money 3000), Payment (Money 255), Payment (Money 2000), Income (Money 100)]
            saldo transactions `shouldBe` Money 845
    context "Monad Account" $ do
        it "deve integrar as operações usando bind (>>=)" $ do
            let acc = Account [] >>=
                               return . addIncome 2000 >>= return . addPayment 1000 >>=
                               return . addIncome 100 >>= return . addPayment 450 >>=
                               return . saldo
            acc `shouldBe` Account (Money 650)
        it "" $ do
            pendingWith "Implementar"

{-    context "Context" $ do
        it "" $ do
            pendingWith "Implementar" -}