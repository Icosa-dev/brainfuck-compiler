module Main where

import Options.Applicative

import Compiler
import Parser

main :: IO ()
main = do 
  opts <- execParser optParser

  let inputFile = optInput opts
  contents <- readFile inputFile 

  writeAssemblyFile $ assembleBrainfuck contents

  let runAssemble = not (optAsm opts)
      runClean    = not (optAsm opts) && optClean opts 

  assembleResult <- if runAssemble
                      then assembleObject 
                      else return Nothing
  
  linkResult    <- if runAssemble
                      then linkExecutable
                      else return Nothing

  cleanResult   <- if runClean 
                      then cleanBuildFiles
                      else return Nothing

  case assembleResult of
    Nothing  -> return ()
    Just err -> putStrLn err 

  case linkResult of
    Nothing  -> return ()
    Just err -> putStrLn err 

  case cleanResult of
    Nothing  -> return ()
    Just err -> putStrLn err

  where 
    optParser = info (parseOptions <**> helper)
      (  fullDesc
      <> progDesc "A basic brainfuck compiler written in haskell"
      <> header "Brainfuck Compiler (bfc)")
