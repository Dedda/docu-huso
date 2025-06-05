module SampleData (insertSampleDocument) where

import DocuHuso

insertSampleDocument :: Store s => Context s -> IO (Context s)
insertSampleDocument ctx = do
                            docs <- loadDocs store
                            _addFirstDocument ctx docs
                            where store = _store ctx

_addFirstDocument :: Store s => Context s -> [Document] -> IO (Context s)
_addFirstDocument ctx [] = do
                            newStore <- insertDoc store sampleDocument
                            return ctx { _store = newStore }
                            where store = _store ctx
_addFirstDocument ctx _ = return ctx

sampleDocument :: NewDocument
sampleDocument = NewDocument { name_ = "Sample Document", text_ = "Sample text in document"}