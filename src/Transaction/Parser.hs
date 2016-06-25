module Transaction.Parser (parseMovements) where
import Text.ParserCombinators.Parsec

-- Get the Identity monad from here:

account = endBy movements eol

movements = do
    string "Account "
    char '['
    content <- sepBy movement (char ',')
    char ']'
    return content

movement = do
    tipo <- string "Income" <|> string "Payment"
    valor <- string " R$ " >> (many (noneOf " ,]"))
    return (tipo, valor)

eol =   try (string "\n\r")
    <|> try (string "\r\n")
    <|> string "\n"
    <|> string "\r"
    <?> "end of line"

parseMovements :: String -> [[(String, String)]]
parseMovements input = fromEither $ parse account "(unknown)" input

fromEither :: Either a b -> b
fromEither (Right b) = b
fromEither (Left a) = error ""