module Persist.Persist where

--import Text.ParserCombinators.Parsec

-- Vou implementar salvando em disco inicialmente só por diversão. Vou carregar o arquivo inteiro na memória.

class Serializable a where
    serialize :: a -> String
    parse :: String -> a

persist :: (Serializable a) => a -> IO()
persist = writeFile "myDB.db" . serialize

retrieve :: (Serializable a) => a -> IO a
retrieve a = do
    db <- readFile "myDB.db"
    return (parse db)