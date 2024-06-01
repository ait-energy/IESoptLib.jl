using IESoptLib
using Test
import Aqua
import JET

@testset "IESoptLib.jl" verbose = true begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(IESoptLib)
    end

    @testset "Code linting (JET.jl)" begin
        JET.test_package(IESoptLib; target_defined_modules=true)
    end

    # Write your tests here.
end
