function change_color(color::String)
    if color == "white"
        return "black"
    else
        return "white"
    end
end

function play(player_color="white")
    b = buildBoard()
    l = buildLookUpTables()
    color = "white"
    opponent_color = "black"

    while true
        Bobby.prettyPrint(b, player_color)
        println("$color to move, enter source square and press enter")
        source = readline()
        if source == "q"
            break
        end
        println("enter target square and press enter")
        target = readline()
        try
            b, e = move(b, l, source, target, color)
            if e != ""
                @printf(Crayon(bold=true, foreground=:yellow), "\n%s ", e)
                @printf(Crayon(reset=true), "\n")
                continue
            end
        catch er
            @printf(Crayon(bold=true, foreground=:yellow), "\n%s ", er)
            @printf(Crayon(reset=true), "\n")
            continue
        end

        if checkCheck(b, opponent_color)
            if checkMate(b, l, opponent_color)
                @printf(Crayon(bold=true, foreground=:red), "\n%s ",
                    "check mate!")
                @printf(Crayon(reset=true), "\n")
                Bobby.prettyPrint(b)
                break
            else
                @printf(Crayon(bold=true, foreground=:red), "\n%s ",
                    "$opponent_color is in check!")
                @printf(Crayon(reset=true), "\n")
            end
        end

        color, opponent_color = changeColor(color, opponent_color)

    end
end


function changeColor(color::String, opponent_color::String)
    tmp_color = opponent_color
    opponent_color = color
    color = tmp_color
    return color, opponent_color
end




function move(board::Bitboard, lu_tabs::LookUpTables, source::String,
    target::String, color::String="white")
    
    try
        # convert pgn to integer
        s = pgn2int(source)
        t = pgn2int(target)

        # find piece type to move
        s_piece_type = int2piece(board, s)

        checkSource(s, board)

        # check piece color
        checkColor(s_piece_type, color)

        # find valid moves
        validators = Dict()
        validators['k'] = getKingValid
        validators['p'] = getPawnsValid
        validators['q'] = getQueenValid
        validators['b'] = getBishopsValid
        validators['r'] = getRooksValid
        validators['n'] = getNightsValid
        valid_moves = validators[lowercase(s_piece_type)](board, lu_tabs, color)

        # check valid destination
        checkTarget(t, valid_moves)

        # check if the move leads to auto-check
        movers = Dict()
        movers['k'] = moveKing
        movers['p'] = movePawn
        movers['q'] = moveQueen
        movers['b'] = moveBishop
        movers['r'] = moveRook
        movers['n'] = moveNight
        tmp_b = deepcopy(board)
        tmp_b = movers[lowercase(s_piece_type)](tmp_b, s, t, color)

        if checkPromotion(s_piece_type, target)
            promotion = "promote"
        else
            promotion = ""
        end

        board = updateAttacked(tmp_b, lu_tabs, color)
        board = updateCastling(board)

        return board, promotion
    catch e
        return board, e
    end
end


function move(board::Bitboard, lu_tabs::LookUpTables, s::Int64,
    t::Int64, color::String="white")

    if color == "white"
        if board.K[s]
            board = moveKing(board, s, t, color)
        elseif board.P[s]
            board = movePawn(board, s, t, color)
        elseif board.R[s]
            board = moveRook(board, s, t, color)
        elseif board.N[s]
            board = moveNight(board, s, t, color)
        elseif board.Q[s]
            board = moveQueen(board, s, t, color)
        else
            board = moveBishop(board, s, t, color)
        end
    else
        if board.k[s]
            board = moveKing(board, s, t, color)
        elseif board.p[s]
            board = movePawn(board, s, t, color)
        elseif board.r[s]
            board = moveRook(board, s, t, color)
        elseif board.n[s]
            board = moveNight(board, s, t, color)
        elseif board.q[s]
            board = moveQueen(board, s, t, color)
        else
            board = moveBishop(board, s, t, color)
        end
    end

    board = updateAttacked(board, lu_tabs, color)
    board = updateCastling(board)

    return board, ""
end


function checkPromotion(s_piece_type::Char, target::String)
    if lowercase(s_piece_type) != 'p'
        return false
    else
        if target[2] == '8'
            return true
        else
            return false
        end
    end
