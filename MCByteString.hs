module MCByteString where

import Learning.HMM
import Data.Random
import Data.Char
import Data.Array
import Data.List

import System.Random


elemsP = [0 .. 33]

genP = intercalate "_" ["gAMA","IDAT", "IEND", "gAMA", "IDAT", "IEND", "PLTE"]

mc = Learning.HMM.init elemsP genP

trained = do
          mc <- Learning.HMM.init elemsP genP
          return $ fst (baumWelch' mc genP)

test = do
  mc <- runRVar trained StdRandom
  r  <- runRVar (simulate mc 50) StdRandom
  print $ snd r
