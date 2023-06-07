# Project I

This project is based on an assignment for a course in **'Discrete Mathematics'** 
given at *KTH Royal Institute of Technology in Stockholm*.

### _Combinatorics and Set Theory_
    Course code: KTH/ICT:IX1500 - Discrete Mathematics, ht22 
    Date: 2022-09-22

Instead of Mathematica, the **Pluto Notebook** was used to create 
an interactive notebook.
All code is written in **Julia**, however, som interacting parts had 
some **JavaScrips** and **CSS** in them.

## Task A
### Summary
#### Task
In the Texas hold 'em poker game every player gets just two cards (hole cards),
while the best hand is determined by the combination of any five cards chosen
from your two face down \"hole\" cards and the five face up \"community\" cards
(shared by all players). 

The problem consists of determining the exact probability of the hands below
(best hand possible), using the census method (2.4 above), when a player has two
specific \"hole\" cards and the community cards are unknown. This is the situation
in the first pre-flop (before dealing the community cards) betting round in
Texas hold 'em. Choose the specific \"hole\" cards at random. 

After this choose three of the five \"community cards\" at random and redo the
calculation of the probabilities. Keep the specific \"hole cards\" you had.
This is the situation of the second betting round. Compare the pre-flop
possibilities with the situation where three of the \"community cards\" are
known and discuss the results.

The deck is a normal 52-card deck without any jokers.

* one pair
* two pairs
* three of a kind
* straight
* flush
* full house
* four of a kind
* straight flush
* royal straight flush
 
## Task B
### Summary
#### Task
The birthday paradox is that the probability of two persons sharing the same
birthday in a
group, exceeds 50%, when the group consists of only 23 people.

* If there are $N$ people in the room, what is the probability that at least
  two of them have the same birthday?
* What is the probability for $N = 40$?

* Suppose you are in the room, then what is the probability that one of them
  has the same birthday as yours? Is this the same probability as above?
* Draw graphs of the probabilities as a function of $N$ .
* Simulate the birthday paradox repeatedly and calculate the average
  probability for different values of $N$ . Draw graphs and compare to the
  calculated versions above. Conclusions?
  
## Info & tutorials

### Regular Expressions in Julia
- [GeeksforGeeks ion regex in Julia](https://www.geeksforgeeks.org/regular-expressions-in-julia/)
- [Julialangs strings doc](https://docs.julialang.org/en/v1/manual/strings/)
- [Derek Banas REGEX Turorial](https://www.youtube.com/watch?v=DRR9fOXkfRE&list=PLFA4F2FDD28D0C40E)

### Julia & Pluto
* [JULIA TUTORIAL at new Think Tank, Derek Bananas](https://www.newthinktank.com/2018/10/julia-tutorial/)
* [MOOC course](https://syl1.gitbook.io/julia-language-a-concise-tutorial/)
* [RIP Tutorial](https://riptutorial.com/julia-lang)
* [CS Lectures](https://www.cs.mcgill.ca/~dprecup/courses/IntroCS/Lectures/)
* [Julia Talk](https://www.talkjulia.com/)
* [Combinatorics](https://juliamath.github.io/Combinatorics.jl/dev/)
* [Julia Language Database JuliaDB - YouTube](https://www.youtube.com/watch?v=pv5zfIs2lyU&list=PLsu0TcgLDUiLfwJipaXOBRqwqZlT4Atfk)
* [Julia for simple medical statistical analysis](https://www.youtube.com/watch?v=4nPmKG_f8-M&list=PLsu0TcgLDUiIznEhN165XmykqyLgzwY0Y)
* [Blog-post: Beautiful julia](http://blog.translusion.com/posts/beautiful-julia/)
* [juliadatascience](https://juliadatascience.io/)
* [Tutorialpoint](https://www.tutorialspoint.com/julia/julia_dictionaries_sets.htm)

### Markdown
* [markdown guide](https://www.markdownguide.org/)
* [markdown cheat-sheet](https://www.markdownguide.org/cheat-sheet/)

### Poker
* [Hand rankings](https://www.pokerstars.se/en/poker/games/rules/hand-rankings/)
* [Texas hold'em](https://www.pokerstars.se/en/poker/games/texas-holdem/)
* [Poker probability wiki](https://en.wikipedia.org/wiki/Poker_probability)

### Birthday Paradox
* [Understanding the Birthday Paradox](https://betterexplained.com/articles/understanding-the-birthday-paradox/)
