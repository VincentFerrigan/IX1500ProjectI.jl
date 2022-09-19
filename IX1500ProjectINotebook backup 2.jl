### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ 3c889854-4e74-4136-aa45-0a3c7430df61
# Packages
begin
	#using InteractiveUtils
	using PlutoUI
	using Plots
end

# ╔═╡ 44fd5f71-c347-4754-a50b-09f43b615e47
### A ProjectOneGroup17.jl notebook ###

# ╔═╡ 7d3d76b4-a16b-4f86-bb72-6e489edd243e
md"
# PROJECT-stuff _(To be disabled from the report)_
## Open Issues
### Pluto
- How do I add none code? 
*Well, just use Markdown with md\" ...\"*

- How do I add keybindings?
- How do I spellcheck with LT?

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

### Markdown
* [markdown guide](https://www.markdownguide.org/)
* [markdown cheat-sheet](https://www.markdownguide.org/cheat-sheet/)

### Poker
* [Hand rankings](https://www.pokerstars.se/en/poker/games/rules/hand-rankings/)
* [Texas hold'em](https://www.pokerstars.se/en/poker/games/texas-holdem/)
"

# ╔═╡ d14e9714-3365-11ed-1125-7be966581a61
md"
# Report Project I
# _Combinatorics and Set Theory_
    Course code: KTH/ICT:IX1500 - Discrete Mathematics, ht22 
    Date: 2022-09-13
    Version: 0.1
    Vincent Ferrigan, ferrigan@kth.se
    Name 2, name2@kth.se
"

# ╔═╡ d34338c7-b02d-4290-b3e4-212373278cb1


# ╔═╡ fa06cb75-cef4-48c7-a920-27be6d51f7af
md"
## Task A
### Summery
#### Task
In the Texas hold 'em poker game every player gets just two cards (hole cards),
while the best hand is determined by the combination of any five cards chosen
from your two face down \"hole\" cards and the five face up \"community\" cards
(shared by all players). 

The problem consist of determining the exact probability of the hands below
(best hand possible), using the census method (2.4 above), when a player has two
specific \"hole\" cards and the community cards are unknown. This is the situation
in the first pre-flop (before dealing the community cards) betting round in
Texas hold 'em. Chose the specific \"hole\" cards at random. 

After this choose three of the five \"community cards\" at random and redo the calculation of the probabilities. Keep the specific \"hole cards\" you had. This is the situation of the second betting round. Compare the pre-flop probabilities with the situation where three of the \"community cards\" are known and discuss the results.

The deck is a normal 52 card deck without any jokers.

* one pair
* two pairs
* three of a kind
* straight
* flush
* full house
* four of a kind
* straight flush
* royal straight flush
"

# ╔═╡ 42e9660c-dbda-4bd1-8146-d2e88a8d374a
md"
#### Result
"

# ╔═╡ 8b8284ba-6e95-4947-a8bc-09ed5046c0f8
md"
### Texas hold 'em poker
"

# ╔═╡ 67e3c538-0330-461b-abfd-3271d13cf4fc


# ╔═╡ 8118483c-5b54-4fc2-8825-17f2022b4316
md"
### Code
"

# ╔═╡ d95bed62-ed09-4fb8-9401-f8d39300ac19
begin
	const RANKS = Set([:ace, :two, :three, :four, :five, :six, :seven, :eight, :nine,
	                   :ten, :jack, :queen, :king])
	const SUITS = Set([:♣, :♦, :♥, :♠])
	
	struct Card
	    rank::Symbol
	    suit::Symbol
	    function Card(r::Symbol, s::Symbol)
	        # short-circuit conditionals.
			r in RANKS || throw(ArgumentError("invalid rank: $r"))
	        s in SUITS || throw(ArgumentError("invalid suit: $s"))
	        new(r, s)
	    end
	end
end

# ╔═╡ dd33dca5-d435-41bc-afa8-b8d393aed7cd
md"
## Task A
### Summery
#### Task
The birthday paradox is that the probability of two persons sharing the same birthday in a
group, exceeds 50%, when the group consists of only 23 people.

* If there are N people in the room, what is the probability that at least two of them have the same birthday?
* What is the probability for N = 40?

* Suppose you are in the room, then what is the probability that one of them has the same birthday as yours? Is this the same probability as above?
* Draw graphs of the probabilities as a function of N .
* Simulate the birthday paradox repeatedly and calculate the average probability for different values of N . Draw graphs and compare to the calculated versions above. Conclusions?
"

# ╔═╡ c952bcf0-a966-44f5-8430-7edf28f7288b
md"
#### Result
"

# ╔═╡ f57d4947-2829-4e82-b5c9-14e7c1fec8ac
md"
### Code
"

# ╔═╡ d2941c1e-de80-47a1-b7ee-9db383cfecb5


# ╔═╡ Cell order:
# ╠═44fd5f71-c347-4754-a50b-09f43b615e47
# ╠═3c889854-4e74-4136-aa45-0a3c7430df61
# ╠═7d3d76b4-a16b-4f86-bb72-6e489edd243e
# ╠═d14e9714-3365-11ed-1125-7be966581a61
# ╠═d34338c7-b02d-4290-b3e4-212373278cb1
# ╠═fa06cb75-cef4-48c7-a920-27be6d51f7af
# ╠═42e9660c-dbda-4bd1-8146-d2e88a8d374a
# ╠═8b8284ba-6e95-4947-a8bc-09ed5046c0f8
# ╠═67e3c538-0330-461b-abfd-3271d13cf4fc
# ╠═8118483c-5b54-4fc2-8825-17f2022b4316
# ╠═d95bed62-ed09-4fb8-9401-f8d39300ac19
# ╠═dd33dca5-d435-41bc-afa8-b8d393aed7cd
# ╠═c952bcf0-a966-44f5-8430-7edf28f7288b
# ╠═f57d4947-2829-4e82-b5c9-14e7c1fec8ac
# ╠═d2941c1e-de80-47a1-b7ee-9db383cfecb5
