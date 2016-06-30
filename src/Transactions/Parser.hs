module Transactions.Parser (parseAccount, parseTransaction) where
import Text.ParserCombinators.Parsec

account = endBy transactions eol

transactions = do
    string "Account "
    content <- sepBy parseTransaction (char ',')
    return content

parseTransaction = do
    tipo  <- string "Income" <|> string "Payment"
    valor <- string " " >> (many (noneOf " ,\n"))
    return (tipo, valor)

eol =   try (string "\n\r")
    <|> try (string "\r\n")
    <|> string "\n"
    <|> string "\r"
    <?> "end of line"

parseAccount:: String -> [[(String, String)]]
parseAccount input = fromEither $ parse account "(unknown)" input

fromEither :: Either a b -> b
fromEither (Right b) = b
fromEither (Left a) = error ""