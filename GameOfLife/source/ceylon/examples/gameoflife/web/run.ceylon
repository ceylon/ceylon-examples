import ceylon.examples.gameoflife { Cell, Matrix }

shared Matrix life = Matrix(20);

"Initialize the grid with random values"
shared void init(Integer transitionDelay, Integer stateDelay) {
    dynamic {
        for (c in life) {
                c.state = \iMath.random() > 0.7;
        }
        dynamic ctx = document.getElementById("grid").getContext("2d");
        ctx.fillRect(0,0,300,300);
        void draw1(void f())() {
            life.beginEvaluate(void(Cell c) {
                if (c.state!=c.nextState) {
                    ctx.fillStyle = c.state then "#800000" else "#c00000";
                    ctx.fillRect(c.index%life.gridSize * 15, c.index/life.gridSize * 15, 15, 15);
                }
            });
            setTimeout(f, transitionDelay);
        }
        void draw2() {
            life.finishEvaluate(void(Cell c) {
                ctx.fillStyle= c.state then "#ff0000" else "#000000";
                ctx.fillRect(c.index%life.gridSize * 15, c.index/life.gridSize * 15, 15, 15);
            });
            setTimeout(draw1(draw2), stateDelay);
        }
        draw1(draw2)();
    }
}
