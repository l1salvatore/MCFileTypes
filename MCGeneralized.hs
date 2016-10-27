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


class (Eq a,Show a) => MarkovChain a where
       elements :: [a]
       trainMarkovChain :: [a] -> RVarT Data.Functor.Identity.Identity (HMM a a)


trainMarkovChainDefault :: (MarkovChain a) => [a] -> RVarT Data.Functor.Identity.Identity (HMM a a)
trainMarkovChainDefault xs = do mc <- Learning.HMM.init elements xs
                                return $ fst (baumWelch' mc xs)

test :: (MarkovChain a) => Int -> RVarT Data.Functor.Identity.Identity (HMM a a) -> IO ()
test n trained = do mc <- runRVar trained StdRandom
                    r  <- runRVar (simulate mc n) StdRandom
                    print $ snd r
 
instance MarkovChain Char where
       elements = Data.List.map chr [0 .. 33]
       trainMarkovChain = trainMarkovChainDefault 
    
instance MarkovChain Int where
       elements = [0 .. 600]
       trainMarkovChain = trainMarkovChainDefault



