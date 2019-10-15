int: n_tracks;

% INPUT
array [1..n_tracks,1..n_tracks] of int: track_distance;

% OUTPUT
array[1..n_tracks] of var 1..n_tracks: track_order;
array[1..n_tracks] of var 0..n_tracks: repeat;

include "globals.mzn";

% Tracks must not repeat
constraint alldifferent(track_order);

% max_distance will be the maximum camelot distance between tracks
var int: max_distance;
constraint max_distance = max (i in 1..n_tracks-1) (track_distance[ track_order[i], track_order[i+1] ]);

% num_repeat_blocks will be the number of times a song is repeated in a block of songs of size MAX_ALLOWED_REPEATS
var int: num_repeat_blocks;
int: MAX_ALLOWED_REPEATS = 5;
constraint forall(i in MAX_ALLOWED_REPEATS..n_tracks) (
    repeat[i] = sum (j in i-MAX_ALLOWED_REPEATS..i-1) (
           bool2int( track_distance[ track_order[i], track_order[j] ] == 0 )
    )
);
constraint num_repeat_blocks = sum(i in 1..n_tracks) (repeat[i]);

% Minimize the track distance and number of repeats between tracks
solve
::int_search(track_distance, first_fail, indomain_min)
minimize max_distance * 10 + num_repeat_blocks;