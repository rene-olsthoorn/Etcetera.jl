
export mk_tree

struct Node
    id::Integer
    parent::Union{Node,Nothing}
    sorg::Integer
    tail::Integer
    cplen::Int
    pflen::Int
    extype::Char
    excep::Union{Any,Nothing}
    children::Array{Node,1}
    at
end

function mk_key(node, cplen, extype, excep)
    key = (node, cplen, extype, excep)
    return key
end

"""
    lcp(text,i1,i2)

    Compute the length of the common prefix of text[i1:end] and text[i2:end]

"""
function lcp(text, i1, i2)

    l = 0

    @views for (a, b) in zip(text[i1:end], text[i2:end])

        if a == b
            l += 1
        else
            break
        end
    end

    return l
end


"""
    prefixparts(node)
    
    return list of prefixparts and list of positions
"""
function prefixparts(node)

    pfx = []

    cur = node

    while !isnothing(cur.parent)
        push!(pfx, text[cur.parent.tail:cur.parent.tail*cur.cplen])
        cur = cur.parent
    end

    return reverse(pfx)
end


"""
    mk_tree(text)

    compute a tree with unique prefixes in text
"""
function mk_tree(text)

    function addNode(newnode, key)

        push!(nodes, newnode)

        if !isnothing(parent)
            push!(newnode.parent.children, newnode)
        end

        if !isnothing(key)
            exceptions[key] = newnode
        end

    end

    function get_next(node, cplen, extype, excep)
        key = mk_key(node, cplen, extype, excep)
        get(exceptions, key, nothing)
    end

    """
        add(s,sref)
        
        add the string starting at position s to the tree. ref is e.g. id van string 
    """
    function add(s, sref)

        sorg = s


        next = root  # start with root
        pflen = 0  # length of prefix

        while !isnothing(next)
            cur = next

            if s == cur.tail
                push!(cur.at, sref)
                return
            end

            cplen = lcp(text, cur.tail, s)

            if cplen == 0

                excep = text[s]
                extype = '!'

                next = get_next(cur, cplen, extype, excep)
                if !isnothing(next)
                    continue
                else
                    key = mk_key(cur, cplen, extype, excep)


                    addNode(mk_node(parent = cur, tail = s, sorg = sorg, pflen = (cur.pflen + cplen), cplen = cplen, extype = '!', excep = excep,
                            ref = sref), key)
                    return
                end
            end

            if cplen == (lengt - cur.tail) && (lengt - s) > cplen && cur != root

                s_before = cur.tail

                newnode = mk_node(parent = cur, tail = cur.tail + cplen, sorg = cur.sorg, pflen = (cur.pflen + lengt - s_before),
                    cplen = lengt - s_before, extype = '$', excep = cur.excep)
                newnode.at = cur.at
                cur.tail = s
                cur.ref = sref
                cur.at = [sref]
                cur.sorg = sorg

                extype = '$'
                key = make_key(cur, lengt - s_before, extype, None)
                addNode(newnode, key)
                return
            end

            if (lengt - s) > cplen
                s += cplen
                excep = text[s]
                extype = '!'
            else
                extype = '$'
                excep = nothing
                s = length(text) + 1
            end

            next = get_next(cur, cplen, extype, excep)

            if !isnothing(next)
                continue
            else
                key = mk_key(cur, cplen, extype, excep)
                addNode(
                    mk_node(parent = cur, tail = s, sorg = sorg, pflen = cur.pflen + cplen, cplen = cplen, extype = extype, excep = excep,
                        ref = sref), key)
                return
            end
        end

    end

    nodes = []

    function mk_node(; parent, tail, sorg = nothing, cplen = -1, pflen = -1, extype, excep = nothing, ref = nothing)

        id = 1 + length(nodes)
        node = Node(id, parent, sorg, tail, cplen, pflen, extype, excep, [], isnothing(ref) ? [] : [ref])
        return node
    end

    lengt = length(text)
    root = mk_node(parent = nothing, tail = length(text) + 1, pflen = 0, cplen = 0, sorg = 1, extype = '$')

    nodes = [root]

    exceptions = Dict()

    for (i, c) in enumerate(text)
        add(i, i)
    end


    return (nodes = nodes, root = root)
end

