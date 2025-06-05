> module Main where

> import DocuHuso
> import SampleData

> main :: IO ()
> main = do
>   context <- defaultContext
>   newCtx <- SampleData.insertSampleDocument context
>   docs <- DocuHuso.loadDocs $ _store newCtx
>   putStrLn $ "Documents loaded: " <> show (length docs)

Default Config using `docs.db` as database file

> defaultConfig :: StorageConfig
> defaultConfig = StorageConfig { database = "docs.db" }

> defaultContext :: IO (Context SqliteStore)
> defaultContext = do
>                   connection <- connect defaultConfig
>                   return Context { _store = connection }