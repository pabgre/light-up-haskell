module BoardUtils
        (Board(..),
        Cell(..),
        get_elem,
        change_elem,
        is_in_range,
        charToCell,
        cellToChar,
        charToCellBoard,
        cellToCharBoard
        ) where


data Cell = Empty Bool | Light | Lighted | LError | Black | Black0 | Black1 | Black2 | Black3 | Black4
  deriving(Eq, Show, Read)

data Board = B Int [[Cell]]
  deriving(Eq, Read)

charToCell :: Char -> Cell
charToCell c
  |(c == '.') = Empty True
  |(c == ':') = Empty False
  |(c == 'L') = Light
  |(c == '*') = Lighted
  |(c == 'E') = LError
  |(c == 'x') = Black
  |(c == '0') = Black0
  |(c == '1') = Black1
  |(c == '2') = Black2
  |(c == '3') = Black3
  |(c == '4') = Black4
  |otherwise = Empty True

cellToChar :: Cell -> Char
cellToChar c
  |(c == Empty True) = '.'
  |(c == Empty False) = ':'
  |(c == Light) = 'L'
  |(c == Lighted) = '*'
  |(c == LError) = 'E'
  |(c == Black) = 'x'
  |(c == Black0) = '0'
  |(c == Black1) = '1'
  |(c == Black2) = '2'
  |(c == Black3) = '3'
  |(c == Black4) = '4'
  |otherwise = '\0'

charToCellBoard :: [[Char]] -> Board
charToCellBoard xss = B (length xss) (map (map charToCell) xss)

cellToCharBoard :: Board -> [[Char]]
cellToCharBoard (B _ b) = map (map cellToChar) b

get_elem :: Int -> Int -> Board -> Cell
get_elem x y  (B n xs) = (xs !! x) !! y

replace :: Int -> a -> [a] -> [a]
replace i e (x:xs)
      |i <= 0 = e:xs
      |otherwise = x:(replace (i - 1) e xs)

change_elem :: Int -> Int -> Cell -> Board -> Board
change_elem row col x (B n xs) = B n (replace row modified_row xs)
    where
        modified_row = replace col x row_to_replace_in
        row_to_replace_in = xs !! row

is_in_range :: Int -> Int -> Board -> Bool
is_in_range x y (B n _) = (x >= 0) && (y >= 0) && (n > x) && (n > y)

check_available :: Cell -> Bool
check_available (Empty x) = x
check_available _ = False

instance Show Board where
  show board = showBoard board


showBoard :: Board -> String
showBoard (B n b) = "\nSize: " ++ (show n) ++ "x" ++ (show n) ++ "\n" ++ (unlines (cellToCharBoard (B n b)))
