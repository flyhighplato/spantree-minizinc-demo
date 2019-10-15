% From http://www.dcs.gla.ac.uk/~pat/cpM/minizincCPM/tsp/tsp.mzn
include "globals.mzn";

int: n; % number of cities
array[1..n,1..n] of int: distance;

array[1..n] of var 1..n: next; % next[i] = j <-> visit j immediately after i

var int: cost = sum(i in 1..n)(distance[i,next[i]]);

constraint circuit(next);

solve minimize cost;