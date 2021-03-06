module Queries.AQuery
    ( module Queries.AQuery.Trades
    , module Queries.AQuery.Packets
    , debugAll
    , getConn
    ) where

import Database.HDBC.PostgreSQL
import Database.DSH.Compiler
import Queries.AQuery.Trades
import Queries.AQuery.Packets

getConn :: IO Connection
getConn = connectPostgreSQL "user = 'au' password = 'foobar' host = 'localhost' port = '5432' dbname = 'tpch'"

debugAll :: IO ()
debugAll = do
    c <- getConn

    putStrLn "bestProfit"
    debugQ "bestprofit" c bestProfit

    putStrLn "last10"
    debugQ "last10" c $ last10 42

    putStrLn "flowStats"
    debugQ "flowstats" c flowStats
