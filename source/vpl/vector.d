module vpl.vector;

import vpl;

alias vector!(2, real) vec2;
alias vector!(2, int) vec2i;
alias vector!(3, real) vec3;
alias vector!(3, int) vec3i;
alias vector!(4, real) vec4;
alias vector!(4, int) vec4i;

struct vector(size_t n, T = real) if (n > 0) {
	T[n] array;
	private ref get(size_t i)() { return array[i]; }
	static if (n >= 1) alias get!0 x;
	static if (n >= 2) alias get!1 y;
	static if (n >= 3) alias get!2 z;
	static if (n >= 4) alias get!3 w;

	private void construct(size_t i, Args...)(Args args) {
		static if (args.length > 0) {
			static assert(i < n, "Too many arguments");
			static if (is(Args[0] : T)) {
				array[i] = args[0];
				construct!(i + 1)(args[1..$]);
			} else static assert(false);
		} else static assert(i == n, "Not enough arguments");
	}
	this(Args...)(Args args) { construct!0(args); }

	auto opIndex(size_t i) { return array[i]; }
	void opIndexAssign(T val, size_t i) { array[i] = val; }

	auto opUnary(string op)() if (op == "-" || op == "+") {
		vector!(n, typeof(.opUnary!op(T.init))) res;
		foreach (i; RangeTuple!n)
			res[i] = .opUnary!op(this[i]);
		return res;
	}

	auto opBinary(string op, T2)(vector!(n, T2) other) if (op == "+" || op == "-") {
		vector!(n, typeof(.opBinary!op(T.init, T2.init))) res;
		foreach (i; RangeTuple!n)
			res[i] = .opBinary!op(this[i], other[i]);
		return res;
	}

	auto opBinary(string op, T2)(T2 other) if (op == "*" || op == "/") {
		vector!(n, typeof(.opBinary!op(T.init, T2.init))) res;
		foreach (i; RangeTuple!n)
			res[i] = .opBinary!op(this[i], other);
		return res;
	}
}
