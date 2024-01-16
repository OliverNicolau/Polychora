module Polychora

# Using

#using LinearAlgebra, Serialization, Permutations
#using Revise, Test, Plots, Graphs, GraphPlot, GraphRecipes, Statistics # extra libraries
#using NearestNeighbors, DataStructures, LazySets, Polyhedra, MeshCat # even more extra libraries
#using SmithNormalForm, HomotopyContinuation, DelimitedFiles, Ripserer # ...

using CDDLib
using LazySets
using LinearAlgebra
using Plots
using Polyhedra
using Revise
# Declare

A = [1. 1;1 -1;-1 0]
b = [1.2,0,0]
H = Polyhedra.hrep(A, b)

ArithmeticSum(a₁,Δ,n) = return (n+1)*(a₁ + (a₁+n*Δ))/2

# Export
export ArithmeticSum

# Includes
#include("Reflections.jl")

end # module Polychora
