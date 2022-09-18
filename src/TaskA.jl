# TaskA.jl
# - Julia version: 1.8.0
# - Author: Vincent Ferrigan <ferrigan@kth.se>
# - Course code: KTH/ICT:IX1500 - Discrete Mathematics, ht22 
# - Assignment: Project 1
# - Date: 2022-09-18
# - Version: 0.7

module TaskA
using Combinatorics
using Random
import Base.show
import Base.==

export collectionofhands, fulldeck, Card

const RANKS = [:ace, :two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king]
const SUITS = [:♣, :♢, :♡, :♠]

# types
struct Card
    rank::Symbol
    suit::Symbol

    function Card(rank::Symbol, suit::Symbol)
        # short-circuit conditionals.
        rank in RANKS || throw(ArgumentError("invalid rank: $rank"))
        suit in SUITS || throw(ArgumentError("invalid suit: $suit"))
        new(rank, suit)
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
    # must exclude two pairs, three of a kind and four of a kind
    # short-circuit return condition
    n = length(cards)
	n < 2  &&  return false

    rankvector = Vector{Symbol}(undef, 0)
    rankset = Set()
    for card ∈ cards
        push!(rankvector, card.rank)
        push!(rankset, card.rank)
    end

    for r ∈ rankset
        if size(findall(isequal(r), rankvector))[1] >= 2
            return true
        end
    end
    return false
end

function hastwopairs(cards)
    # must exclude fakepositivs, like full-house, one pair etc
    # short-circuit return condition
    n = length(cards)
	n < 4  &&  return false

    rankvector = Vector{Symbol}(undef, 0)
    rankset = Set()
    
    for card ∈ cards
        push!(rankvector, card.rank)
        push!(rankset, card.rank)
    end

    count = 0
    for r ∈ rankset
        if size(findall(isequal(r), rankvector))[1] >= 2
            count +=1
        end
    end

    if count >= 2 return true end
    return false 
end

function hasthreeofakind(cards)
    # must exclude four of a kind, and full house
    # short-circuit return condition
    n = length(cards)
	n < 3  &&  return false

    rankvector = Vector{Symbol}(undef, 0)
    rankset = Set()
    for card ∈ cards
        push!(rankvector, card.rank)
        push!(rankset, card.rank)
    end

    for r ∈ rankset
        if size(findall(isequal(r), rankvector))[1] >= 3
            return true
        end
    end
    return false
end

function hasstraight(cards)
    # short-circuit return condition
    n = length(cards)
	n < 5  &&  return false

    rankvector = Vector{Symbol}(undef, 0)
    valuevector = Vector(undef, 0)
    rankset = Set()
    
    for card ∈ cards
        push!(rankvector, card.rank)
        push!(valuevector, findfirst(isequal(card.rank), RANKS))
        push!(rankset, card.rank)
    end

    if length(rankset) < 5 return false end
    sort!(valuevector)

    start = 1
    if :ace in rankset && :king in rankset
        start = 2
    end
    for i = start:n-1
        if valuevector[i + 1] != (valuevector[i] + 1)
            return false
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

    rankset = Set()
    for card ∈ cards push!(rankset, card.rank) end
    if length(rankset) > 2 return false end
    return hastwopairs(cards) && hasthreeofakind(cards)
end


function hasfourofakind(cards)
    # short-circuit return condition
    n = length(cards)
	n < 4  &&  return false

    rankvector = Vector{Symbol}(undef, 0)
    rankset = Set()
    for card ∈ cards
        push!(rankvector, card.rank)
        push!(rankset, card.rank)
    end

    for r ∈ rankset
        if size(findall(isequal(r), rankvector))[1] >= 4
            return true
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

    rankset = Set()
    
    for card ∈ cards
        push!(rankset, card.rank)
    end

   return hasstraightflush(cards) && :ace in rankset && :king in rankset
end

# OM TID FINNS
function highcard(cards)
    rankvector = Vector{Symbol}(undef, 0)
    valuevector = Vector(undef, 0)
    rankset = Set()
    suitset = Set()
    
    for card ∈ cards
        push!(rankvector, card.rank)
        push!(rankset, card.rank)
        push!(suitset, card.suit)
    end
    if length(suitset) < 2 && length(cards) == 5
        return false
    elseif length(rankset) < 5 && length(cards) >= 5
        return false
    end
end
    

# collections
const HOLECOMB = combinations(fulldeck(), 2) |> collect
const COMMUNITYCOMB = combinations(fulldeck(), 3) |> collect 
const HANDCOMB = combinations(fulldeck(), 5) |> collect 

function collectionofhands()
    dict = Dict(
        :onepair => filter(x -> hasonepair(x), HANDCOMB),
        :twopairs => filter(x -> hastwopairs(x), HANDCOMB),
        :threeofakind => filter(x -> hasthreeofakind(x), HANDCOMB),
        :straight => filter(x -> hasstraight(x), HANDCOMB),
        :flush => filter(x -> hasflush(x), HANDCOMB),
        :fullhouse => filter(x -> hasfullhouse(x), HANDCOMB),
        :fourofakind => filter(x -> hasfourofakind(x), HANDCOMB),
        :straightflush => filter(x -> hasstraightflush(x), HANDCOMB),
        :royalstraightflush => filter(x -> hasroyalstraightflush(x), HANDCOMB)
        )
        return dict
end

# tests
# h1p = filter(x -> hasonepair(x), HANDCOMB)
# h2p = filter(x -> hastwopairs(x), HANDCOMB)
# h3 = filter(x -> hasthreeofakind(x), HANDCOMB)
# hs = filter(x -> hasstraight(x), HANDCOMB)
# hf = filter(x -> hasflush(x), HANDCOMB)
# hfh = filter(x -> hasfullhouse(x), HANDCOMB)
# h4 = filter(x -> hasfourofakind(x), HANDCOMB)
# hsf = filter(x -> hasstraightflush(x), HANDCOMB)
hrsf = filter(x -> hasroyalstraightflush(x), HANDCOMB)

# partitions(HOLECOMB)
# deckteVst = fulldeck()
# holetest = Vector{Card}(undef, 0)
# push!(holetest, pop!(decktest))
# push!(holetest, pop!(decktest))

# comunitytest = Vector{Card}(undef, 0)
# push!(comunitytest, pop!(decktest))
# push!(comunitytest, pop!(decktest))
# push!(comunitytest, pop!(decktest))

# handtest = vcat(holetest, comunitytest)


# parttest = partitions(handtest, 2) |> collect
# parts = partitions(COMMUNITYCOMB)

end # module