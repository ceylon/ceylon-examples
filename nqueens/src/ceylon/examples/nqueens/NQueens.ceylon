
shared void run() {

	doc("Size of the board")
    Integer n = 8;
    Board board = Board(n);

    while (!board.feasible()) {
         board.next();
    }

    //print(board);
    print(board.prettyString);
}

class Board(Integer n) {

	// Initialize board with all queens in row 0
    [Queen*] queens = [ for (i in 0:n) Queen(i) ];

    shared Boolean feasible() {
         for (a in queens) {
            for (b in queens) {
                if (a != b && a.canAttack(b)) {
                    return false;
                }
            }
         }
         return true;
    }

    shared void next() {
        incrementColumn(0);
    }

    void incrementColumn(Integer index) {
        value queen = queens[index];
        doc("Impossible to increment further")
        assert (exists queen);

        queen.row++;
        if (queen.row == n) {
            queen.row = 0;
            incrementColumn(index + 1);
        }
    }

	string => "Board(``{for (q in queens) q.string}``)";

    shared String prettyString {
        value sb = StringBuilder();
        sb.append(" ");
        for (queen in queens) {
            sb.append("-");
        }
        sb.append(" \n");
        for (i in 0:n) {
            sb.append("|");
            for (queen in queens) {
                if (queen.row == i) {
                    sb.append("X");
                } else {
                    sb.append(".");
                }
            }
            sb.append("|\n");
        }
        sb.append(" ");
        for (queen in queens) {
            sb.append("-");
        }
        sb.append(" \n");
        return sb.string;
    }

}


class Queen(shared Integer column) {

    shared variable Integer row = 0;

    shared Boolean canAttack(Queen other) {
        return row == other.row
                || ascendingD == other.ascendingD
                || descendingD == other.descendingD;
    }

    Integer ascendingD => row + column;

    Integer descendingD => row - column;

    string => "(``row``,``column``)";
}
