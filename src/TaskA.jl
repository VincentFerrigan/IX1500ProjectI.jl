#= 
TaskA.jl
- Julia version: 1.8.0
- Author: Vincent Ferrigan <ferrigan@kth.se>
- Course code: KTH/ICT:IX1500 - Discrete Mathematics, ht22 
- Assignment: Project 1
- Date: 2022-09-17
- Version: 0.2
=#

module TaskA
using Combinatorics
using Random
import Base.show
import Base.==

const RANKS = [:ace, :two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king]
const SUITS = [:♣, :♢, :♡, :♠]

# types
struct Card
    rank::Symbol
    suit::Symbol
    nbr

    function Card(rank::Symbol, suit::Symbol)
        # short-circuit conditionals.
        rank in RANKS || throw(ArgumentError("invalid rank: $rank"))
        suit in SUITS || throw(ArgumentError("invalid suit: $suit"))
        # new(rank, suit)
        new(rank, suit, findfirst(isequal(rank), RANKS))
    end
end

# Overload
function Base.show(io::IO, card::Card)
    print(io, card.suit) 
	print(io, card.rank)
end

function Base.:(==)(a::Card, b::Card) 
    a.suit == b.suit  &&  a.rank == b.rank
end

# utils
function fulldeck()
    deck = Vector{Card}(undef, 0)
    for suit in SUITS
	    for rank in RANKS
		    push!(deck, Card(rank, suit))
	    end
    end
    shuffle!(deck)
    return deck
end

function hasonepair(cards::Vector{Card})
    # must exclude two pair, three of a kind and four of a kind
    # short-circuit return condition
    n = length(cards)
	n < 2  &&  return false

    for i = 1:n
        count = 1
        for j = (i + 1):n
            if cards[i].rank == cards[j].rank
                count += 1
            end
            if count == 2 return true end
        end
    end
    return false
end

function hastwopair(cards)
    # must exlude fakepositivs, like full-house, one pair etc
    n = length(cards)
	n < 4  &&  return false

    countpairs = 0
    for i = 1:n
        countpair = 1
        for j = (i + 1):n
            if cards[i].rank == cards[j].rank
                countpair += 1
            end
            if countpair == 2 countpairs += 1 end
        end
        if countpairs == 2 return true end
    end
    return false
end

function hasthreeofakind(cards)
    # must exclude four of a kind, and full house
    # short-circuit return condition
    n = length(cards)
	n < 3  &&  return false

    for i = 1:n
        count = 1
        for j = (i + 1):n
            if cards[i].rank == cards[j].rank
                count += 1
            end
            if count == 3 return true end
        end
    end
    return false
end

function hasstraight(cards)
    # short-circuit return condition
    n = length(cards)
	n < 5  &&  return false

    # sort
    temp = sort(cards, by = c -> c.nbr)
    start = 1
    
    if cards[1].nbr == 1 && cards[n].nbr == 13
        start = 2
    end

    for i = start:n
        for j = i+1:n
            if cards[j].nbr != cards[i].nbr + 1
                return false
            end
        end
    end
    return true
end


function hasflush(cards)
    # Flush (must exclude royal flush and straight flush)
    # short-circuit pre-conditionals.
	length(cards) == 5  ||  return false

    for card in cards
		if card.suit != cards[1].suit
			return false
		end
	end
	return true
end

function hasfullhouse(cards)
    # short-circuit return condition
    n = length(cards)
	n < 5  &&  return false

    return hastwopair(cards) && hasthreeofakind(cards)
end


function hasfourofakind(cards)
    # short-circuit return condition
    n = length(cards)
	n < 4  &&  return false

    for i = 1:n
        count = 1
        for j = (i + 1):n
            if cards[i].rank == cards[j].rank
                count += 1
            end
            if count == 4 return true end
        end
    end
    return false
end

function hasstraightflush(cards)
    # short-circuit return condition
    n = length(cards)
	n < 5  &&  return false

    return hasflush(cards) && hasstraight(cards)
end


function hasroyalstraightflush(cards)
    # short-circuit return condition
    n = length(cards)
	n < 5  &&  return false

   return hasstraightflush(cards) && :ace in cards && :king in cards
end
    

# collections
const HOLECOMB = combinations(fulldeck(), 2) |> collect
const COMMUNITYCOMB = combinations(fulldeck(), 3) |> collect 
const HANDCOMB = combinations(fulldeck(), 5) |> collect 

# partitions(HOLECOMB)

decktest = fulldeck()
holetest = Vector{Card}(undef, 0)
push!(holetest, pop!(decktest))
push!(holetest, pop!(decktest))

comunitytest = Vector{Card}(undef, 0)
push!(comunitytest, pop!(decktest))
push!(comunitytest, pop!(decktest))
push!(comunitytest, pop!(decktest))

handtest = vcat(holetest, comunitytest)


# parttest = partitions(handtest, 2) |> collect
# parts = partitions(COMMUNITYCOMB)

dict = Dict(
    :onepair =>         filter(x -> hasonepair(x), HANDCOMB),
    :twopairs =>        filter(x -> hastwopair(x), HANDCOMB),
    :threeofakind =>    filter(x -> hasthreeofakind(x), HANDCOMB),
    :straight =>        filter(x -> hasstraight(x), HANDCOMB),
    :flush =>           filter(x -> hasflush(x), HANDCOMB),
    :fullhouse =>       filter(x -> hasfullhouse(x), HANDCOMB),
    :fourofakind =>     filter(x -> hasfourofakind(x), HANDCOMB),
    :straightflush =>   filter(x -> hasstraightflush(x), HANDCOMB),
    :royalstraightflush =>   filter(x -> hasroyalstraightflush(x), HANDCOMB)
)

# fok = filter(x -> fourofakind(x), HANDCOMB)
# op = filter(x -> onepair(x), HANDCOMB)
# fl = filter(x -> flush(x), HANDCOMB)
# length(HANDCOMB)
# size(op)[1]
# size(fl)[1]
# size(fok)[1]
# fok
# length(COMMUNITYCOMB)
# t = filter(x -> onepair(x), COMMUNITYCOMB)
# length(t)
# println(t)
# filter(x -> flush(partitions(x)), HOLECOMB)
# HOLECOMB
end # module