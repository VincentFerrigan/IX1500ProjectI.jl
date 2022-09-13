module IX1500ProjectI
import Base.show

export Card, Deck, Hand, fulldeck, getsuit, getcolor, getrank



# constants
const RANKS = Set([:ace, :two, :three, :four, :five, :six, :seven, :eight,
                :nine, :ten, :jack, :queen, :king])
const SUITS = Set([:♣, :♢, :♡, :♠])

# types
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

# caVrd = Card(:ace, :♡)
# show(card)
# println(card)

struct Deck
    cards::Vector{Card}
    function Deck(cards::Vector{Card})
        new(cards)
    end
end

struct Hand
    cards::Vector{Card} # or a set?
    function Hand(cards::Vector{Card})
        size(cards)[1] == 2|| throw(ArgumentError("only two hands per cards"))
        new(cards)
    end
    # Or should we use tuples or sets instead???????
    # cards::Set{Card}
    # function Hand(cards::Set{Card})
    #     length(cards) != 2 || throw(ArgumentError("only two hands per cards"))
    #     new(cards)
    # end
end

# utils

function fulldeck() 
    return Card[Card(rank, suit) for suit in SUITS for rank in RANKS]
end

getsuit(card::Card) = card.suit
getrank(card::Card) = card.rank
function getcolor(card::Card)
    if card.suit == ♣  ||  card.suit == ♠
        return :black
    else
        return :red
    end
end

function Base.show(io::IO, card::Card)
    print(io, card.rank)
    print(io, card.suit)
end

# function Base.show(io::IO, hands::Hand)
#     for cards in hand.cards
#         print(card)
#     end
# end
        

end # module
