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

end # module