using Etcetera
using Test

@testset "LongestRepeatedStrings.jl" begin
    
    @test longest_repeated_substrings([9,1,2,3,5,1,2,9]) == (2, Dict([1,2] => [2, 6]))
    
    @test longest_repeated_substrings("ananas") == (3, Dict("ana" => [1, 3]))
    @test longest_repeated_substrings("ananas"; overlap_allowed=false) == (2, Dict("an" => [1, 3], "na" => [2, 4]))

    @test longest_repeated_substrings("Mississippi") == (4, Dict("issi" => [2, 5]))
    @test longest_repeated_substrings("Mississippi"; overlap_allowed=false) == (3, Dict("iss" => [2, 5], "ssi" => [3, 6]))

    

     #=
        only repeating strings longer than 1 are reported.
        
    =#
    @test longest_repeated_substrings("") == (nothing, Dict())
    @test longest_repeated_substrings("a") == (nothing, Dict())
    @test longest_repeated_substrings("aa") == (nothing, Dict())
    
    @test longest_repeated_substrings("aaa") == (2, Dict( "aa" => [1,2]))
    @test longest_repeated_substrings("aaa"; overlap_allowed=false) == (nothing, Dict())
    
    @test longest_repeated_substrings("aaaa") == (3, Dict("aaa" =>[1,2]))
    @test longest_repeated_substrings("aaaa",overlap_allowed=false) == (2, Dict("aa" =>[1,3]))

    @test longest_repeated_substrings("aaaaa",overlap_allowed=false) == (2, Dict("aa" =>[1,3]))

    
    @test longest_repeated_substrings([1, 2, 3, 1, 2, 3]) == (3, Dict([1, 2, 3] => [1, 4]))
    @test longest_repeated_substrings(["one",2,(3,),"one",2,(3,)] ) == (3, Dict(["one", 2, (3,)] => [1, 4]))

end
