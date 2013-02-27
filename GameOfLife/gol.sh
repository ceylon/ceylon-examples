echo Compiling
$CEYLON_HOME/bin/ceylon compile source/ceylon/examples/gameoflife/*.ceylon source/test/examples/gameoflife/*.ceylon source/ceylon/examples/gameoflife/swing/*.ceylon
echo Running tests
$CEYLON_HOME/bin/ceylon run test.examples.gameoflife/1.0.0
echo Running Game of Life
$CEYLON_HOME/bin/ceylon run ceylon.examples.gameoflife/1.0.0 --run=ceylon.examples.gameoflife.swing.run
