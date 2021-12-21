"""
    longest_repeated_substrings(t,overlap_allowed)

tests the text t for the existence of longest repeated substrings (LRSs) of length 2 or more and returns: 

- the length of a longest repeated substring in t 
- the set of longest repeated substrings in t
- per LRS a list of its occurences (starting positions). 

If no such strings exists: an empty set is returned and length nothing.

# Arguments

* t: the text (String,Array,Tuple) to find longest repeated substrings in.
* overlap_allowed: whether the occurences of a single LRS may overlap. 



    
# Examples

    longest_repeated_substrings("ananas") == (3, Dict("ana" => [1, 3]))

    longest_repeated_substrings("ananas"; overlap_allowed=false) == (2, Dict("an" => [1, 3], "na" => [2, 4]))




# 
    
    
"""
function longest_repeated_substrings(t; overlap_allowed::Bool = true)

    (nodes, root) = mk_tree(t)

    if overlap_allowed
        lenlongest, strlongest = longest_repeated_substring_T(t, nodes, root)

        return ((lenlongest, Dict(k => sort(collect(v)) for (k, v) in strlongest)))
    else

        lenlongest, strlongest = longest_maximal_repeated_no_overlap_all(t, nodes, root)


        for (s, l) in strlongest
            t = reverse(sort(l))
            last = pop!(t)
            new = [last]

            while length(t) > 0
                p = pop!(t)
                if last + lenlongest <= p
                    push!(new, p)
                    last = p
                end
            end
            strlongest[s] = new
        end

        return (lenlongest, strlongest)
    end

end

