#TaskB.jl

module TaskB

#unfinished method
function simulate_bpdx(n, k)
    for i in 1:k
        hit = 0
        counter = 0
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
end

#unfininished method
function find_duplicate(a)
    key = 1
    for i in eachindex(a)
        if a[key] == a[i+1]
            return true
        end
        key +=1
    end   
end

end #module end