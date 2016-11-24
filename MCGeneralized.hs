{-# LANGUAGE FlexibleInstances #-}

module MCGeneralized where

import Learning.HMM
import Data.Random
import Data.Char
import Data.Array
import qualified Data.List as Lista
import Data.Functor.Identity
import Data.Foldable
import Data.ByteString as BString
import Data.Binary
import System.Random
import qualified Data.Random.Distribution.Categorical as Cat

putList :: Binary a => [a] -> Put
putList [] = return ()
putList (x:xs) = do put x
                    putList xs

rmdups :: (Ord a, Show a) => [a] -> [a]
rmdups = Lista.map Lista.head . Lista.group . Lista.sort 

train xs = do mc <- Learning.HMM.init states inputs
              return $ fst (baumWelch' mc xs)
          where inputs = rmdups xs
                states = [ 1 .. Lista.length inputs ]

retrain mc xs = return $ fst (baumWelch' mc xs)

test n trained = do mc <- runRVar trained StdRandom
                    r  <- runRVar (simulate mc n) StdRandom
                    print $ snd r

instance Binary a => Binary (HMM Int a) where
         put hmm = do putList $ states hmm
                      putList $ outputs hmm
                      putList $ Cat.toList $ initialStateDist hmm
                      putList $ Lista.map (\i -> Cat.toList $ transitionDist hmm $ i) (states hmm)
                      putList $ Lista.map (\i -> Cat.toList $ emissionDist hmm $ i) (states hmm)               
         get = undefined {- TODO -}

mc2ByteStringFile :: Binary a => HMM Int a -> IO ()
mc2ByteStringFile hmm = encodeFile "MarkovChainFile" hmm

