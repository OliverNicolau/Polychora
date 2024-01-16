module Polychora

# Using


# Declare

greet() = print("Hello World! What a fine day")

ArithmeticSum(a₁,Δ,n) = return (n+1)*(a₁ + (a₁+n*Δ))/2

SlowSum(a₁,Δ,n) = sum([a₁+Δ*i for i ∈ 0:n])

# Export
export ArithmeticSum

# Includes
#include("Reflections.jl")

end # module Polychora
