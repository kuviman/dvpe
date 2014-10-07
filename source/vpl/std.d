module vpl.std;

public {
	import std.math;
}

import std.algorithm : min, max;
import std.conv : to;
import std.traits : CommonType, TypeTuple, isFloatingPoint;
import std.string : toStringz;
import std.array : array, split;
import std.typecons : wrap;

import std.random : uniform, randomShuffle;
auto random(T)(T lf, T rg) {
	return uniform(lf, rg);
}
auto randomInc(T)(T lf, T rg) {
	return uniform!"[]"(lf, rg);
}

template RangeTuple(int from, int to) {
	static if (from >= to)
		alias TypeTuple!() RangeTuple;
	else
		alias TypeTuple!(from, RangeTuple!(from + 1, to)) RangeTuple;
}
alias RangeTuple(int n) = RangeTuple!(0, n);

auto opBinary(string op, T1, T2)(T1 v1, T2 v2) { return mixin("v1 " ~ op ~ " v2"); }
auto opUnary(string op, T)(T val) { return mixin(op ~ " val"); }
