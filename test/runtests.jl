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

    @testset "IESoptLib.jl (basic)" verbose = true begin
        path_iesoptlib = abspath(dirname(pathof(IESoptLib)))

        @test relpath(get_path(:addons), path_iesoptlib) == "addons"
        @test relpath(get_path(:examples), path_iesoptlib) == "examples"
        @test relpath(get_path(:templates), path_iesoptlib) == "templates"

        @test_throws ArgumentError get_path(:other)

        n = "01_basic_single_node"
        @test get_filename(:example, n) == joinpath(get_path(:examples), "$(n).iesopt.yaml")
        # TODO: test addons & templates

        @test_throws ArgumentError get_filename(:other, n)
    end
end
