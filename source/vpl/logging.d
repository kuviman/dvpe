/**
 * Logging
 *
 * Examples:
 * ---
 *	log("outer log");
 *	logIndent();
 *	scope(exit) logUnindent();
 *	log("inner 1");
 *	log("inner 2");
 *	log("inner 3");
 * ---
 *
 * Copyright: © 2014 kuviman
 * License: MIT
 * Authors: kuviman
 */
module vpl.logging;

import vpl;

import std.stdio;

private string indent;
private void writeIndent() {
	write(indent);
	stdout.flush();
}

/// Indent log
void logIndent() { indent ~= " "; }
/// Unindent log
void logUnindent() { indent = indent[0 .. $ - 1]; }

/// Log something (almost same as std.stdio.writefln)
void log(T...)(T args) {
	writeIndent();
	writefln(args);
}
