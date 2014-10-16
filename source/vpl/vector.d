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

	private void isCompVectorImpl(size_t m, T2)(vector!(m, T2) vec) if (is(T2 : T)) {}
	enum isCompVector(T) = is(typeof(isCompVectorImpl(T.init)));

	private void construct(size_t i, Args...)(Args args) {
		static if (args.length > 0) {
			static assert(i < n, "Too many arguments");
			static if (is(Args[0] : T)) {
				array[i] = args[0];
				construct!(i + 1)(args[1..$]);
			} else static if (isCompVector!(Args[0])) {
				array[i .. i + Args[0].array.length] = args[0].array[].to!(T[]);
				construct!(i + Args[0].array.length)(args[1..$]);
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

	auto opOpAssign(string op, T2)(T2 other) {
		return this = this.opBinary!op(other);
	}

	static if (n == 2 && isFloatingPoint!T) {
		auto rotate(T angle) {
			T sn = sin(angle), cs = cos(angle);
			return vector!(2, T)(x * cs - y * sn, x * sn + y * cs);
		}
		T arg() {
			return atan2(y, x);
		}
	}

	static if (isFloatingPoint!T) {
		T length() {
			T res = 0;
			foreach (i; RangeTuple!n)
				res += get!i ^^ 2;
			return sqrt(res);
		}
		auto unit() {
			return this / length;
		}
	}
}
