int: n_tracks;

% INPUT
array [1..n_tracks,1..n_tracks] of int: track_distance;

% OUTPUT
array[1..n_tracks] of var 1..n_tracks: track_order;
array[1..n_tracks] of var 0..n_tracks: repeat;

include "globals.mzn";

constraint alldifferent(track_order);

var int: max_distance;
constraint max_distance = max (i in 1..n_tracks-1) (track_distance[ track_order[i], track_order[i+1] ]);


int: MAX_ALLOWED_REPEATS = 5;
constraint forall(i in MAX_ALLOWED_REPEATS..n_tracks) (
    repeat[i] = sum (j in i-MAX_ALLOWED_REPEATS..i-1) (
           bool2int(track_distance[ track_order[i], track_order[j] ] == 0)
    )
);

var int: num_repeat_blocks;
constraint num_repeat_blocks = sum(i in 1..n_tracks) (repeat[i]);

solve
::int_search(track_distance, first_fail, indomain_min)
minimize max_distance * 10 + num_repeat_blocks;