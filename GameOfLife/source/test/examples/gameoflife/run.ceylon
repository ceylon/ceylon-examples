import ceylon.examples.gameoflife { Matrix, Cell }

Matrix m3 = Matrix(3);
Matrix m5 = Matrix(5);

void noop(Cell c) {}

void eval(Matrix m, Integer* values) {
	m.init(*values);
	m.evaluate(noop, noop);
}

doc "Run the module `test.examples.gameoflife`."
void run() {
	check(m3.sequence.size == 9, "Matrix of incorrect size [1]");
	check(m5.sequence.size == 25, "Matrix of incorrect size [2]");
	eval(m3, 0);
	check(m3.every((Cell c) => !c.state), "All dead 1");
	eval(m3, 0, 1);
	check(m3.every((Cell c) => !c.state), "All dead 2");
	eval(m3, 0, 1, 2);
	check(m3.every((Cell c) => c.state), "All living");
	eval(m3, 0,1,2,3,4,5,6,7,8);
	check(m3.every((Cell c) => !c.state), "All dead 3");
	eval(m3, 0,2,4,6,8);
	check(m3.every((Cell c) => !c.state), "All dead 4");
	eval(m3, 1,3,5,7);
	check(m3.skipping(1).by(2).every((Cell c) => c.state), "Diamond");
	eval(m3, 1,3,4,5,7);
	check(m3.every((Cell c) => !c.state), "All dead");

	eval(m5, 6, 8, 12, 16, 18);
	print(m5);
	//Print the results
	print("Assertions: ``assertions`` failures: ``fails``");
}

variable Integer assertions=0;
variable Integer fails=0;

shared void check(Boolean expr, String msg="") {
	if (expr){
		assertions++;
	} else {
		print("*****FAIL!!!! " + msg);
		fails++;
	}
}
