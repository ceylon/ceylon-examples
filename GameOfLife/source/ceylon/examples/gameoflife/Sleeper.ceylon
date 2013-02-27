doc "A simple abstraction of a platform-dependent delay mechanism"
by  "Enrique Zamudio"
shared interface Sleeper {
    shared formal void sleep(Integer millis);
}
