import ceylon.examples.gameoflife { Cell, Matrix }

shared Matrix life = Matrix(20);

doc "Initialize the grid with random values"
shared void init(Integer transitionDelay, Integer stateDelay) {
    dynamic {
        for (c in life) {
                c.state = Math.random() > 0.7;
        }
        void draw1(void f())() {
            life.beginEvaluate(void(Cell c) {
                value td = document.getElementById("c"+c.index.string);
                if (c.state!=c.nextState) {
                    td.setAttribute("class", c.state then "grid2" else "grid3");
                }
            });
            setTimeout(f, transitionDelay);
        }
        void draw2() {
            life.finishEvaluate(void(Cell c) {
                value td = document.getElementById("c"+c.index.string);
                td.setAttribute("class", c.state then "grid4" else "grid");
            });
            setTimeout(draw1(draw2), stateDelay);
        }
        draw1(draw2)();
    }
}
