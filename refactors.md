# Version 1

 - `score` is way too long! (Long Function). Let's break it up using extract variable
 - In `score`, we start with `result` as an empty string and then build it up based on the score (Mutable Data). Let's use Replace Loop with Pipeline
 - We have an index of numerical scores to tennis scores used twice (Duplicated Code). We should keep it in one place (use Extract to Function)
 - In `end_game_result` `minusResult` is an unclear name to me (Myterious Name). Let's clarify it using Rename Variable.
 - player names aren't needed in this version! Let's not save them to ivars and underscore prefix them in the constructor signature. (Remove Dead Code)