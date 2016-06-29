{-persist :: (Serializable s) => s a -> IO()
persist = writeFile "myDB.db" . serialize-}

{-retrieve :: (Serializable s) => s a -> IO (s a)
retrieve a = do
    db <- readFile "myDB.db"
    return (parse db)-}