module Patterns
      (pattern_I,
      pattern_II,
      solve
      )where

import BoardUtils
import BoardInteraction

pattern_I :: Board -> Board
pattern_I board = pattern_I' 0 0 board

pattern_I' x y (B n b)
  | (x == n - 1) && (y == n - 1) = (try_complete_I x y (B n b))
  | (x == n - 1) = pattern_I' 0 (y + 1) (try_complete_I x y (B n b))
  | otherwise = pattern_I' (x + 1) y (try_complete_I x y (B n b))

try_complete_I :: Int-> Int -> Board -> Board
try_complete_I x y board
              | (get_need x y board) == 0 = place_forbidden_arround x y board
              | (get_need x y board) == (get_space_arround x y board) = place_bulb_arround x y board
              | otherwise = board


pattern_II :: Board -> Board
pattern_II board = pattern_II' 0 0 board

pattern_II' x y (B n b)
  | (x == n - 1) && (y == n - 1) = (try_complete_II x y (B n b))
  | (x == n - 1) = pattern_II' 0 (y + 1) (try_complete_II x y (B n b))
  | otherwise = pattern_II' (x + 1) y (try_complete_II x y (B n b))


try_complete_II :: Int -> Int -> Board -> Board
try_complete_II x y board
      | (length srclst == 0) && (e == Empty True) = place_bulb x y board
      | (length srclst == 1) && (e == Empty False) = place_bulb (fst (head srclst)) (snd (head srclst)) board
      | otherwise = board
      where srclst = (get_source_available x y board)
            e = get_elem x y board


pattern_sequence :: Board -> Board
pattern_sequence board = (loop_when_change (loop_when_change board pattern_I) pattern_II)

solve :: Board -> Board
solve board = loop_when_change board pattern_sequence

loop_when_change :: Board -> (Board -> Board)-> Board
loop_when_change board f = loop_when_change' True board f

loop_when_change' changed board f
        | changed = loop_when_change' (newboard /= board) newboard f
        | otherwise = board
        where newboard = f board
