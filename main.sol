// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title TruckRacers
 * @author Thanos
 * @notice Simple on-chain truck racing game for two players.
 */
contract TruckRacers {
    uint8 public constant FINISH_LINE = 10;
    uint256 public gameIdCounter;

    enum GameStatus { WaitingForPlayer, InProgress, Finished }

    struct Game {
        address player1;
        address player2;
        mapping(address => uint8) positions;
        address currentTurn;
        GameStatus status;
        address winner;
    }

    mapping(uint256 => Game) public games;

    event GameCreated(uint256 gameId, address player1);
    event PlayerJoined(uint256 gameId, address player2);
    event Moved(uint256 gameId, address player, uint8 newPosition);
    event GameWon(uint256 gameId, address winner);

    function createGame() external returns (uint256) {
        gameIdCounter++;
        Game storage game = games[gameIdCounter];
        game.player1 = msg.sender;
        game.positions[msg.sender] = 0;
        game.status = GameStatus.WaitingForPlayer;

        emit GameCreated(gameIdCounter, msg.sender);
        return gameIdCounter;
    }

    function joinGame(uint256 gameId) external {
        Game storage game = games[gameId];
        require(game.status == GameStatus.WaitingForPlayer, "Game not joinable");
        require(game.player1 != msg.sender, "Can't join your own game");

        game.player2 = msg.sender;
        game.positions[msg.sender] = 0;
        game.currentTurn = game.player1;
        game.status = GameStatus.InProgress;

        emit PlayerJoined(gameId, msg.sender);
    }

    function move(uint256 gameId) external {
        Game storage game = games[gameId];
        require(game.status == GameStatus.InProgress, "Game not active");
        require(msg.sender == game.currentTurn, "Not your turn");

        game.positions[msg.sender] += 1;
        emit Moved(gameId, msg.sender, game.positions[msg.sender]);

        if (game.positions[msg.sender] >= FINISH_LINE) {
            game.status = GameStatus.Finished;
            game.winner = msg.sender;
            emit GameWon(gameId, msg.sender);
            return;
        }

        // Switch turns
        if (msg.sender == game.player1) {
            game.currentTurn = game.player2;
        } else {
            game.currentTurn = game.player1;
        }
    }

    function getPosition(uint256 gameId, address player) external view returns (uint8) {
        return games[gameId].positions[player];
    }

    function getCurrentTurn(uint256 gameId) external view returns (address) {
        return games[gameId].currentTurn;
    }

    function getWinner(uint256 gameId) external view returns (address) {
        return games[gameId].winner;
    }
}
