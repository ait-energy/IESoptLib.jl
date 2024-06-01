using IESoptLibrary
using Test
using Aqua
using JET

@testset "IESoptLibrary.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(IESoptLibrary)
    end
    @testset "Code linting (JET.jl)" begin
        JET.test_package(IESoptLibrary; target_defined_modules = true)
    end
    # Write your tests here.
end
