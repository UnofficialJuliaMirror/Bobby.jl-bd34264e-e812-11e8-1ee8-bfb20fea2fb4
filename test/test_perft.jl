@testset "perft1" begin
	b = Bobby.set_board()
	pt = Bobby.perft(b, 3, b.player_color)
	@test pt == [20, 400, 8902]
end
# @testset "perft2" begin
# 	b = Bobby.fen_to_bitboard(
# 		"r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R3K2R w KQkq - 1 1")
# 	pt = Bobby.perft(b, 3, b.player_color)
# 	@test pt == [48, 2039, 97862]
# end
# @testset "perft3" begin
# 	b = Bobby.fen_to_bitboard(
# 		"8/2p5/3p4/KP5r/1R3p1k/8/4P1P1/8 w - - 1 1")
# 	pt = Bobby.perft(b, 3, b.player_color)
# 	@test pt == [14, 191, 2812]
# end
# @testset "perft4" begin
# 	b = Bobby.fen_to_bitboard(
# 		"r3k2r/Pppp1ppp/1b3nbN/nP6/BBP1P3/q4N2/Pp1P2PP/R2Q1RK1 w kq - 0 1")
# 	pt = Bobby.perft(b, 3, b.player_color)
# 	@test pt == [6, 264, 9467]
# end
# @testset "perft4.1" begin
# 	b = Bobby.fen_to_bitboard(
# 		"r2q1rk1/pP1p2pp/Q4n2/bbp1p3/Np6/1B3NBn/pPPP1PPP/R3K2R b KQ - 0 1")
# 	pt = Bobby.perft(b, 3, b.player_color)
# 	@test pt == [6, 264, 9467]
# end
# @testset "perft5" begin
# 	b = Bobby.fen_to_bitboard(
# 		"rnbq1k1r/pp1Pbppp/2p5/8/2B5/8/PPP1NnPP/RNBQK2R w KQ - 1 8")
# 	pt = Bobby.perft(b, 3, b.player_color)
# 	@test pt == [44, 1486, 62379]
# end
@testset "perft6" begin
	b = Bobby.fen_to_bitboard(
		"r4rk1/1pp1qppp/p1np1n2/2b1p1B1/2B1P1b1/P1NP1N2/1PP1QPPP/R4RK1 w - - 0 10")
	pt = Bobby.perft(b, 3, b.player_color)
	@test pt == [46, 2079, 89890]
end