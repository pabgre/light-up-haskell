# Light Up puzzle solver

A simple Light Up Puzzle Solver written in Haskell

Here you can play this kind of puzzles online: https://www.puzzle-light-up.com/

And here you can find the paper I based on, in order to implement the algorithm in Haskell: https://www.researchgate.net/publication/240627368_A_Simple_and_Rapid_Lights-up_Solver


## Instructions
Enter in the ghci console:<br>
<code>
$ ghci
</code>

Load module *Main.hs*:<br>
<code>
Prelude> :l Main.hs
</code>

Once it is loaded, if the main program doesn't start, run the following:<br>
<code>
*Main> main
</code>

Now you will be asked what do you want to do with the program. You can either play, find the solution for a specific board or exit the program. If you type **play** you will choose a board from the board folders and you can try to solve it. If you type **solve**, you can choose the board from the boards folder you want the program to solve. And if you type **exit** the program will finish.


### Play
You will be asked for the board you want to solve. Write a number between **1** and **5** or write **saved** if you want to continue with the last saved board. Once the board is selected you can either put a bulb by typing **place**. Then you will need to specify the **row** and **collumn** number starting by 0. If you want to go back, can type **revert**. Finally you can type **exit** to exit the program.


### Solve

You will be asked for the board you want to be solved. Write a number between 1 and 5 and the program will show you the solution of that specific board. You can find the boards available for this demo in the */boards* folder. You can add your own boards too.

## Notation
In order to understand the solution or if you want to make your own boards, here you can find the symbols' meaning:

| Symbol   |     Description     |  Icon  |
|----------|:-------------:|-----------:|
| **.**    |  Empty Available Cell |⬜|
| **.**    |  Empty Unavailable Cell |❌|
| **L** |   Light Bulb    | 💡  |
| **\*** |  Lighted Cell |🔆|
| **E** |  Light Error |🚫|
| **x** | Wall |⏹️|
|**0**| Wall 0 | 0️⃣ |
| **1** | Wall near 1 | 1️⃣|
| **2** | Wall near 2 | 2️⃣|
| **3** | Wall near 3 | 3️⃣|
| **4** | Wall near 4 |4️⃣|


made by [@pabgre](https://github.com/pabgre/light-up-haskell)
