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

	static if (n == m && n == 3) {
		static auto createTranslation(T x, T y) { return matrix(1, 0, x, 0, 1, y, 0, 0, 1); }
		static auto createScale(T x, T y) { return matrix(x, 0, 0, 0, y, 0, 0, 0, 1); }
		static auto createScale(T k) { return matrix(k, 0, 0, 0, k, 0, 0, 0, 1); }
		static if (isFloatingPoint!T) {
			static auto createRotation(T angle) {
				auto cs = cos(angle), sn = sin(angle);
				return matrix(cs, -sn, 0, sn, cs, 0, 0, 0, 1);
			}
		}
	}
}
