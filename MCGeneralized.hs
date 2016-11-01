module MCGeneralized where

import Learning.HMM
import Data.Random
import Data.Char
import Data.Array
import Data.List
import Data.ByteString
import Data.Functor.Identity
import Data.Foldable
import System.Random


class MarkovChain a where
       elements :: [a]
       trainMarkovChain :: [a] ->  RVar (HMM a a)
{-
instance (Eq a) => (MarkovChain a) where
       trainMarkovChain = trainMarkovChainDefault
-}

trainMarkovChainDefault :: (Eq a,MarkovChain a) => [a] -> RVar (HMM a a)
trainMarkovChainDefault xs = do mc <- Learning.HMM.init elements xs
                                return $ fst (baumWelch' mc xs)

test :: (Show a,MarkovChain a) => Int -> RVar (HMM a a) -> IO ()
test n trained = do mc <- runRVar trained StdRandom
                    r  <- runRVar (simulate mc 50) StdRandom
                    print $ snd r
 
instance MarkovChain Char where
       elements = Data.List.map chr [0 .. 33]
       trainMarkovChain = trainMarkovChainDefault


instance MarkovChain Int where
       elements = [0 .. 600]
       trainMarkovChain = trainMarkovChainDefault
