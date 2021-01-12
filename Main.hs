module Main where

import BoardUtils
import BoardInteraction
import Patterns

import Control.Monad.Trans.Except

main = do
  procesa

process :: IO ()
process = do
           putStr "Which puzzle should I solve?\n['exit' for exit]\n\n-> "
           name <- getLine
           if name /= "exit" then do
               content <- readFile ("boards/" ++ name)
               let board :: Board
                   board = charToCellBoard (lines (content))
               print (solve board)
               process
            else return()
