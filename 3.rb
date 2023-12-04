file = File.open('3input.txt')

lines = file.readlines

def padgrid(lines)
    padded = []
    padded << '.'*(lines[0].size+1)
    lines.each{|x|
        padded << '.' + x.chomp + '.'
    }
    padded << '.'*(lines[0].size+1)
    return padded
end

def solve1(l)
    symbols = []
    l.each_with_index{|line, y|
        line.chars.each_with_index{|c, x|
            symbols << {'ch' => c, 'x' => x, 'y' => y} if c.match(/[^.0-9]/)
        }
    }
    digits = []
    symbols.each{|sym|
        (-1..1).each{|i|
            (-1..1).each{|j|
                c = l[sym['y']+i][sym['x']+j]
                digits << {'ch' => c, 'x' => sym['x']+j, 'y' => sym['y']+i} if c.match(/\d/)
            }
        }
        
    }
    digits = digits.uniq
    
    numbers = []
    taken = []
    digits.each{|digit|
        if not taken.include?(digit)
            i = 0
            concatenated = ''
             # check left
            while l[digit['y']][digit['x'] + i].match(/\d/) and not taken.include?(l[digit['y']][digit['x'] + i])
                newdigit = l[digit['y']][digit['x'] + i]

                taken << {'ch' => newdigit, 'x' => digit['x'] + i, 'y' => digit['y']}
                concatenated = newdigit + concatenated

                i -= 1
            end
            i = 1
            # check right
            while l[digit['y']][digit['x'] + i].match(/\d/) and not taken.include?(l[digit['y']][digit['x'] + i])
                newdigit = l[digit['y']][digit['x'] + i]

                taken << {'ch' => newdigit, 'x' => digit['x'] + i, 'y' => digit['y']}
                concatenated = concatenated + newdigit 

                i += 1
            end
            numbers << concatenated.to_i
        end
    }
    return numbers.sum
end

def solve2(l)
    symbols = []
    l.each_with_index{|line, y|
        line.chars.each_with_index{|c, x|
            symbols << {'ch' => c, 'x' => x, 'y' => y} if c.match(/\*/)
        }
    }
    
    digits = []
    symbols.each{|sym|
        (-1..1).each{|i|
            (-1..1).each{|j|
                c = l[sym['y']+i][sym['x']+j]
                digits << {'ch' => c, 'x' => sym['x']+j, 'y' => sym['y']+i, 'sym' => sym} if c.match(/\d/)
            }
        }
    }
    digits = digits.uniq

    gear_ratios = []

    digits.group_by{|x|x['sym']}.each{|k, v|
        numbers = []
        taken = []
        v.each{|digit|
            digit = {'ch' => digit['ch'], 'x' => digit['x'], 'y' => digit['y']}

            if not taken.include?(digit)
                i = 0
                concatenated = ''
                # check left
                while l[digit['y']][digit['x'] + i].match(/\d/) and not taken.include?(l[digit['y']][digit['x'] + i])
                    newdigit = l[digit['y']][digit['x'] + i]

                    taken << {'ch' => newdigit, 'x' => digit['x'] + i, 'y' => digit['y']}
                    concatenated = newdigit + concatenated

                    i -= 1
                end
                i = 1
                # check right
                while l[digit['y']][digit['x'] + i].match(/\d/) and not taken.include?(l[digit['y']][digit['x'] + i])
                    newdigit = l[digit['y']][digit['x'] + i]

                    taken << {'ch' => newdigit, 'x' => digit['x'] + i, 'y' => digit['y']}
                    concatenated = concatenated + newdigit 

                    i += 1
                end
                numbers << concatenated.to_i
            end
        }
        gear_ratios << numbers.reduce(:*) if numbers.size == 2
    }
    
    return gear_ratios.sum
end

puts solve2(padgrid(lines))