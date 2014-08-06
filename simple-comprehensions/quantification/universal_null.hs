{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE GADTs                 #-}
{-# LANGUAGE MonadComprehensions   #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE RebindableSyntax      #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE UndecidableInstances  #-}
{-# LANGUAGE ViewPatterns          #-}

module Main where

import qualified Prelude as P
import Database.DSH
import Database.DSH.Compiler

import Database.HDBC.PostgreSQL

xs :: Q [Integer]
xs = toQ [1, 2, 3, 4, 5, 6, 7]

ys :: Q [Integer]
ys = toQ [2, 4, 6]

univ1 :: Q [Integer]
univ1 = [ x | x <- xs, null [ toQ () | y <- ys, x == y ] ]

getConn :: IO Connection
getConn = connectPostgreSQL "user = 'au' password = 'foobar' host = 'localhost' dbname = 'test'"


main :: IO ()
main = getConn P.>>= \conn -> debugQ "univ1" conn univ1
