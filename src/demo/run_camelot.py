import random

import pymzn

MINIZINC_BASE = "/src/minizinc"

camelot_tracks = [
    f"{random.randint(1, 12)}{('A' if random.randint(0, 1) == 1 else 'B')}" for _ in range(0, 20)
]

print(f"Input: {camelot_tracks}")


def dist(t1, t2):
    pos1 = int(t1[:-1])
    pos2 = int(t2[:-1])

    wheel1 = 0 if t1[-1] == 'A' else 1
    wheel2 = 0 if t2[-1] == 'A' else 1

    return min(abs(pos2-pos1), 12-abs(pos2-pos1)) + abs(wheel2-wheel1)


camelot_distance = [
    [
        dist(t1, t2) for t2 in camelot_tracks
    ] for t1 in camelot_tracks
]

print("\nSolving .... \n")

solutions = pymzn.minizinc(
    mzn=f"{MINIZINC_BASE}/camelot_minimize.mzn",
    data=dict(
        n_tracks=len(camelot_tracks),
        track_distance=camelot_distance
    ),
    solver=pymzn.ORTools(),
    parallel=8,
    #output_objective=True,
    keep_solutions=True,
    #rebase_arrays=False,
    #pre_passes=1,
    #keep=True,
    timeout=60,
    #output_mode='raw'
)

#print(solutions)

solution_dict = dict()
if isinstance(solutions, str):
    for s in solutions.splitlines(False):
        if not s.startswith("%"):
            solution_dict.update(**pymzn.dzn2dict(s))
else:
    solution_dict = solutions[-1]

print(solution_dict)
track_order = solution_dict['track_order']
track_solution = [camelot_tracks[i - 1] for i in track_order]
print(f"Output: {track_solution}")
#print(f"Max track distance: {solution_dict['max_distance']}")


