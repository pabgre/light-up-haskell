module BoardInteraction
    (place_bulb,
    is_empty,
    is_black,
    is_lighted,
    count_true,
    get_need,
    get_space_arround,
    place_bulb_arround,
    place_forbidden_arround,
    get_bulb_arround,
    get_source_available
    ) where

import BoardUtils

place_forbidden :: Int -> Int -> Board -> Board
place_forbidden x y board
       |((is_in_range x y board) && (is_empty x y board)) = change_elem x y (Empty False) board
       |otherwise = board

place_bulb :: Int -> Int -> Board -> Board
place_bulb x y board
      |((is_in_range x y board) && (e == Empty True)) = (light_at x y (change_elem x y Light board))
      | otherwise = board
      where e = get_elem x y board

light_at :: Int -> Int -> Board -> Board
light_at x y board
      |((get_elem x y board) == Light) = light_north x y (light_east x y (light_west x y (light_south x y board)))
      |otherwise = board

light_north :: Int -> Int -> Board -> Board
light_north x y board = light_generic x y (-1+) (0+) board

light_east :: Int -> Int -> Board -> Board
light_east x y board = light_generic x y (0+) (-1+) board

light_west :: Int -> Int -> Board -> Board
light_west x y board = light_generic x y (0+) (1+) board

light_south :: Int -> Int -> Board -> Board
light_south x y board = light_generic x y (1+) (0+) board

light_generic :: Int -> Int -> (Int -> Int) -> (Int -> Int) -> Board -> Board
light_generic x y fx fy board = light_generic' (fx x) (fy y) fx fy board

light_generic' x y fx fy board
      |(is_in_range x y board) && (is_empty x y board) = light_generic' (fx x) (fy y) fx fy (change_elem x y Lighted board)
      |(is_in_range x y board) && (is_lighted x y board) = light_generic' (fx x) (fy y) fx fy board
      |otherwise = board
      where e = get_elem x y board

is_empty :: Int -> Int -> Board -> Bool
is_empty x y board = (is_in_range x y board) && (e == (Empty True) || e == (Empty False))
  where e = get_elem x y board

is_available :: Int -> Int -> Board -> Bool
is_available x y board = (is_in_range x y board) && ((get_elem x y board) == Empty True)

is_black :: Int -> Int -> Board -> Bool
is_black x y board = (is_in_range x y board) && (e == Black || e == Black0 || e == Black1 || e == Black2 || e == Black3 || e == Black4)
         where e = get_elem x y board

is_bulb :: Int -> Int -> Board -> Bool
is_bulb x y board = (is_in_range x y board) && (get_elem x y board) == Light

is_lighted :: Int -> Int -> Board -> Bool
is_lighted x y board = (is_in_range x y board) && (e == Lighted)
  where e = get_elem x y board

get_need :: Int -> Int -> Board -> Int
get_need x y board
  | e == Black0 = 0 - bulbs
  | e == Black1 = 1 - bulbs
  | e == Black2 = 2 - bulbs
  | e == Black3 = 3 - bulbs
  | e == Black4 = 4 - bulbs
  | otherwise = -1
  where e = get_elem x y board
        bulbs = get_bulb_arround x y board


get_source_generic :: Int -> Int -> (Int -> Int) -> (Int -> Int) -> Board -> [(Int, Int)]
get_source_generic x y fx fy board = get_source_generic' (fx x) (fy y) fx fy board

get_source_generic' x y fx fy board
      |(is_in_range x y board) && (e == Empty True) = (x,y) : get_source_generic' (fx x) (fy y) fx fy board
      |(is_in_range x y board) && (not (is_black x y board)) = get_source_generic' (fx x) (fy y) fx fy board
      |otherwise = []
      where e = get_elem x y board

get_source_north :: Int -> Int -> Board -> [(Int, Int)]
get_source_north x y board = get_source_generic x y (-1+) (0+) board

get_source_east :: Int -> Int -> Board -> [(Int, Int)]
get_source_east x y board = get_source_generic x y (0+) (-1+) board

get_source_west :: Int -> Int -> Board -> [(Int, Int)]
get_source_west x y board = get_source_generic x y (0+) (1+) board

get_source_south :: Int -> Int -> Board -> [(Int, Int)]
get_source_south x y board = get_source_generic x y (1+) (0+) board

get_source_available :: Int -> Int -> Board -> [(Int, Int)]
get_source_available x y board = (get_source_north x y board) ++ (get_source_east x y board) ++ (get_source_west x y board) ++ (get_source_south x y board)


count_true :: [Bool] -> Int
count_true xs = foldl (flip ((+) . fromEnum)) 0 xs

get_info_arround :: Int -> Int-> (Int-> Int-> Board -> Bool) -> Board -> Int
get_info_arround x y f board = count_true ((f (x + 1) y board):(f (x - 1) y board):(f x (y + 1) board):(f x (y - 1) board):[])

get_space_arround :: Int -> Int-> Board -> Int
get_space_arround x y board = get_info_arround x y (is_available) board

get_bulb_arround :: Int -> Int -> Board -> Int
get_bulb_arround x y board = get_info_arround x y (is_bulb) board

place_forbidden_arround :: Int -> Int -> Board -> Board
place_forbidden_arround x y board = place_forbidden (x + 1) y (place_forbidden (x - 1) y (place_forbidden x (y - 1) (place_forbidden x (y + 1) board)))

place_bulb_arround :: Int -> Int -> Board -> Board
place_bulb_arround x y board = place_bulb (x + 1) y (place_bulb (x - 1) y (place_bulb x (y - 1) (place_bulb x (y + 1) board)))
