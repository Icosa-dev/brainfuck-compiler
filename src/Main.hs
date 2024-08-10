module Main where

import System.Environment
import Compiler

main :: IO ()
main = do
  args <- getArgs
  if (length args) < 1
    then do
        putStrLn "Error: no input file given"
        return ()
    else do
        let inputFile = args !! 0
        fileContents <- readFile inputFile

        writeAssemblyFile $ assembleBrainfuck fileContents

        assemblyResult <- assembleObject
        case assemblyResult of
          Nothing  -> return ()
          Just err -> putStrLn err

        linkResult <- linkExecutable
        case linkResult of
          Nothing  -> return ()
          Just err -> putStrLn err

        cleanResult <- cleanBuildFiles
        case cleanResult of
          Nothing  -> return ()
          Just err -> putStrLn err
