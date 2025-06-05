module Storage(tests) where

import DocuHuso

import Test.HUnit

tests :: Test
tests = TestList [testNewInMemoryIsEmpty, testAddDocumentToEmptyInMemoryStore]

testNewInMemoryIsEmpty :: Test
testNewInMemoryIsEmpty = TestCase (do
        noDocs <- loadDocs emptyInMemoryStore
        assertEqual "no doc added to empty in memory store" 0 (length noDocs))

testAddDocumentToEmptyInMemoryStore :: Test
testAddDocumentToEmptyInMemoryStore = TestCase (do
        store <- insertDoc emptyInMemoryStore sampleDocument
        docs <- loadDocs store
        assertEqual "doc added to empty in memory store" 1 (length docs))

sampleDocument :: NewDocument
sampleDocument = NewDocument { name_ = "Sample Document", text_ = "Sample text in document"}