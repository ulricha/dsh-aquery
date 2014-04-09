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
    
-- TPC-H Q4

module Main where

import qualified Prelude as P
import Database.DSH
import Database.DSH.Compiler

import Database.HDBC.PostgreSQL

import Records

q4 =
  sortWith fst
  $ map (\(view -> (k, g)) -> pair k (length g)) 
  $ groupWithKey id
    [ o_orderpriorityQ o
    | o <- orders
    , o_orderdateQ o >= 42
    , o_orderdateQ o < 42 + 57
    , not $ null [ toQ ()
                 | l <- lineitems
                 , l_orderkeyQ l == o_orderkeyQ o
                 , l_commitdateQ l < l_receiptdateQ l
                 ]
    ]

getConn :: IO Connection
getConn = connectPostgreSQL "user = 'au' password = 'foobar' host = 'localhost' port = '5432' dbname = 'tpch'"

debugQ :: (Show a, QA a) => Q a -> IO ()
debugQ q = getConn P.>>= \conn -> debugTAOpt "q4" conn q

main :: IO ()
main = debugQ q4
