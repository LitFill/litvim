module Main where

import Data.Maybe (fromMaybe)
import System.Process (runCommand, waitForProcess)
import Text.Printf (printf)

type Command = (Program, Maybe Args)
type Program = String
type Args = String

cmds :: [Command]
cmds =
  [ ("cd", Just "~")
  , ("pwd", Nothing)
  , ("ls", Just "-lah")
  , ("echo", Just "apakah ini jadi?")
  ]

cmds' :: [Command]
cmds' = [("echo", Just "")]

runCmds :: [Command] -> IO ()
runCmds = mapM_ (runCommand . aux)
 where
  aux :: Command -> String
  aux (c, a) = printf "%s %s" c (fromMaybe "" a)

runit :: String -> IO ()
runit p = do
  _ <- runCommand p
  pure ()

runSeq :: String -> IO ()
runSeq cmd = do
  hasil <- runCommand cmd
  exitCode <- waitForProcess hasil
  print exitCode

main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  runit "pwd"
  runit "echo apakah ini jadi juga? apakah lebih cepat? waw"
  runSeq "ls -lah"
  runit "echo setelah wait"
  pure ()
