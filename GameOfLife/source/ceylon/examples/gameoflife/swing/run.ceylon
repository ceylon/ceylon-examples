import ceylon.examples.gameoflife { Cell, Matrix }
import javax.swing { ... }
import java.lang { Thread { sleep } }
import java.util { Random }
import java.awt {
	GridLayout,
	Color { black, white, darkGray, lightGray }
}

object matrix extends Matrix(80) {}

JFrame w = JFrame("Game of Life");

void display(JLabel[] labels) {
	void colores1(Cell c) {
		if (exists label=labels[c.index]) {
			if (c.state!=c.nextState) {
				label.background = c.state then darkGray else lightGray;
			}
		}
	}
	void colores2(Cell c) {
		if (exists label=labels[c.index]) {
			label.background = c.state then white else black;
		}
	}
	matrix.beginEvaluate(colores1);
    sleep(10);
    matrix.finishEvaluate(colores2);
    sleep(50);
}

"Run the module `coderetreat.gameoflife`."
void run() {
	value rng = Random(system.milliseconds);
	value layout = GridLayout(matrix.gridSize, matrix.gridSize);
	value sb = SequenceBuilder<JLabel>();
	w.layout  = layout;
	for (c in matrix) {
		value label = JLabel(" ");
		sb.append(label);
		label.opaque = true;
		w.contentPane.add(label);
		c.state = c.index%3==0 then rng.nextBoolean() else false;
		label.background = c.state then white else black;
	}
	value labels = sb.sequence;
	w.pack();
	w.show();
	while (true) {
		display(labels);
	}
}
