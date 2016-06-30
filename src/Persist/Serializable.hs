module Persist.Serializable where

class Serializable s where
    serialize :: s -> String
    parse     :: String -> s