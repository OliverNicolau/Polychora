module Polychora

# Using

#using LinearAlgebra, Serialization, Permutations
#using Revise, Test, Plots, Graphs, GraphPlot, GraphRecipes, Statistics # extra libraries
#using NearestNeighbors, DataStructures, LazySets, Polyhedra, MeshCat # even more extra libraries

using Oscar
using Revise

# Declare

function StarSum(d,n)
    T(i) = 2*binomial(n-d-1+i,i)
    if iseven(d)
        return sum([T(i) for i in 0:d÷2-1]) + T(d÷2)÷2
    else
        return sum([T(i) for i in 0:d÷2])
    end
end

function is_fvector_neighborly(fvector)
    # f_{d-1} = \sum_{i=0}^{{\lfloor d/2 \rfloor}_*} 2\binom{n-d-1+i}{i}
    d = size(fvector,1)
    f⁰ = Int(fvector[begin])
    fᵈ⁻¹ = Int(fvector[end])
    return fᵈ⁻¹ == StarSum(d,f⁰)
end

function is_polytope_neighbourly(polytope)
    return is_fvector_neighborly(f_vector(polytope))
end

function moment_curve_polytope(d = 4, n = 10)
    points = [[t^i for i in 1:d] for t in 1:n]
    polytope = convex_hull(points)
    return polytope
end

function random_polytope_test(d = 4, n = 20)
    for rep in 0:10
        polytope = rand_box_polytope(d, n, 1)
        while nvertices(polytope) < n
            polytope = convex_hull(polytope,convex_hull(rand(d)))
        end
        fvector = f_vector(polytope)
        if is_fvector_neighborly(fvector) || true
            #println("f⁰ = ", nvertices(polytope))
            #println("fᵈ⁻¹ = ", nfacets(polytope))
            println(fvector)
            println(is_polytope_neighbourly(polytope))
        end
    end
end

# Export
export random_polytope_test, moment_curve_polytope, is_fvector_neighborly

# Includes
#include("Reflections.jl")

end # module Polychora
