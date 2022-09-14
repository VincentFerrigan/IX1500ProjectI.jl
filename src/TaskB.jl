#TaskB.jl

module TaskB

function simulate_bpdx(n, k)
    for i in 1:k
        a = Vector{Int64}(undef, n)
        for j in eachindex(a)
            a[j] = rand(1:365)

end

function find_duplicate(a)
    
end

end #module end