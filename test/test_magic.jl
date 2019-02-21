@testset "slide rank" begin
    sr = Bobby.slide_rank(Bobby.EMPTY, 0x0000002000000000, Bobby.MASK_RANK_5)
    slr = [0,0,0,0,0,0,0,0,
           0,0,0,0,0,0,0,0,
           0,0,0,0,0,0,0,0,
           1,1,0,1,1,1,1,1,
           0,0,0,0,0,0,0,0,
           0,0,0,0,0,0,0,0,
           0,0,0,0,0,0,0,0,
           0,0,0,0,0,0,0,0]
    @test all(Int.(Bobby.cvt_to_bitarray(sr[1])) .== slr)

    sr = Bobby.slide_rank(Bobby.EMPTY, 0x0000002000000000,
            Bobby.MASK_RANK_6)
    @test all(Int.(Bobby.cvt_to_bitarray(sr[1])) .== Int.(
        Bobby.cvt_to_bitarray(Bobby.EMPTY)))


    # same_color = falses(8)
    # same_color[6] = true
    # other_color = falses(8)
    # other_color[2] = true
    # rook_pos = 4
    # rook_valid_gt1 = [0, 1, 1, 0, 1, 0, 0, 0]
    # rook_valid_array1 = Bobby.slidePiece(same_color, other_color, rook_pos)
    # @test all(Int.(rook_valid_array1) .== rook_valid_gt1)

    # same_color = falses(8)
    # same_color[6] = true
    # other_color = falses(8)
    # rook_pos = 1
    # rook_valid_gt2 = [0, 1, 1, 1, 1, 0, 0, 0]
    # rook_valid_array2 = Bobby.slidePiece(same_color, other_color, rook_pos)
    # @test all(Int.(rook_valid_array2) .== rook_valid_gt2)

    # same_color = falses(8)
    # other_color = falses(8)
    # other_color[6] = true
    # rook_pos = 1
    # rook_valid_gt3 = [0, 1, 1, 1, 1, 1, 0, 0]
    # rook_valid_array3 = Bobby.slidePiece(same_color, other_color, rook_pos)
    # @test all(Int.(rook_valid_array3) .== rook_valid_gt3)

    # same_color = falses(8)
    # same_color[1] = true
    # other_color = falses(8)
    # other_color[8] = true
    # rook_pos = 2
    # rook_valid_gt4 = [0, 0, 1, 1, 1, 1, 1, 1]
    # rook_valid_array4 = Bobby.slidePiece(same_color, other_color, rook_pos)
    # @test all(Int.(rook_valid_array4) .== rook_valid_gt4)

    # same_color = falses(8)
    # other_color = falses(8)
    # other_color[2] = true
    # other_color[4] = true
    # rook_pos = 7
    # rook_valid_gt5 = [0, 0, 0, 1, 1, 1, 0, 1]
    # rook_valid_array5 = Bobby.slidePiece(same_color, other_color, rook_pos)
    # @test all(Int.(rook_valid_array5) .== rook_valid_gt5)

    # same_color = falses(8)
    # other_color = falses(8)
    # rook_pos = 5
    # rook_valid_gt6 = [1, 1, 1, 1, 0, 1, 1, 1]
    # rook_valid_array6 = Bobby.slidePiece(same_color, other_color, rook_pos)
    # @test all(Int.(rook_valid_array6) .== rook_valid_gt6)

    # same_color = trues(8)
    # same_color[2] = false
    # other_color = falses(8)
    # rook_pos = 8
    # rook_valid_gt7 = [0, 0, 0, 0, 0, 0, 0, 0]
    # rook_valid_array7 = Bobby.slidePiece(same_color, other_color, rook_pos)
    # @test all(Int.(rook_valid_array7) .== rook_valid_gt7)
end