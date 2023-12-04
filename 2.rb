f1 = File.open('2test.txt')

$constraints = {
    'red' => 12,
    'green' => 13,
    'blue' => 14
}

def solve1(input)
    input = input.map{|x|x.split(':')}
    input = input.map{|x|[x[0].split[1], validate(x[1].split(';'))]}
    return input.inject(0){|s, i|i[1] ? s + i[0].to_i : s}
end

def validate(round)
    parsed = round.map{|x|x.split(',').map{|y|y.split(/\s+/)}.map{|z|[z[1].to_i, z[2]]}}
    b = true
    parsed.each{|turn|
        turn.each{|x|
            if x[0] > $constraints[x[1]]
                b = false
            end
        }
    }
    return b
end

def solve2(input)
    input = input.map{|x|x.split(':')}
    input = input.map{|x|count(x[1].split(';'))}
    return input.sum
end

def count(game)
    parsed = game.map{|x|x.split(',').map{|y|y.split(/\s+/)}.map{|z|[z[1].to_i, z[2]]}}
    counts = {
        'red' => 0,
        'blue' => 0,
        'green' => 0
    }
    parsed.each{|round|
        round.each{|x|
            if counts[x[1]] < x[0]
                counts[x[1]] = x[0]
            end
        }
    }
    return counts['red'] * counts['blue'] * counts['green']
end

puts solve2(f1.readlines)
