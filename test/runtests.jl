using IESoptLibrary
using Test
import Aqua
import JET

@testset "IESoptLibrary.jl" verbose = true begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(IESoptLibrary)
    end

    @testset "Code linting (JET.jl)" begin
        JET.test_package(IESoptLibrary; target_defined_modules=true)
    end

    # Write your tests here.
end
