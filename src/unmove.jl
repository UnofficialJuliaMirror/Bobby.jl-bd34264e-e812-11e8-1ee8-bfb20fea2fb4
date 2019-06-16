function update_colors(board::Bitboard)
    board.white = EMPTY
    for P in board.P
        board.white |= P
    end
    for B in board.B
        board.white |= B
    end
    for N in board.N
        board.white |= N
    end
    for Q in board.Q
        board.white |= Q
    end
    for R in board.R
        board.white |= R
    end
    board.white |= board.K

    board.black = EMPTY
    for p in board.p
        board.black |= p
    end
    for bishop in board.b
        board.black |= bishop
    end
    for n in board.n
        board.black |= n
    end
    for q in board.q
        board.black |= q
    end
    for r in board.r
        board.black |= r
    end
    board.black |= board.k

    board.taken = EMPTY
    board.taken |= board.white 
    board.taken |= board.black
    board.free = ~board.taken

    return board
end

function unmove_piece(b, m, color)

    # dopo?
    pop!(b.game)

    if color == "white"
        if m.capture_type != "none"
            if m.capture_type == "pawn"
                b.p = add_to_square(b.p, m.target)
            elseif m.capture_type == "night"
                b.n = add_to_square(b.n, m.target)
            elseif m.capture_type == "bishop"
                b.b = add_to_square(b.b, m.target)
            elseif m.capture_type == "queen"
                b.q = add_to_square(b.q, m.target)
            elseif m.capture_type == "rook"
                b.r = add_to_square(b.r, m.target)
            end
        end

        if m.promotion_type != "none"
            b.P = add_to_square(b.P, m.target)
            if m.promotion_type == "queen"
                b.Q = remove_from_square(b.Q, m.target)
            elseif m.promotion_type == "rook"
                b.R = remove_from_square(b.R, m.target)
            elseif m.promotion_type == "night"
                b.N = remove_from_square(b.N, m.target)
            elseif m.promotion_type == "bishop"
                b.B = remove_from_square(b.B, m.target)
            end
        end

        if m.piece_type == "pawn"
            if m.target == b.enpassant_square
                b.p = add_to_square(b.p, m.target >> 8)
                b.enpassant_done = false
            end
            b.P = update_from_to_squares(b.P, m.target, m.source)
        elseif m.piece_type == "night"
            b.N = update_from_to_squares(b.N, m.target, m.source)
        elseif m.piece_type == "bishop"
            b.B = update_from_to_squares(b.B, m.target, m.source)
        elseif m.piece_type == "queen"
            b.Q = update_from_to_squares(b.Q, m.target, m.source)
        elseif m.piece_type == "rook"
            b.R = update_from_to_squares(b.R, m.target, m.source)
        elseif m.piece_type == "king"
            b.K = update_from_to_squares(b.K, m.target, m.source)
            if m.castling_type != "-"
                if m.castling_type == "K"
                    b.R = update_from_to_squares(b.R, F1, H1)
                elseif m.castling_type == "Q"
                    b.R = update_from_to_squares(b.R, D1, A1)
                end
            end
        end
    else
        if m.capture_type != "none"
            if m.capture_type == "pawn"
                b.P = add_to_square(b.P, m.target)
            elseif m.capture_type == "night"
                b.N = add_to_square(b.N, m.target)
            elseif m.capture_type == "bishop"
                b.B = add_to_square(b.B, m.target)
            elseif m.capture_type == "queen"
                b.Q = add_to_square(b.Q, m.target)
            elseif m.capture_type == "rook"
                b.R = add_to_square(b.R, m.target)
            end
        end

        if m.promotion_type != "none"
            b.p = add_to_square(b.p, m.target)
            if m.promotion_type == "queen"
                b.q = remove_from_square(b.q, m.target)
            elseif m.promotion_type == "rook"
                b.r = remove_from_square(b.r, m.target)
            elseif m.promotion_type == "night"
                b.n = remove_from_square(b.n, m.target)
            elseif m.promotion_type == "bishop"
                b.b = remove_from_square(b.b, m.target)
            end
        end

        if m.piece_type == "pawn"
            if m.target == b.enpassant_square
                b.P = add_to_square(b.P, m.target << 8)
                b.enpassant_done = false
            end
            b.p = update_from_to_squares(b.p, m.target, m.source)
        elseif m.piece_type == "night"
            b.n = update_from_to_squares(b.n, m.target, m.source)
        elseif m.piece_type == "bishop"
            b.b = update_from_to_squares(b.b, m.target, m.source)
        elseif m.piece_type == "queen"
            b.q = update_from_to_squares(b.q, m.target, m.source)
        elseif m.piece_type == "rook"
            b.r = update_from_to_squares(b.r, m.target, m.source)
        elseif m.piece_type == "king"
            b.k = update_from_to_squares(b.k, m.target, m.source)
            if m.castling_type != "-"
                if m.castling_type == "k"
                    b.r = update_from_to_squares(b.r, F8, H8)
                elseif m.castling_type == "q"
                    b.r = update_from_to_squares(b.r, D8, A8)
                end
            end
        end

    end
    return update_colors(b)
end