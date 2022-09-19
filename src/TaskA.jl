# TaskA.jl
# - Julia version: 1.8.0
# - Author: Vincent Ferrigan <ferrigan@kth.se>
# - Course code: KTH/ICT:IX1500 - Discrete Mathematics, ht22 
# - Assignment: Project 1
# - Date: 2022-09-18
# - Version: 0.7

# istället för att hasfunktionerna avläser 7 kort så kan den 
# ta emot två vectorer. ..en hole och en community(?)
# måste holekorten alltid räknas in? båda eller en?

module TaskA
using Combinatorics
using Random
import Base.show
import Base.==

export Card, fulldeck, preflop!, preflop_combinations, 
flop!, flop_combinations, handcollections, prob_df, prob_df!,
hasonepair, hastwopairs, hasthreeofakind, hasstraight, 
hasflush, hasfullhouse, hasfourofakind,
hasstraightflush, hasroyalstraightflush, collectionofhands

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

function hasonepair(cards)
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
    
"""
preflop!(deck)
modifies deck and returns holecards
"""
function preflop!(deck)
	# deck = TaskA.fulldeck()
	holecards = Vector(undef, 0)
	push!(holecards, popat!(deck, rand(1:size(deck)[1])))
	push!(holecards, popat!(deck, rand(1:size(deck)[1])))
    return holecards
end

function preflop_combinations(holecards, deck)
    communitycomb = combinations(deck, 5) |> collect
    # throw two random cards
    foreach(x -> popat!(x, rand(1:size(communitycomb[1])[1])), communitycomb)
	foreach(x -> popat!(x, rand(1:size(communitycomb[1])[1])), communitycomb)
    preflophandcomb = map(x -> vcat(x, holecards), communitycomb)
    preflop_hands = handcollections(preflophandcomb)
    return preflop_hands
end

"""
flop(deck)
receives a deck of 50 cards
modifies deck and returns a vector of three community cards
"""
function flop!(deck)
    threecommcards = Vector(undef, 0)
	push!(threecommcards, popat!(deck, rand(1:size(deck)[1])))
	push!(threecommcards, popat!(deck, rand(1:size(deck)[1])))
	push!(threecommcards, popat!(deck, rand(1:size(deck)[1])))
    return threecommcards
end

function flop_combinations(holecards, threecommcards, deck)
    communitycomboftwo = combinations(deck, 2) |> collect
    communitycombflop = map(x -> vcat(x, threecommcards), communitycomboftwo)
    
    # throw two random cards away
	foreach(x -> popat!(x, rand(1:size(communitycombflop[1])[1])), communitycombflop)
	foreach(x -> popat!(x, rand(1:size(communitycombflop[1])[1])), communitycombflop)
    flophandcomb = map(x -> vcat(x, holecards), communitycombflop)
    flop_hands = handcollections(flophandcomb)
    return flop_hands
end


# Collectionfunctions

function handcollections(handcomb)
    predict = Dict(
        :onepair => filter(x -> hasonepair(x), handcomb),
        :twopairs => filter(x -> hastwopairs(x), handcomb),
        :threeofakind => filter(x -> hasthreeofakind(x), handcomb),
        :straight => filter(x -> hasstraight(x), handcomb),
        :flush => filter(x -> hasflush(x), handcomb),
        :fullhouse => filter(x -> hasfullhouse(x), handcomb),
        :fourofakind => filter(x -> hasfourofakind(x), handcomb),
        :straightflush => filter(x -> hasstraightflush(x), handcomb),
        :royalstraightflush => filter(x -> hasroyalstraightflush(x), handcomb)
        )
	OP = predict[:onepair]
	TP = predict[:twopairs]
	TK = predict[:threeofakind]
	S = predict[:straight]
	F = predict[:flush]
	FH = predict[:fullhouse]
	FK = predict[:fourofakind]
	SF = predict[:straightflush]
	RSF = predict[:royalstraightflush]
      
	dict = Dict(
		# onepair ∖ twopair ∖ threeofakind
		"One Pair" 	=> setdiff(OP, TP, TK),
		# twopair ∖ fullhouse
		"Two Pairs"	=> setdiff(TP, FH),
		# threeofakind ∖ fourofakind ∖ fullhouse
		"Three of a kind" => setdiff(TK, FK, FH),
		# straight ∖ straightflush
		"Straight" => setdiff(S, SF),
		# flush ∖ straightflush
		"Flush"	=> setdiff(F, SF),
		"Full house" => FH,
		"Four of a kind" => FK,
		# straightflush ∖ royalstraightflush
		"Straight Flush" => setdiff(SF, RSF),
		"Royal Straight Flush" => RSF
)
	return dict
end

#df

function prob_df!(df, handcombinations, n, k)
    sizeof = x-> size(x)[1]
    probof = x-> size(x)[1]/binomial(n,k)
    
    df.:name => keys(handcombinations) |> collect
	df.:sets => values(handcombinations) |> collect
	df.:freq => values(handcombinations) |> x -> sizeof.(x) |> collect
	df.:prob => values(handcombinations) |> x -> probof.(x) |> collect

end
function prob_df(handcombinations, n, k)
    sizeof = x-> size(x)[1]
    probof = x-> size(x)[1]/binomial(n,k)
    
    df = DataFrame(
	:name => keys(handcombinations) |> collect,
	:sets => values(handcombinations) |> collect,
	:freq => values(handcombinations) |> x -> sizeof.(x) |> collect,
	:prob => values(handcombinations) |> x -> probof.(x) |> collect
    )
    return df
end
# helpfunctions to mapping
# sizeofset = x-> size(x)[1]
# probofset52_5 = x-> size(x)[1]/binomial(52,5)
# probofset50_5 = x-> size(x)[2]/binomil(50,5)
# probofset50_3 = x-> size(x)[2]/binomial(50,3)
# probofset47_2 = x-> size(x)[2]/binomial(47,2)

# gamla men som jag de facto använder
# collections
const HOLECOMB = combinations(fulldeck(), 2) |> collect
const COMMUNITYCOMB = combinations(fulldeck(), 3) |> collect 
const HANDCOMB = combinations(fulldeck(), 5) |> collect 

# Collectionfunctions
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
# hrsf = filter(x -> hasroyalstraightflush(x), HANDCOMB)

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