{-# LANGUAGE OverloadedStrings #-}

import Data.Monoid ((<>))
import Data.Char (isSpace)
import qualified Data.Text as T
import qualified Data.Text.IO as TIO

import Discord

-- |Sends a message and then gets a channel, printing the results
restExample :: IO ()
restExample = do
  tok <- T.filter (not . isSpace) <$> TIO.readFile "./examples/auth-token.secret"
  dis <- loginRest (Bot tok)

  msg <- rest dis (CreateMessage 453207241294610444 "Creating a message" Nothing)
  putStrLn ("Message object: " <> show msg)

  putStrLn ""

  chan <- rest dis (GetChannel 453207241294610444)
  putStrLn ("Channel object: " <> show chan)

  case msg of
    Resp m -> do r <- rest dis (CreateReaction (453207241294610444, messageId m) "🐮" Nothing)
                 putStrLn ("Reaction resp: " <> show r)
    _ -> putStrLn "Creating the message failed, couldn't react"



