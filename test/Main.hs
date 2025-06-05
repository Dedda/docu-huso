module Main (main) where

import qualified Documents
import qualified Storage

import Test.HUnit

main :: IO Counts
main = do runTestTT tests

tests :: Test
tests = TestList [hunitTest, Documents.tests, Storage.tests]

hunitTest :: Test
hunitTest = TestCase (assertBool "True is true" True)