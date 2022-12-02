module aoc2022

include("easy_days.jl")

using .easy_days

EASY_DAYS = ["day1"]

function julia_main(args)::Cint
    day::String = args[1]
    dayfunc::Function = getfield(easy_days, Symbol(day))
    println(dayfunc())
    return 0 
  end

julia_main(ARGS)

end # module
