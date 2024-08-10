module Compiler where

import System.IO
import System.Process
import Control.Exception
import Assembly

brainfuckWhitelist :: String
brainfuckWhitelist = "><+-.,[]"

-- shell command functions
--
-- NOTE: for the functions that return IO (Maybe String)
-- a Just String means failure and the error is held in the string
-- while Nothing means success.
writeAssemblyFile :: String -> IO ()
writeAssemblyFile assemblyCode = do
  handle <- openFile "output.asm" WriteMode
  hPutStrLn handle assemblyCode
  hClose handle

tryRunCommand :: String -> IO (Maybe String)
tryRunCommand cmd = do
  result <- try (callCommand cmd) :: IO (Either SomeException ())
  return $ case result of
    Left  err -> Just (show err)
    Right _   -> Nothing

assembleObject :: IO (Maybe String)
assembleObject = do tryRunCommand assemblyNasmCommand

linkExecutable :: IO (Maybe String)
linkExecutable = do tryRunCommand assemblyLdCommand

cleanBuildFiles :: IO (Maybe String)
cleanBuildFiles = do tryRunCommand assemblyCleanCommand

-- assembler functions
-- assembleBrainfuck is the primary function which takes in brainfuck code and returns assembly
assembleBrainfuck :: String -> String
assembleBrainfuck rawCode =
  let brainfuckCode = filterString rawCode brainfuckWhitelist
      (assemblyCode, _) = assembleCode brainfuckCode (assemblyHeader, 0)
  in assemblyCode ++ assemblyFooter

assembleCode :: String -> (String, Int) -> (String, Int)
assembleCode [] result = result
assembleCode (x:xs) (assemblyCode, loopCount) =
  let newResult = appendAssembly x (assemblyCode, loopCount)
  in assembleCode xs newResult

appendAssembly :: Char -> (String, Int) -> (String, Int)
appendAssembly brainfuckChar (assemblyCode, loopCount) =
  case brainfuckChar of
    '>' -> (assemblyCode ++ assemblyIncrementPointer, loopCount)
    '<' -> (assemblyCode ++ assemblyDecrementPointer, loopCount)
    '+' -> (assemblyCode ++ assemblyIncrementValue, loopCount)
    '-' -> (assemblyCode ++ assemblyDecrementValue, loopCount)
    '.' -> (assemblyCode ++ assemblyOutputValue, loopCount)
    ',' -> (assemblyCode ++ assemblyInputValue, loopCount)
    '[' -> (assemblyCode ++ (getLoopLabel loopCount), loopCount + 1)
    ']' -> (assemblyCode ++ (getLoopCheck $ loopCount - 1), loopCount - 1)
    _   -> (assemblyCode, loopCount)

filterString :: String -> String -> String
filterString input whitelist = filter (`elem` whitelist) input
