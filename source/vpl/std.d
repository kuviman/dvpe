/**
 * Part of the D std library often needed
 *
 * Copyright: © 2014 kuviman
 * License: MIT
 * Authors: kuviman
 */
module vpl.std;

public {
	import std.math;
}

import std.exception : enforce;
import std.algorithm : min, max, swap;
import std.conv : to;
import std.traits : CommonType, TypeTuple, isFloatingPoint, ReturnType, ParameterTypeTuple;
import std.string : toStringz;
import std.array : array, split;
import std.typecons : wrap;
import std.random : uniform, randomShuffle;
import std.string : format;
