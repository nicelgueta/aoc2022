module aoc2022

include("first_days.jl")

using .first_days

function julia_main(args)::Cint
    day::String = args[1]
    dayfunc::Function = getfield(first_days, Symbol(day))
    println(dayfunc())
    return 0 
  end

julia_main(ARGS)

end # module
