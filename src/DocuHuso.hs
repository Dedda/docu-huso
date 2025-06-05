{-# LANGUAGE OverloadedStrings #-}
module DocuHuso(
    Context(..),
    StorageConfig(..),
    NewDocument(..),
    Document(..),
    Store(..),
    InMemoryStore(),
    SqliteStore(..),
    connect,
    emptyInMemoryStore
) where

import DocuHuso.Documents
import DocuHuso.Storage

data Context s = Context {
    _store :: s}
