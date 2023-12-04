f = File.open('4input.txt')
lines = f.readlines

def solve1(cards)
    cards = cards.map{|x|x.gsub(/Card\s+\d+: /, '').split('|').map(&:split).map{|x|x.map(&:to_i)}}
    points = 0
    cards.each{|x|
        winning = x[0]
        own = x[1]
        winning_nums = own.intersection(winning)

        points += (2**(winning_nums.size-1)).floor
    }

    return points
end

def solve2(cards)
    original_cards = cards.map{|x|x.gsub(/Card\s+\d+: /, '').split('|').map(&:split).map{|x|x.map(&:to_i)}}
    enumerated_cards = []
    original_cards.each_with_index{|x, i|
        enumerated_cards << [i, x]
    }
    total = enumerated_cards.size

    card_turn = one_step(enumerated_cards, enumerated_cards)
    total += card_turn.size

    while card_turn.size > 0
        card_turn = one_step(card_turn, enumerated_cards)
        total += card_turn.size
    end

    return total
end

def one_step(cards, enumerated_cards)
    new_cards = []
    cards.each{|x|
        winning = x[1][0]
        own = x[1][1]
        winning_nums = own.intersection(winning)
        
        i = 0
        winning_nums.each{|j|
            new_cards << enumerated_cards[x[0] + i + 1]
            i += 1
        }
    }
    return new_cards
end

puts solve2(lines)