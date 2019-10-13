pragma solidity 0.5.11;
contract TicTacToe {

    address player1;
    address player2;
    uint turn;
    uint winners;
    uint[] board = new uint[](9);

    constructor TicTacToe ( address p2 ) public {
        player1 = msg.sender;
        player2 = p2;
        turn = 1;
    }

    function kill() public {
        if (msg.sender == player1 && winners>0) {
            selfdestruct(player1);
        }
    }

    function myTurn() public view returns(bool) {
        return (msg.sender == player1 && turn == 1) || (msg.sender == player2 && turn == 2) ;
    }

    function subCheckWin(uint a, uint b, uint c) private view returns (bool){
        return board[a]>0 && board[a]==board[b] && board[b]==board[c];
    }

    function checkWin() private view returns (uint) {
        for (uint i = 0; i < 3; i++) {
            if (subCheckWin(i,3+i,6+i)) {
                return board[i];
            }
            if (subCheckWin(3*i,3*i+1,3*i+2)) {
                return board[3*i];
            }
        }
        if (subCheckWin(0,4,8)) {
            return board[0];
        }
        if (subCheckWin(2,4,6)) {
            return board[2];
        }
        if (board[0]+board[1]+board[1]+board[1]+board[1]+board[1]+board[1]+board[1]+board[1] == 13){
            return 3;
        }
        return 0;
    }

    function winner() public view returns (uint) {
        if (winners>0) {
            return winners;
        } else {
            return 0;
        }
    }

    function validMove(uint a) public view returns (bool) {
        return !(winners>0 || a<0 || a>8 || board[a]>0) &&
                ((msg.sender == player1 && turn==1) || (msg.sender == player2 && turn==2));
    }

    function play(uint a) public {
        if (validMove(a)) {
            board[a] = turn;
            if (turn==1) {
                turn = 2;
            } else {
                turn = 1;
            }
            winners = checkWin();
        } else {
            revert();
        }
    }

    function displayBoard() public view returns(uint[]) {
        return board;
    }
}
