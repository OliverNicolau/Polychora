using Oscar
using Polychora
using Test

@testset "Cyclic Polytope" begin
    @test f_vector(moment_curve_polytope(4,10)) == f_vector(cyclic_polytope(4,10))
    @test is_fvector_neighborly(f_vector(cyclic_polytope(4,10)))
end