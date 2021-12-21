

function longest_repeated_substring_T(text, nodes, root, minlen = nothing)

    if isnothing(minlen)
        minlen = 2
    end

    @assert minlen >= 1


    lenlongest = nothing
    ids = []


    strlongest = Dict()
    for nd in nodes

        if nd == root
            continue
        end

        repnode = length(nd.at) > 1
        if repnode
            @assert false
            mylen = nd.pflen + length(nd.s)
        else
            mylen = nd.pflen
        end

        if mylen < minlen
            continue
        end


        if isnothing(lenlongest) || mylen > lenlongest
            lenlongest = mylen
            ids = [nd.parent, nd]


            key = text[nd.sorg:nd.sorg+lenlongest-1]
            empty!(strlongest)
            strlongest[key] = union(Set(nd.parent.at), Set(nd.at))

        elseif mylen == lenlongest
            push!(ids, nd.parent)
            push!(ids, nd)

            key = text[nd.sorg:nd.sorg+lenlongest-1]

            if haskey(strlongest, key)
                union!(strlongest[key], Set(nd.parent.at))
                union!(strlongest[key], Set(nd.at))
            else
                strlongest[key] = union(Set(nd.parent.at), Set(nd.at))
            end

        end

    end


    if isnothing(lenlongest)
        return (nothing, strlongest)
    end

    return (lenlongest, strlongest)
end
