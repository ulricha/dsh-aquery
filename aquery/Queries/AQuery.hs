{-# LANGUAGE OverloadedStrings #-}
module Queries.AQuery
    ( module Queries.AQuery.Trades
    , module Queries.AQuery.Packets
    , debugAll
    ) where

import Control.Applicative

import Data.Text
import Database.HDBC.ODBC
import Database.DSH.Compiler
import Database.DSH.Backend.Sql

import Queries.AQuery.Trades
import Queries.AQuery.Packets

debugAll :: SqlBackend -> IO ()
debugAll conn = do
    -- putStrLn "bestProfit"
    -- debugQ "bestprofit" c $ bestProfit 23 42

    -- putStrLn "last10"
    -- debugQ "last10" c $ last10 42

    -- putStrLn "flowStats drop"
    -- debugQ "flowstats_drop" c $ flowStatsZip

    -- putStrLn "flowStats self"
    -- debugQ "flowstats_self" c $ flowStatsSelfJoin

    putStrLn "flowStats win"
    debugQ "flowstats_win" conn $ flowStatsWin
