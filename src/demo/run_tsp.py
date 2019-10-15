import random

import pymzn

MINIZINC_BASE = "/src/minizinc"

number_cities = 10

distance = [
    [
        t1 * t2 for t2 in range(0, number_cities)
    ] for t1 in range(0, number_cities)
]


print("\nSolving .... \n")

solutions = pymzn.minizinc(
    mzn=f"{MINIZINC_BASE}/tsp.mzn",
    data=dict(
        n=len(distance),
        distance=distance
    ),
    solver=pymzn.ORTools(),
    parallel=8,
    keep_solutions=True,
    timeout=60,
)


solution_dict = solutions[-1]


n = solution_dict['next']
i = 1
while True:
    print(f"{i if i == 1 else ' '} -> {n[i - 1]}")
    i = n[i - 1]

    if i == 1:
        break


