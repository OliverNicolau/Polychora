module Polychora

# Using

#using LinearAlgebra, Serialization, Permutations
#using Revise, Test, Plots, Graphs, GraphPlot, GraphRecipes, Statistics # extra libraries
#using NearestNeighbors, DataStructures, LazySets, Polyhedra, MeshCat # even more extra libraries

using ProgressBars
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

function moment_curve_polytope(d,n)
    points = [[t^i for i in 1:d] for t in 1:n]
    polytope = convex_hull(points)
    return polytope
end

function rand_box_polytope_exact(d,n)
    polytope = convex_hull(rand(n,d))
    while nvertices(polytope) < n
        polytope = convex_hull(polytope,convex_hull(rand(d)))
    end
    return polytope
end

function parabolic_lift(points::Matrix)
    lift(point) = sum(map((xᵢ) -> (xᵢ-10)^2,point))
    lifted_coordinates = [lift(point) for point in eachrow(points)]
    lifted_points = hcat(points,lifted_coordinates)
    return convex_hull(lifted_points)
end

function parabolic_lift(polytope::Polyhedron)
    points = Matrix(point_matrix(vertices(polytope)))
    return parabolic_lift(points)
end

function random_polytope_test(d = 4, n = 20, rep = 10)
    for iter in 0:rep
        polytope = rand_box_polytope_exact(d,n)
        fvector = f_vector(polytope)
        #println("f⁰ = ", nvertices(polytope))
        #println("fᵈ⁻¹ = ", nfacets(polytope))
        println(fvector)
        println(is_polytope_neighbourly(polytope))
    end
end

function random_convex_lift_test(d = 4, n = 10, rep = 100)
    for iter in 0:rep
        polytope = parabolic_lift(parabolic_lift(rand(n,d-2)))
        if is_polytope_neighbourly(polytope)
            println(vertices(polytope))
        end
    end
end

function cyclic_lift_test(d = 4, max_n = 100)
    test_result = true
    for n in ProgressBar(2:max_n)
        polytope = parabolic_lift(moment_curve_polytope(d-1,n))
        test_result = test_result && is_polytope_neighbourly(polytope)
        if !is_polytope_neighbourly(polytope)
            println(d,n)
            println(vertices(polytope))
        end
    end
    if test_result
        println("All tested cyclic politopes in d-1, lifted to the paraboloid in d, are neighborly")
    end
end

# Export
export random_polytope_test, random_convex_lift_test, cyclic_lift_test
#export moment_curve_polytope, parabolic_lift, is_fvector_neighborly

# Includes
#include("test.jl")

end # module Polychora
