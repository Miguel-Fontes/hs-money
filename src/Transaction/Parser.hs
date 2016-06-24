module Transaction.Parser (parseMovement) where
import Text.ParserCombinators.Parsec

-- Get the Identity monad from here:

movement = endBy line eol
line = sepBy (accString >> parseAcc) (char ',')
parseAcc = many (noneOf " \n")

accString = "Account"

eol =   try (string "\n\r")
    <|> try (string "\r\n")
    <|> string "\n"
    <|> string "\r"
    <?> "end of line"

parseMovement :: String -> Either ParseError [[String]]
parseMovement input = parse movement "(unknown)" input

Account [Payment R$ 450.0,Income R$ 100.0,Payment R$ 1000.0,Income R$ 2000.0]