import java.lang { Thread { sleep } }
import ceylon.examples.gameoflife { Sleeper }

shared class JavaSleeper() satisfies Sleeper {
    shared actual void sleep(Integer millis) => sleep(millis);
}
