{-# LANGUAGE OverloadedStrings #-}

module Parser where 

import Options.Applicative

data CompilerOptions = CompilerOptions
  { optClean  :: Bool
  , optInput  :: String
  , optAsm    :: Bool
  }

parseOptions :: Parser CompilerOptions
parseOptions = CompilerOptions
  <$> switch 
    (  long "clean"
    <> short 'c'
    <> help "Clean build artifacts" )
  <*> strOption
    (  long "input"
    <> short 'i'
    <> metavar "FILE"
    <> help "Input file to compile" )
  <*> switch
    (  long "asm"
    <> short 'a'
    <> help  "Only generate assembly file" )
