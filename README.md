:warning: this approach has been discontinued

# Bobby.jl
A mediocre chess engine written in Julia and LaTeX

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

\*nix: [![Build Status](https://travis-ci.org/alemelis/Bobby.jl.svg?branch=master)](https://travis-ci.org/alemelis/Bobby.jl)

[![codecov](https://codecov.io/gh/alemelis/Bobby.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/alemelis/Bobby.jl)

## Idea

Bobby is a chess position classifier. Once running, Bobby will be able to predict a move for any given chess scheme. The predicted move will not be necessarely the best ever, as Bobby is not [Minimax](https://en.wikipedia.org/wiki/Minimax) based. Conversely, we use a supervised-learning approach based on [Convolutional Neural Networks](https://medium.com/technologymadeeasy/the-best-explanation-of-convolutional-neural-networks-on-the-internet-fbb8b1ad5df8) (CNNs). CNNs are tipically used for image recognition and this is exactly how we are using them. Starting from a huge dataset of games, we can generate a 2D image of the chessboard for each move in a game and assign to that image the next move in the game as the target label for learning.

**Hasn't already been done?** sort of...

- CNN _binary_ classifier for position evaluation in Julia [here](http://int8.io/chess-position-evaluation-with-convolutional-neural-networks-in-julia/)
- CNN for reinforcement learning: [AlphaZero](https://www.chess.com/news/view/google-s-alphazero-destroys-stockfish-in-100-game-match) taught itself to play chess :hushed:
- TensorFlow [chessbot](https://github.com/Elucidation/tensorflow_chessbot) trained to recognise pieces from board screenshots

## Install

For training Bobby depends on several additional packages

- Compose.jl
- FileIO.jl
- PyCall.jl
- python-chess
