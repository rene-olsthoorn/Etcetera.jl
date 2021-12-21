# Etcetera

Etcetera is a package that contains a function to find the longest repeated substrings  in a text. "text" can be a string,tuple or array. It returns a tuple with the length of such a string and a dictionary with these strings as keys. The corresponding value is a list of the occurrences of the key.


Sometimes there is only one substring that is the longest.

    longest_repeated_substrings("ananas") == (3, Dict("ana" => [1, 3]))

In this case it is "ana" with lenght 3 and 2 occurrences, starting at positions 1 and 3.
These  occurrences overlap. If you want non-overlapping  occurrences:

    longest_repeated_substrings("ananas"; overlap_allowed=false) == (2, Dict("an" => [1, 3], "na" => [2, 4]))

Note that now the occurrences for one given string, say "an", do not overlap. 
Between different strings there still can be overlap, like here: "an" starting at 1 overlaps with "na" at 2.

Only strings of length 2 or longer are considered:

    longest_repeated_substrings("aa") == (nothing, Dict())

An example with array:

    longest_repeated_substrings([9,1,2,3,5,1,2,9]) == (2, Dict([1,2] => [2, 6]))

And a little bit weird example:

    longest_repeated_substrings(["one",2,(3,),"one",2,(3,)] ) == (3, Dict(["one", 2, (3,)] => [1, 4]))



[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://rene-olsthoorn.github.io/Etcetera.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://rene-olsthoorn.github.io/Etcetera.jl/dev)
[![Build Status](https://github.com/rene-olsthoorn/Etcetera.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/rene-olsthoorn/Etcetera.jl/actions/workflows/CI.yml?query=branch%3Amain)
