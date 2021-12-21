

function longest_maximal_repeated_no_overlap_all(text, nodes, root, minlen = nothing)

    if isnothing(minlen)
        minlen = 2
    end

    @assert minlen >= 1



    lenlongest = nothing
    ids = []


    #strlongest = Dict{Any,Array{Integer,1}}()   
    strlongest = Dict()

    tovisit = [nd for nd in nodes if !isnothing(nd.children) || length(nd.at) > 1]

    for nd in tovisit

        if nd == root
            continue
        end

        repnode = length(nd.at) > 1
        if repnode
            @assert False # should not happen now as all strings differ
            mylen = nd.pflen + self.lengt - nd.tail

        else
            if length(nd.children) > 0
                maxcplen = maximum(child.cplen for child in nd.children)
            else
                maxcplen = 0
            end
            mylen = nd.pflen + maxcplen
        end


        if mylen < minlen
            continue
        end

        if !isnothing(lenlongest) && mylen < lenlongest

            continue
        end


        loci = collect(nd.at)

        found = false
        for i in range(mylen, 1, step = -1)

            newkids = [child for child in nd.children if child.cplen == i]

            newloci = []
            for child in newkids
                append!(newloci, child.at)
            end


            append!(loci, newloci)
            sort!(loci)

            p0 = loci[1]
            p1 = loci[end]
            nonlap = p1 - p0 >= i
            if nonlap

                mylen = i
                found = true
                break
            end

        end

        if !found
            continue  # next node
        end

        if mylen < minlen
            continue
        end



        if isnothing(lenlongest) || mylen > lenlongest
            lenlongest = mylen
            ids = [nd]
            empty!(strlongest)
            key = text[nd.sorg:nd.sorg+lenlongest-1]

            strlongest[key] = collect(loci)

        elseif mylen == lenlongest
            push!(ids, nd)
            key = text[nd.sorg:nd.sorg+lenlongest-1]
            if haskey(strlongest, key)
                append!(strlongest[key], loci)
            else
                strlongest[key] = collect(loci)
            end
        else
            # nd is smaller
        end
    end


    return (lenlongest, strlongest)
end
