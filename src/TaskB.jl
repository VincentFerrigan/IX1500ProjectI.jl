#TaskB.jl

module TaskB

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

A = [1, 2, 3, 4, 7, 8]

println(find_duplicate(A))

end #module end