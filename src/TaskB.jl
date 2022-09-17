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
        a = Vector{Int64}(1:n)
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
    println(prob)
    return prob
end

function find_duplicate(a)
    l = length(a)
    for i in 1:l-1
        for j in i+1:l
            if a[i] == a[j]
                return true
            end
        end
    end   
    return false
end

q = simulate_bpdx(23, 1000)

println(q)

end #module end