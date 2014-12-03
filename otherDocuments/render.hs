#! /bin/runghc

module Main where

import Control.Monad
import System.Directory
import System.Environment
import System.FilePath
import System.Process

data Fmt = HTML | WordDoc | PDF
         deriving (Read)

extension HTML    = ".html"
extension WordDoc = ".doc"
extension PDF     = ".pdf"

rawFileDir   = "reports"
buildFileDir = "build"

cmd f fmt  =
  "pandoc -o " ++ (buildFileDir </> f') ++
  " --latex-engine=xelatex -H preamble.tex " ++
  (rawFileDir </> f)
  where f' = stripExt f ++ extension fmt

fnExtension :: FilePath -> String
fnExtension = reverse . takeWhile (/= '.') . reverse
------------------------------------------------------------------------------
main = do
  args <- getArgs
  rawFiles <- filter ((=="md").fnExtension) `fmap`
              getDirectoryContents rawFileDir
  let fmt = case args of
        []  -> PDF
        [f] -> read f
        _   -> error usage          
  forM_ rawFiles (runCommand . flip cmd fmt)

usage = "./runghc render.hs [HTML|WordDoc|PDF]"

stripExt :: FilePath -> FilePath
stripExt = reverse . drop 1 . dropWhile (/= '.') . reverse
