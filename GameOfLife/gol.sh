echo Compiling
$CEYLON_HOME/bin/ceylon compile source/ceylon/examples/gameoflife/*.ceylon source/test/examples/gameoflife/*.ceylon
echo Running tests
$CEYLON_HOME/bin/ceylon run test.examples.gameoflife/1.0.0
echo Running Game of Life
$CEYLON_HOME/bin/ceylon run ceylon.examples.gameoflife/1.0.0
