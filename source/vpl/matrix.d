module vpl.matrix;

import vpl;

alias matrix!(2, 2, real) mat2;
alias matrix!(3, 3, real) mat3;
alias matrix!(4, 4, real) mat4;

struct matrix(size_t n, size_t m, T = real) {
	enum rows = n, columns = m;

	T[m][n] array;
	private ref get(size_t i, size_t j)() { return array[i][j]; }

	private enum toIdx(size_t i, size_t j) = i * m + j;
	private enum fromIdx(size_t idx) = TypeTuple!(idx / m, idx % m);

	private void isCompMatrixImpl(size_t n1, size_t m1, T2)(matrix!(n1, m1, T2) mat) if (is(T2 : T)) {}
	enum isCompMatrix(T) = is(typeof(isCompMatrixImpl(T.init)));

	private void construct(size_t i, Args...)(Args args) {
		static if (args.length > 0) {
			static assert(i < n * m, "Too many arguments");
			static if (is(Args[0] : T)) {
				get!(fromIdx!i)() = args[0];
				construct!(i + 1)(args[1..$]);
			} else static if (isCompMatrix!(Args[0])) {
				foreach (j; RangeTuple!(Args[0].rows * Args[0].columns))
					get!(fromIdx!(i + j)) = args[0].get!(fromIdx!j);
				construct!(i + Args[0].rows * Args[0].columns)(args[1..$]);
			} else static assert(false);
		} else static assert(i == n * m, "Not enough arguments");
	}
	this(Args...)(Args args) { construct!0(args); }

	auto opIndex(int i, int j) { return array[i][j]; }
	void opIndexAssign(T val, int i, int j) { array[i][j] = val; }
	void opIndexOpAssign(string op, T2)(T2 val, int i, int j) {
		array[i][j].opOpAssign!op(val);
	}

	static if (n == m) {
		private static auto createIdentity() {
			matrix res;
			foreach (i; RangeTuple!n)
				foreach (j; RangeTuple!m)
					res[i, j] = i == j ? 1 : 0;
			return res;
		}
		enum identity = createIdentity();
	}

	static if (n == m && n == 3 && isFloatingPoint!T) {
		static auto createRotation(T angle) {
			auto cs = cos(angle), sn = sin(angle);
			return matrix(cs, -sn, 0, sn, cs, 0, 0, 0, 1);
		}
	}

	static if (n == m) {
		static auto createTranslation(Args...)(Args args) if (Args.length == n - 1) {
			matrix res;
			foreach (i; RangeTuple!n)
				foreach (j; RangeTuple!n) {
					static if (i == j) res[i, j] = 1;
					else static if (j == n - 1) res[i, j] = args[i];
					else res[i, j] = 0;
				}
			return res;
		}
		static auto createScale(Args...)(Args args) if (Args.length == n - 1) {
			matrix res;
			foreach (i; RangeTuple!n)
				foreach (j; RangeTuple!n) {
					static if (i == j) {
						static if (i == n - 1) res[i, j] = 1;
						else res[i, j] = args[i];
					} else res[i, j] = 0;
				}
			return res;
		}
		static auto createScale(T k) {
			matrix res;
			foreach (i; RangeTuple!n)
				foreach (j; RangeTuple!n) {
					static if (i == j) {
						static if (i == n - 1) res[i, j] = 1;
						else res[i, j] = k;
					} else res[i, j] = 0;
				}
			return res;
		}
	}

	static if (n == m && n == 4 && isFloatingPoint!T) {
		static auto createRotation(vector!(3, T) u, T angle) {
			auto cs = cos(angle), sn = sin(angle);
			matrix res;
			foreach (i; RangeTuple!16)
				res.get!(fromIdx!i) = 0;
			foreach (i; RangeTuple!3)
				foreach (j; RangeTuple!3)
					res[i, j] = u.array[i] * u.array[j] * (1 - cs);
			foreach (i; RangeTuple!3)
				res[i, i] += cs;
			res[0, 1] -= u.z * sn;
			res[0, 2] += u.y * sn;
			res[1, 0] += u.z * sn;
			res[1, 2] -= u.x * sn;
			res[2, 0] -= u.y * sn;
			res[2, 1] += u.x * sn;
			res[3, 3] = 1;
			return res;
		}
		static auto createRotation(T ux, T uy, T uz, T angle) {
			return createRotation(vector!(3, T)(ux, uy, uz), angle);
		}
	}

	auto opBinary(string op : "*", size_t k, T2)(matrix!(m, k, T2) other) {
		alias typeof(T.init * T2.init) Tmul;
		alias typeof(Tmul.init + Tmul.init) Tres;
		matrix!(n, k, Tres) res;
		foreach (i; RangeTuple!n)
			foreach (j; RangeTuple!k) {
				res[i, j] = 0; // Not zero in general! ( Tres.init? )
				foreach (t; RangeTuple!m)
					res[i, j] += this[i, t] * other[t, j];
			}
		return res;
	}
}
