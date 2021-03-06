/**
 * vpl
 *
 * Almost standard library
 *
 * Copyright: © 2014 kuviman
 * License: MIT
 * Authors: kuviman
 */
module vpl;

public {
	import vpl.std;
	import vpl.logging;
	import vpl.vector;
	import vpl.matrix;
}

/// Math sign function
auto sign(T)(T val) {
	if (val < 0) return -1;
	if (val > 0) return +1;
	return 0;
}

/**
 * Clamp the value between minimal and maximal values
 * Returns:
 *	minVal if val < minVal,
 *	maxVal if val > maxVal,
 *	val otherwise
 */
auto clamp(T)(T val, T minVal, T maxVal) {
	if (val < minVal) return minVal;
	if (val > maxVal) return maxVal;
	return val;
}

/// Get a random number
auto random(T : bool)() {
	return randomInc!int(0, 1) == 1;
}
/// ditto
auto random(T)(T lf, T rg) {
	return uniform(lf, rg);
}
/// Get a random number including both ends
auto randomInc(T)(T lf, T rg) {
	return uniform!"[]"(lf, rg);
}

/// TypeTyple (from .. to)
template RangeTuple(int from, int to) {
	static if (from >= to)
		alias TypeTuple!() RangeTuple;
	else
		alias TypeTuple!(from, RangeTuple!(from + 1, to)) RangeTuple;
}
/// ditto
alias RangeTuple(int n) = RangeTuple!(0, n);

/// opBinary common function (v1 op v2)
auto opBinary(string op, T1, T2)(T1 v1, T2 v2) { return mixin("v1 " ~ op ~ " v2"); }
/// opUnary common function (op val)
auto opUnary(string op, T)(T val) { return mixin(op ~ " val"); }
/// opOpAssign common function (a op= b)
auto opOpAssign(string op, T1, T2)(ref T1 a, T2 b) { return mixin("a " ~ op ~ "= b"); }

/// import data as a byte[] instead of string
template importBinary(string path) {
	const byte[] importBinary = cast(const byte[]) import(path);
}

template subst(string s) {
	private string substImpl(string s) {
		size_t i = 0;
		string fs = "";
		string[] args;
		while (i < s.length) {
			if (s[i] == '$') {
				size_t j = i + 1;
				assert(s[j] == '(');
				j++;
				int d = 1;
				string curArg = "";
				while (d > 0) {
					if (s[j] == '(') d++;
					if (s[j] == ')') d--;
					if (d > 0)
						curArg ~= s[j];
					j++;
				}
				args ~= curArg;
				i = j;
				fs ~= "%s";
			} else {
				fs ~= s[i];
				i++;
			}
		}
		string argString = "";
		foreach (j, arg; args) {
			if (j > 0) argString ~= ", ";
			argString ~= arg;
		}
		string res = "\"%s\".format(%s)".format(fs, argString);
		return res;
	}
	enum subst = substImpl(s);
}

int getBit(int x, int i) {
	return (x >> i) & 1;
}
