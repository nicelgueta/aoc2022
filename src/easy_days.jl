module easy_days

function day1()
    inp::String = open("day1input.txt") do f
        read(f, String)
    end
    a = split(inp, "\r\n\r\n")
    b = [[parse(Int64, i) for i in split(v, "\r\n")] for v in a]
    c = [(i,sum(arr)) for (i,arr) in enumerate(b)]
    filt(x) = x[2]
    sort!(c, by=filt, rev=true)
    curr_i, curr_max = c[1]
    part1 = "1: Elf number: $curr_i carrying $curr_max"

    top3 = sum([x[2] for x in c[1:3]])

    part2 = "2: total sum of top 3: $top3"

    return "$part1\n$part2"

end

function day2()
    shape_score_map = Dict(
        "A"=>1,
        "B"=>2,
        "C"=>3,
        "X"=>1,
        "Y"=>2,
        "Z"=>3,
    )
    beat_map = Dict(
        "A"=>"Z",
        "B"=>"X",
        "C"=>"Y",
        "X"=>"C",
        "Y"=>"A",
        "Z"=>"B"
    )
    inp::String = open("day2input.txt") do f
        read(f, String)
    end
    lines = split(inp, "\n")
    ai_score, our_score = (0,0)
    for letter_comb in lines
        ai, ours = split(letter_comb, " ")
        if beat_map[ai] == ours
            ai_score += 6

        elseif beat_map[ours] == ai
            our_score += 6
        
        else
            our_score += 3
            ai_score += 3
        end

        # add shape scores
        ai_score += shape_score_map[ai]
        our_score += shape_score_map[ours]
    end

    part1 = "Our total score: $our_score" 

    # part 2
    lose_map = Dict(v => k for (k,v) in beat_map)
    ai_score, our_score = (0,0)
    for letter_comb in lines
        ai, outcome = split(letter_comb, " ")
        ai_shape_score = shape_score_map[ai]
        if outcome == "X"
            ai_score += (6 + ai_shape_score)
            our_score += (0 + shape_score_map[beat_map[ai]])
        elseif outcome == "Y"
            ai_score += (3 + ai_shape_score)
            our_score += (3 + ai_shape_score)
        else
            ai_score += ai_shape_score
            our_score += (6 + shape_score_map[lose_map[ai]])
        end
    end
    part2 = "Our total score: $our_score"

    return "$part1\n$part2"
end

function day3()
    inp::String = open("day3input.txt") do f
        read(f, String)
    end
    rucksacks = split(inp, "\n")
    function get_priority(c::Char)
        ord = Int(c)
        if ord < 97
            # is capital
            to_sub = 38
        else
            to_sub = 96
        end
        return ord - to_sub
    end
    priorities_sum = 0
    for sack in rucksacks
        comp1 = sack[1:Int64(length(sack)/2)]
        comp2 = sack[Int64(length(sack)/2) + 1:end]
        for c in comp1
            if c in comp2
                priorities_sum += get_priority(c)
                break
            end
        end
    end

    part1 = "Sum priorities: $priorities_sum"

    # part2
    win_x, win_y = (1,3)
    badge_pri_sum = 0
    while win_y <= length(rucksacks)
        curr_grp = rucksacks[win_x:win_y]
        curr_map = Dict()
        for sack in curr_grp
            dist_sack = Set(sack) # make distinct to find common
            for item in dist_sack
                if item in keys(curr_map)
                    curr_map[item]+=1
                    if curr_map[item] == 3
                        badge_pri_sum+=get_priority(item)
                    end
                else
                    curr_map[item] = 1
                end
            end
        end
        win_x += 3
        win_y += 3
    end
    part2 = "Sum badge priorities: $badge_pri_sum"
    
    return "$part1\n$part2"


end

end # module