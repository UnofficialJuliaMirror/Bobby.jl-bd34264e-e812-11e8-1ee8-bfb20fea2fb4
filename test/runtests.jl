using Test
using Bobby

@testset "parser.jl" begin
    include("test_parser.jl")
end

@testset "converters.jl" begin
    include("test_converters.jl")
end

@testset "magic.jl" begin
    include("test_magic.jl")
end

@testset "nights.jl" begin
	include("test_nights.jl")
end

@testset "king.jl" begin
	include("test_king.jl")
end

@testset "rooks.jl" begin
	include("test_rooks.jl")
end

# @testset "bishops.jl" begin
# 	include("test_bishops.jl")
# end

# @testset "queen.jl" begin
# 	include("test_queen.jl")
# end

# @testset "pawns.jl" begin
# 	include("test_pawns.jl")
# end

# @testset "check.jl" begin
#     include("test_check.jl")
# end

# @testset "game.jl" begin
#     include("test_game.jl")
# end

# @testset "bitboard.jl" begin
#     include("test_bitboard.jl")
# end

# @testset "moves.jl" begin
#     include("test_moves.jl")
# end
