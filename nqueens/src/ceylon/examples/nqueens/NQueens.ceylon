import ceylon.collection { LinkedList }

void run() {

    Integer n = 8;
    Board board = Board(n);

    while (!board.feasible()) {
        board.next();
    }
    print(board);
}

by "Geoffrey De Smet"
shared class Board(Integer n_param) {

    shared Integer n = n_param;
    shared LinkedList<Queen> queens = LinkedList<Queen>();

    for (i in 0..(n-1) ) { // TODO Replace with for (i in 0:n) {
        queens.add(Queen(i));
    }

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
        doc "Impossible to increment further"
        assert (exists queen);

        queen.row++;
        if (queen.row == n) {
            queen.row := 0;
            incrementColumn(index + 1);
        }
    }

    shared String shortString {
        variable String s := "Board(";
        for (queen in queens) {
            s += queen.row.string;
        }
        s += ")";
        return s;
    }

    shared actual String string {
        variable String s := " ";
        for (queen in queens) {
            s += "-";
        }
        s += " \n";
        for (i in 0..(n-1) ) { // TODO Replace with for (i in 0:n) {
            s += "|";
            for (queen in queens) {
                if (queen.row == i) {
                    s += "X";
                } else {
                    s += " ";
                }
            }
            s += "|\n";
        }
        s += " ";
        for (queen in queens) {
            s += "-";
        }
        s += " \n";
        return s;
    }

}

by "Geoffrey De Smet"
shared class Queen(Integer column_param) {

    shared Integer column = column_param;
    shared variable Integer row := 0;

    shared Boolean canAttack(Queen other) {
        return row == other.row
                || ascendingD() == other.ascendingD()
                || descendingD() == other.descendingD();
    }

    Integer ascendingD() {
        return row + column;
    }

    Integer descendingD() {
        return row - column;
    }

    shared actual String string {
        return "Queen(" row ", " column ")";
    }
}
