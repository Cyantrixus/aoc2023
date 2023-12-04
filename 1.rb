f1 = File.open('1input.txt')

$h = {
    'one' => 'o1e',
    'two' => 't2o',
    'three' => 'tr3ee',
    'four' => 'fo4ur',
    'five' => 'fi5e',
    'six' => 's6x',
    'seven' => 'se7en',
    'eight' => 'ei8ht',
    'nine' => 'ni9ne'
}

def solve(input)
    nums = input.map{|x|x.scan(/\d/)}.map{|x|(x[0] + x[-1]).to_i}
    return nums.sum
end

def replacenums(input)
    input = input.map{|x|x.gsub(Regexp.union($h.keys), $h)}
    input = input.map{|x|x.gsub(Regexp.union($h.keys), $h)}
    return input
end

puts solve(replacenums(f1.readlines.map(&:chomp)))
