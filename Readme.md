# Light Up puzzle solver

A simple Light Up Puzzle Solver written in Haskell

Here you can play this kind of puzzles online: https://www.puzzle-light-up.com/

And here you can find the paper I based on, in order to implement the algorithm in Haskell: https://www.researchgate.net/publication/240627368_A_Simple_and_Rapid_Lights-up_Solver


## Instructions
Load module *Main.hs*<br>
<code>
Prelude> :l Main.hs
</code>

Once it is loaded, if the main program doesn't start, run the folowing:<br>
<code>
*Main> main
</code>

You will be asked for the board you want to be solved. Write a number between 1 and 5 and the program will show you the solution of that specific board. You can find the boards available for this demo in the */boards* folder. You can add your own boards too.

## Notation
In order to understand the solution or if you want to make your own boards, here you can find the symbols' meaning:

| Symbol   |     Description     |  Icon  |
|----------|:-------------:|-----------:|
| **.**    |  Empty Available Cell |⬜|
| **.**    |  Empty Unavailable Cell |❎|
| **L** |   Light Bulb    | 💡  |
| **\*** |  Lighted Cell |🔆|
| **x** | Wall |⏹️|
|**0**| Wall 0 | 0️⃣ |
| **1** | Wall near 1 | 1️⃣|
| **2** | Wall near 2 | 2️⃣|
| **3** | Wall near 3 | 3️⃣|
| **4** | Wall near 4 |4️⃣|
