module MCGeneralized where

import Learning.HMM
import Data.Random
import Data.Char
import Data.Array
import Data.List
import Data.Functor.Identity
import Data.Foldable
import System.Random

rmdups :: (Ord a, Show a) => [a] -> [a]
rmdups = map head . group . sort 

train xs = do mc <- Learning.HMM.init states inputs
              return $ fst (baumWelch' mc xs)
          where inputs = rmdups xs
                states = [ 1 .. length inputs ]

retrain mc xs = return $ fst (baumWelch' mc xs)

test n trained = do mc <- runRVar trained StdRandom
                    r  <- runRVar (simulate mc n) StdRandom
                    print $ snd r




-- problemas, No podemos reentrenar la cadena de Markov con un nuevo estado de entre los posibles
-- ejemplo:
-- do mc <- runRVar (train [2,3]) StdRandom
--    mc' <- runRVar (fst (baumWelch' mc [3,5]))
