{-# LANGUAGE OverloadedStrings #-}
module DocuHuso.Storage(
    Store(..),
    InMemoryStore(),
    SqliteStore(..),
    StorageConfig(..),
    connect,
    emptyInMemoryStore
    ) where

import DocuHuso.Documents

import Database.SQLite.Simple

class Store s where    
    loadDocs :: s -> IO [Document]
    insertDoc :: s -> NewDocument -> IO s

data InMemoryStore = InMemoryStore {
    _documents :: [Document]}

instance Store InMemoryStore where
    loadDocs m = do
                    return $ _documents m
    
    insertDoc m nDoc = do
                    return $ m { _documents = docs }
                    where
                        lastId = length $ _documents m
                        doc = Document { _id = lastId + 1, name = name_ nDoc, text = text_ nDoc }
                        docs = (_documents m) ++ [doc]                    

emptyInMemoryStore :: InMemoryStore
emptyInMemoryStore = InMemoryStore { _documents = [] }

data StorageConfig = StorageConfig {
    database :: String }

data SqliteStore = SqliteStore {
    _connection :: Connection}

instance Store SqliteStore where
    loadDocs s = do
                execute_ conn "CREATE TABLE IF NOT EXISTS documents(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, doc_text TEXT)"
                query_ conn "SELECT * FROM documents" :: IO [Document]
                where conn = _connection s

    insertDoc s doc = do
                execute conn "INSERT INTO documents (name, doc_text) VALUES (?, ?)" doc
                return s
                where conn = _connection s

connect :: StorageConfig -> IO SqliteStore
connect conf = do
                conn <- open dbFile
                return SqliteStore { _connection = conn }
                where dbFile = database conf