end


function checkSource(source_idx::Int64, board::Bitboard)
    if board.free[source_idx]
        throw(DomainError("empty source square"))
    end
end


function checkTarget(target_idx::Int64, valid_moves::BitArray{1})
    if !valid_moves[target_idx]
        throw(DomainError("target square not available"))
    end
end


function checkColor(s_piece_type::Char, color::String="white")
    if color == "white"
        if !isuppercase(s_piece_type)
            throw(ErrorException("it's white to move!"))
        end
    else
        if isuppercase(s_piece_type)
            throw(ErrorException("it's black to move!"))
        end
    end
end


function pgn2int(square::String)
    if length(square) != 2
        throw(DomainError("square name must be long 2"))
    end

    file = square[1]
    if !( file in "abcdefgh")
        throw(DomainError("the file should be in {a, ..., h}"))
    end
    f = Int(file) - 96

    rank = square[2]
    try
        rank = parse(Int, rank)
    catch err
        throw(ArgumentError("the rank should be an Int"))
    end

    if !( rank >= 1 && rank <= 8)
        throw(DomainError("the rank shoudl be in {1, ..., 8}"))
    end

    return f + (8 - rank)*8
end


function int2piece(board::Bitboard, idx::Int64)
    if board.free[idx]
        return ' '
    elseif board.K[idx]
        return 'K'
    elseif board.P[idx]
        return 'P'
    elseif board.Q[idx]
        return 'Q'
    elseif board.B[idx]
        return 'B'
    elseif board.N[idx]
        return 'N'
    elseif board.R[idx]
        return 'R'
    elseif board.k[idx]
        return 'k'
    elseif board.p[idx]
        return 'p'
    elseif board.q[idx]
        return 'q'
    elseif board.b[idx]
        return 'b'
    elseif board.n[idx]
        return 'n'
    elseif board.r[idx]
        return 'r'
    end
end


function playPC(player_color="white")
    b = Bobby.buildBoard()
    l = Bobby.buildLookUpTables()

    color = "white"
    opponent_color = "black"

    while true
        Bobby.prettyPrint(b, player_color)

        good_moves = getAllMoves(b, l, color)

        println("$color to move, enter source square and press enter")
        source = readline()
        if source == "q"
            break
        end
        println("enter target square and press enter")
        target = readline()

        try
            s = pgn2int(source)
            t = pgn2int(target)

            if ~((s, t) in good_moves)
                @printf(Crayon(bold=true, foreground=:yellow), "\nInvalid move! Try again ")
                @printf(Crayon(reset=true), "\n")
                continue
            end
        catch er
            @printf(Crayon(bold=true, foreground=:yellow), "\n%s ", er)
            @printf(Crayon(reset=true), "\n")
            continue
        end

        b, e = move(b, l, source, target, color)

        if checkCheck(b, opponent_color)
            if checkMate(b, l, opponent_color)
                @printf(Crayon(bold=true, foreground=:red), "\n%s ",
                    "check mate!")
                @printf(Crayon(reset=true), "\n")
                Bobby.prettyPrint(b)
                break
            else
                @printf(Crayon(bold=true, foreground=:red), "\n%s ",
                    "$opponent_color is in check!")
                @printf(Crayon(reset=true), "\n")
            end
        end

        color, opponent_color = changeColor(color, opponent_color)

        good_moves = getAllMoves(b, l, color)
        if length(good_moves) == 0
            println("!!!!!")
        end

        ri = rand(1:length(good_moves))
        i = 1
        for m in good_moves
            if i == ri
                move(b, l, m[1], m[2], color)
                break
            else
                i += 1
            end
        end

        if checkCheck(b, opponent_color)
            if checkMate(b, l, opponent_color)
                @printf(Crayon(bold=true, foreground=:red), "\n%s ",
                    "check mate!")
                @printf(Crayon(reset=true), "\n")
                Bobby.prettyPrint(b)
                break
            else
                @printf(Crayon(bold=true, foreground=:red), "\n%s ",
                    "$opponent_color is in check!")
                @printf(Crayon(reset=true), "\n")
            end
        end

        color, opponent_color = changeColor(color, opponent_color)
        Bobby.prettyPrint(b, player_color)
    end
end