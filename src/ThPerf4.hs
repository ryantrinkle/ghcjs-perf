{-# LANGUAGE GADTs           #-}
{-# LANGUAGE QuasiQuotes     #-}
{-# LANGUAGE TemplateHaskell #-}

module ThPerf4 where

------------------------------------------------------------------------------
import           Reflex
import           Reflex.Dynamic.TH
------------------------------------------------------------------------------


data Foo = Foo
    { fooName :: String
    , fooStr  :: String
    , fooFlag :: Bool
    , fooNum  :: Int
    }

mkFoo :: (String, Bool) -> Int -> Foo
mkFoo p i = Foo "thename" (fst p) (snd p) (i*10)

testFunc
    :: (Monad m, Reflex t, MonadHold t m)
    => Dynamic t String
    -> Dynamic t Bool
    -> Dynamic t Int
    -> m (Dynamic t Foo)
testFunc s b i = do
    $(qDyn [| mkFoo ($(unqDyn [| s |]), $(unqDyn [| b |])) $(unqDyn [| i |]) |])

