import ceylon.examples.gameoflife { Cell, Matrix }

shared Matrix life = Matrix(20);

doc "Initialize the grid with random values"
shared void init() {
    for (c in life) {
        dynamic {
            value cell = document.getElementById("c"+c.index.string);
            c.state = c.index%3==0 then (Math.random() > 0.5) else false;
        }
    }
    draw();
}

shared void draw() {
    dynamic {
        void colores1(Cell c) {
            value td = document.getElementById("c"+c.index.string);
            if (c.state!=c.nextState) {
                td.setAttribute("class", c.state then "grid2" else "grid3");
            }
        }
        void colores2(Cell c) {
            value td = document.getElementById("c"+c.index.string);
            td.setAttribute("class", c.state then "grid4" else "grid");
        }
        life.evaluate(colores1, colores2);
    }
}
