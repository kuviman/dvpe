module vpl.logging;

import vpl;

import std.stdio;

private string indent;
private void writeIndent() {
	write(indent);
}

void logIndent() { indent ~= " "; }
void logUnindent() { indent = indent[0 .. $ - 1]; }

void log(T...)(T args) {
	writeIndent();
	writefln(args);
}
