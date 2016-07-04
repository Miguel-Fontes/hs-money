module Persist.Config where

data Config = Config { database :: String
                     , name :: String
                     , user :: String
                     , password :: String} deriving (Show)

emptyConfig = Config { database = undefined
                     , name = undefined
                     , user = undefined
                     , password = undefined}

readCfg :: IO Config
readCfg = configFromKeyValue emptyConfig . map splitKey . lines <$> readFile "app.config"

splitKey :: String -> (String, String)
splitKey str = splitHelper 0 str
    where splitHelper pos (h:t)
              | h == '=' = (take pos str, drop (pos+1) str)
              | otherwise = splitHelper (pos+1) t

-- Verificar possibilidade de generalizar esta implementação.
-- Da maneira como está o código nunca vai parar de crescer a cada novo valor de configuração
configFromKeyValue :: Config -> [(String, String)] -> Config
configFromKeyValue config [] = config
configFromKeyValue config ((k, v):ks)
    | k == "database" = configFromKeyValue (config {database = v}) ks
    | k == "name" = configFromKeyValue (config {name = v}) ks
    | k == "user" = configFromKeyValue (config {user = v}) ks
    | k == "password" = configFromKeyValue (config {password = v}) ks
    | otherwise = configFromKeyValue config ks

