module Main where

import BoardUtils
import BoardInteraction
import Patterns


main = do
  process

play :: [Board] -> Board -> IO ()
play xs board = do
   print (board)
   putStr "What do you want to do?\n['place', 'revert', 'save', 'exit']\n-> "
   option <- getLine
   if option == "place"
     then do
       putStr "Choose row-> "
       x <- getLine
       putStr "Choose collumn-> "
       y <- getLine
       play (board:xs) (place_bulb_player (read (head (words(x)))) (read (head (words(y)))) board)
     else if option == "revert"
       then do
         if (length xs) > 0
           then do
           play (tail xs) (head xs)
           else do
             putStr "Sorry, no more movements availables...\n[Press any key]"
             enter <- getLine
             play [] board
       else if option == "save"
         then do
           writeFile "boards/saved" (unlines (cellToCharBoard board))
           play xs board
         else if option == "exit"
           then return ()
           else play xs board

process :: IO ()
process = do
           putStr "What do you want to do?\n['play', 'solve' or 'exit']\n-> "
           option <- getLine
           if option == "solve"
             then do
               putStr "Which puzzle should I solve?\n['exit' for exit]\n-> "
               name <- getLine
               if name /= "exit"
                 then do
                   content <- readFile ("boards/" ++ name)
                   let board :: Board
                       board = charToCellBoard (lines (content))
                   print (solve board)
                   process
                 else return()
            else if option == "play"
              then do
                putStr "Which puzzle do you want to play?\n[type from 1 to 5 or 'exit' for exit]\n-> "
                name <- getLine
                if name /= "exit"
                  then do
                    content <- readFile ("boards/" ++ name)
                    let board :: Board
                        board = charToCellBoard (lines (content))
                    play [] board
                  else return()
              else if option == "exit"
                then return ()
                else process
