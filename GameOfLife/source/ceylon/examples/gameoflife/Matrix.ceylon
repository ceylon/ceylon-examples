
doc "Represents the Matrix where the game takes place.
     It's a square grid of the specified size."
by "Enrique Zamudio"
shared class Matrix(gridSize) satisfies Iterable<Cell> {
    doc "The number of rows and columns of the Matrix."
    shared Integer gridSize;
    value sb = SequenceBuilder<Cell>();
    for (i in 0..(gridSize*gridSize-1)) {
        sb.append(Cell(i));
    }
    value grid = sb.sequence;

    shared actual Iterator<Cell> iterator =>
        grid.iterator;

    doc "Returns the cells to the left and righ of the cell
         at the specified index."
    shared [Cell,Cell] getLeftRightNeighbors(Integer index) {
        variable value i = index - 1;
        //The cell to the left
        if (index%gridSize == 0) {
            i+=gridSize;
        }
        assert(exists c1 = grid[i]);
        //The cell to the right
        i = index + 1;
        if (i%gridSize == 0) {
            i -= gridSize;
        }
        assert(exists c2 = grid[i]);
        return [c1,c2];
    }

    doc "Returns the 8 cells surrounding the one at
         the specified index."
    shared [Cell+] getNeighbors(Integer index) {
        value sb = SequenceBuilder<Cell>();
        //Left and right
        variable value sameRow = getLeftRightNeighbors(index);
        sb.append(sameRow[0]);
        sb.append(sameRow[1]);
        //The cell above
        variable value i = index - gridSize;
        if (i < 0) {
            i += grid.size;
        }
        if (exists c = grid[i]) {
            sb.append(c);
            sameRow = getLeftRightNeighbors(i);
            sb.append(sameRow[0]);
            sb.append(sameRow[1]);
        }
        //The cell below
        i = index + gridSize;
        if (i >= grid.size) {
            i -= grid.size;
        }
        if (exists c = grid[i]) {
            sb.append(c);
            sameRow = getLeftRightNeighbors(i);
            sb.append(sameRow[0]);
            sb.append(sameRow[1]);
        }
        assert(nonempty r = sb.sequence);
        return r;
    }

    shared void beginEvaluate(void draw(Cell c)) {
        for (c in this) {
            c.evaluateNextState(getNeighbors(c.index));
            draw(c);
        }
    }
    shared void finishEvaluate(void draw(Cell c)) {
        for (c in this) {
            c.evolve();
            draw(c);
        }
    }

    doc "Sets the state of the cell at the specified index."
    shared void setState(Integer index, Boolean state = true) {
        if (exists c = grid[index]) {
            c.state = state;
        }
    }

    doc "Prints the matrix, using dots for dead cells
         and X for living cells."
    shared actual String string {
        value sb = StringBuilder();
        for (c in this) {
            if (c.index > 0 && c.index%gridSize==0) {
                sb.appendNewline();
            }
            sb.append(c.state then "X" else ".");
        }
        return sb.string;
    }

    doc "Resets all the cells to a dead state, then
         sets the cells at the specified indexes to a
         living state."
    shared void init(Integer* values) {
        for (c in grid) {
            c.state=false;
        }
        for (i in values) {
            setState(i);
        }
    }

}
