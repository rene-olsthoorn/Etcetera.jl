module Etcetera

export longest_repeated_substrings
include("longest_repeated_substrings.jl")

include("longest_repeated.jl")
include("longest_repeated_no_overlap.jl")

module PrefixTree
include("PrefixTree.jl")
end
using .PrefixTree

end
