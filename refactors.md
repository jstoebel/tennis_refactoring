# Version 1

 - `score` is way too long! (Long Function). Let's break it up using extract variable
 - In `score`, we start with `result` as an empty string and then build it up based on the score (Mutable Data). Let's use Replace Loop with Pipeline
 - We have an index of numerical scores to tennis scores used twice (Duplicated Code). We should keep it in one place (use Extract to Function)
 - In `end_game_result` `minusResult` is an unclear name to me (Myterious Name). Let's clarify it using Rename Variable.
 - player names aren't needed in this version! Let's not save them to ivars and underscore prefix them in the constructor signature. (Remove Dead Code)

# Version 2

 - Again, a lot of Mutable Data!
 - We're doing a lot of repetition. (if player 1 has more than 0 points and player 2 has no points...and if visa versa)
 - It looks like each of these conditionals is a composition of basic facts on the state of the game
    - if the game is tied
    - if the game is in the end phase (someone has > 2 points) or mid phase
    - which player is in the lead
    - the name of the players
 - Lets have a Player class which stores all of the state on a player.
 - Logic that involves comparing the two players (there are many) will belong in the Game class, but the Game will ask the player instances. It really is just the mediator.
