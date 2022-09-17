#TaskB.jl

module TaskB

function bday_pdx(k)
    a = factorial(big(365))
    b = factorial(big(365-k))
    c = BigInt(365)^k
    return 1-(a/(b*c))
end


function simulate_bpdx(n, k)
    hit = 0
    counter = 0
    for i in 1:k
        a = Vector{Int64}(undef, n)
        for j in eachindex(a)
            a[j] = rand(1:365)
        end
        if find_duplicate(a)
            hit += 1
            counter += 1
        else
            counter += 1
        end
    end
    prob = hit/counter
    return prob
end

function find_duplicate(a)
    for i in eachindex(a)
        for j in eachindex(a)
            k = i + 1
            if !(k >= length(a)) && a[i] == a[k]
                return true
            end
        end
    end   
    return false
end

q = simulate_bpdx(23, 1000000)

println(q)

end #module end