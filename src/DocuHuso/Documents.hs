module DocuHuso.Documents where

import Database.SQLite.Simple

data NewDocument = NewDocument {
    name_ :: String,
    text_ :: String }

data Document = Document {
    _id :: Int,
    name :: String,
    text :: String }

instance ToRow NewDocument where
    toRow doc = toRow (name_ doc, text_ doc)

instance FromRow Document where
    fromRow = Document <$> field <*> field <*> field
