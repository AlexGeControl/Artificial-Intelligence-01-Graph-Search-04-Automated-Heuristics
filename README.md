# Planning Search for Air Cargo Transport System

## Synopsis

In this project, a planning search agent is developed to solve deterministic logistics planning problems for an Air Cargo transport system.

However, unlike the navigation problem for Pacman, there is no simple distance heuristic to aid the agent.

Here domain-independent heuristics like ignoring preconditions heuristic and planning graph heuristic will be implemented and compared.

![Progression air cargo search](images/Progression.PNG)

## Problems Overview

Here all the three problems are in the Air Cargo domain.  They have the same action schema defined, but different initial states and goals.

### Action Schema

- Air Cargo Action Schema:
```
Action(
    Load(c, p, a),
    PRECOND: At(c, a) ∧ At(p, a) ∧ Cargo(c) ∧ Plane(p) ∧ Airport(a)
    EFFECT: ¬ At(c, a) ∧ In(c, p)
)
Action(
    Unload(c, p, a),
    PRECOND: In(c, p) ∧ At(p, a) ∧ Cargo(c) ∧ Plane(p) ∧ Airport(a)
    EFFECT: At(c, a) ∧ ¬ In(c, p)
)
Action(
    Fly(p, from, to),
    PRECOND: At(p, from) ∧ Plane(p) ∧ Airport(from) ∧ Airport(to)
    EFFECT: ¬ At(p, from) ∧ At(p, to)
)
```

### Problem Definitions

- Problem 1 initial state and goal:
```
Init(
    At(C1, SFO) ∧ At(C2, JFK) ∧ 
    At(P1, SFO) ∧ At(P2, JFK) ∧ 
    Cargo(C1) ∧ Cargo(C2) ∧ 
    Plane(P1) ∧ Plane(P2) ∧ 
    Airport(JFK) ∧ Airport(SFO)
)
Goal(
    At(C1, JFK) ∧ At(C2, SFO)
)
```
- Problem 2 initial state and goal:
```
Init(
    At(C1, SFO) ∧ At(C2, JFK) ∧ At(C3, ATL) ∧ 
    At(P1, SFO) ∧ At(P2, JFK) ∧ At(P3, ATL) ∧ 
    Cargo(C1) ∧ Cargo(C2) ∧ Cargo(C3) ∧ 
    Plane(P1) ∧ Plane(P2) ∧ Plane(P3) ∧ 
    Airport(JFK) ∧ Airport(SFO) ∧ Airport(ATL)
)
Goal(
    At(C1, JFK) ∧ At(C2, SFO) ∧ At(C3, SFO)
)
```
- Problem 3 initial state and goal:
```
Init(
    At(C1, SFO) ∧ At(C2, JFK) ∧ At(C3, ATL) ∧ At(C4, ORD) ∧ 
    At(P1, SFO) ∧ At(P2, JFK) ∧ 
    Cargo(C1) ∧ Cargo(C2) ∧ Cargo(C3) ∧ Cargo(C4) ∧ 
    Plane(P1) ∧ Plane(P2) ∧ 
    Airport(JFK) ∧ Airport(SFO) ∧ Airport(ATL) ∧ Airport(ORD)
)
Goal(
    At(C1, JFK) ∧ At(C3, JFK) ∧ At(C2, SFO) ∧ At(C4, SFO)
)
```

## Problem Representation

### Representation in Python

All the three problems are represented in Python script <a href="my_air_cargo_problems.py">my_air_cargo_problems.py</a> as follows:

**Problem 1**
```python
def air_cargo_p1():
    """ Implementation of air cargo transport problem 1

        Init(
            At(C1, SFO) ∧ At(C2, JFK) ∧
            At(P1, SFO) ∧ At(P2, JFK) ∧
            Cargo(C1) ∧ Cargo(C2) ∧
            Plane(P1) ∧ Plane(P2) ∧
            Airport(JFK) ∧ Airport(SFO)
        )

        Goal(
            At(C1, JFK) ∧ At(C2, SFO)
        )
    """
    cargos = ['C1', 'C2']
    planes = ['P1', 'P2']
    airports = ['JFK', 'SFO']

    pos = [
        expr('At(C1, SFO)'),
        expr('At(C2, JFK)'),
        expr('At(P1, SFO)'),
        expr('At(P2, JFK)')
    ]
    neg = [
        expr('At(C1, JFK)'),
        expr('In(C1, P1)'),
        expr('In(C1, P2)'),

        expr('At(C2, SFO)'),
        expr('In(C2, P1)'),
        expr('In(C2, P2)'),

        expr('At(P1, JFK)'),

        expr('At(P2, SFO)')
    ]

    init = FluentState(pos, neg)

    goal = [
        expr('At(C1, JFK)'),
        expr('At(C2, SFO)')
    ]

    return AirCargoProblem(
        cargos,
        planes,
        airports,
        init,
        goal
    )
```

**Problem 2**
```python
def air_cargo_p2():
    """ Implementation of air cargo transport problem 1

        Init(
            At(C1, SFO) ∧ At(C2, JFK) ∧ At(C3, ATL) ∧
            At(P1, SFO) ∧ At(P2, JFK) ∧ At(P3, ATL) ∧
            Cargo(C1) ∧ Cargo(C2) ∧ Cargo(C3) ∧
            Plane(P1) ∧ Plane(P2) ∧ Plane(P3) ∧
            Airport(JFK) ∧ Airport(SFO) ∧ Airport(ATL)
        )
        Goal(
            At(C1, JFK) ∧ At(C2, SFO) ∧ At(C3, SFO)
        )
    """
    cargos = ['C1', 'C2', 'C3']
    planes = ['P1', 'P2', 'P3']
    airports = ['SFO', 'JFK', 'ATL']

    pos = [
        expr('At(C1, SFO)'),
        expr('At(C2, JFK)'),
        expr('At(C3, ATL)'),

        expr('At(P1, SFO)'),
        expr('At(P2, JFK)'),
        expr('At(P3, ATL)')
    ]
    neg = [
        expr('At(C1, JFK)'),
        expr('At(C1, ATL)'),

        expr('In(C1, P1)'),
        expr('In(C1, P2)'),
        expr('In(C1, P3)'),

        expr('At(C2, SFO)'),
        expr('At(C2, ATL)'),

        expr('In(C2, P1)'),
        expr('In(C2, P2)'),
        expr('In(C2, P3)'),

        expr('At(C3, SFO)'),
        expr('At(C3, JFK)'),

        expr('In(C3, P1)'),
        expr('In(C3, P2)'),
        expr('In(C3, P3)'),

        expr('At(P1, JFK)'),
        expr('At(P1, ATL)'),

        expr('At(P2, SFO)'),
        expr('At(P2, ATL)'),

        expr('At(P2, JFK)'),
        expr('At(P2, ATL)')
    ]

    init = FluentState(pos, neg)

    goal = [
        expr('At(C1, JFK)'),
        expr('At(C2, SFO)'),
        expr('At(C3, SFO)'),
    ]

    return AirCargoProblem(
        cargos,
        planes,
        airports,
        init,
        goal
    )
```

**Problem 3**
```python
def air_cargo_p3():
    """ Implementation of air cargo transport problem 1

        Init(
            At(C1, SFO) ∧ At(C2, JFK) ∧ At(C3, ATL) ∧ At(C4, ORD) ∧
            At(P1, SFO) ∧ At(P2, JFK) ∧
            Cargo(C1) ∧ Cargo(C2) ∧ Cargo(C3) ∧ Cargo(C4) ∧
            Plane(P1) ∧ Plane(P2) ∧
            Airport(JFK) ∧ Airport(SFO) ∧ Airport(ATL) ∧ Airport(ORD)
        )
        Goal(
            At(C1, JFK) ∧ At(C2, SFO) ∧ At(C3, JFK) ∧ At(C4, SFO)
        )
    """
    cargos = ['C1', 'C2', 'C3', 'C4']
    planes = ['P1', 'P2']
    airports = ['SFO', 'JFK', 'ATL', 'ORD']

    pos = [
        expr('At(C1, SFO)'),
        expr('At(C2, JFK)'),
        expr('At(C3, ATL)'),
        expr('At(C4, ORD)'),

        expr('At(P1, SFO)'),
        expr('At(P2, JFK)'),
    ]
    neg = [
        expr('At(C1, JFK)'),
        expr('At(C1, ATL)'),
        expr('At(C1, ORD)'),

        expr('In(C1, P1)'),
        expr('In(C1, P2)'),

        expr('At(C2, SFO)'),
        expr('At(C2, ATL)'),
        expr('At(C2, ORD)'),

        expr('In(C2, P1)'),
        expr('In(C2, P2)'),

        expr('At(C3, SFO)'),
        expr('At(C3, JFK)'),
        expr('At(C3, ORD)'),

        expr('In(C3, P1)'),
        expr('In(C3, P2)'),

        expr('At(C4, SFO)'),
        expr('At(C4, JFK)'),
        expr('At(C4, ATL)'),

        expr('In(C4, P1)'),
        expr('In(C4, P2)'),

        expr('At(P1, JFK)'),
        expr('At(P1, ATL)'),
        expr('At(P1, ORD)'),

        expr('At(P2, SFO)'),
        expr('At(P2, ATL)'),
        expr('At(P2, ORD)')
    ]

    init = FluentState(pos, neg)

    goal = [
        expr('At(C1, JFK)'),
        expr('At(C2, SFO)'),
        expr('At(C3, JFK)'),
        expr('At(C4, SFO)')
    ]

    return AirCargoProblem(
        cargos,
        planes,
        airports,
        init,
        goal
    )
```

### Optimal Sequence for Each Problem

Detailed solution sequences can be found inside <a href="run_part_1.log">run_part_1.log</a> and <a href="run_part_2.log">run_part_2.log</a>.

The optimal sequences attained by using a star search with planning graph level sum heuristic is as follows:

**Problem 1** Optimal cost is **6**.
| ID |        Action       |
|:--:|:-------------------:|
|  1 |  Load(C1, P1, SFO)  |
|  2 |  Fly(P1, SFO, JFK)  |
|  3 |  Load(C2, P2, JFK)  |
|  4 |  Fly(P2, JFK, SFO)  |
|  5 | Unload(C2, P2, SFO) |
|  6 | Unload(C1, P1, JFK) |

**Problem 2** Optimal cost is **9**
| ID |        Action       |
|:--:|:-------------------:|
|  1 |  Load(C2, P2, JFK)  |
|  2 |  Fly(P2, JFK, ATL)  |
|  3 |  Load(C3, P2, ATL)  |
|  4 |  Fly(P2, ATL, SFO)  |
|  5 |  Load(C1, P1, SFO)  |
|  6 |  Fly(P1, SFO, JFK)  |
|  7 | Unload(C3, P2, SFO) |
|  8 | Unload(C2, P2, SFO) |
|  9 | Unload(C1, P1, JFK) |

**Problem 3** Optimal cost is **12**
| ID |        Action       |
|:--:|:-------------------:|
|  1 |  Load(C2, P2, JFK)  |
|  2 |  Fly(P2, JFK, ORD)  |
|  3 |  Load(C4, P2, ORD)  |
|  4 |  Fly(P2, ORD, SFO)  |
|  5 |  Load(C1, P1, SFO)  |
|  6 |  Fly(P1, SFO, ATL)  |
|  7 |  Load(C3, P1, ATL)  |
|  8 |  Fly(P1, ATL, JFK)  |
|  9 | Unload(C4, P2, SFO) |
| 10 | Unload(C3, P1, JFK) |
| 11 | Unload(C2, P2, SFO) |
| 12 | Unload(C1, P1, JFK) |

## Automated Heuristics

### Ignore-Preconditions Heuristic

Ignore-preconditions heuristic is implemented in <a href="my_air_cargo_problems.py">my_air_cargo_problems.py</a> as follows:
```python
@lru_cache(maxsize=8192)
def h_ignore_preconditions(self, node: Node):
    """This heuristic estimates the minimum number of actions that must be
       carried out from the current state in order to satisfy all of the goal
       conditions by ignoring the preconditions required for an action to be
       executed.
    """
    # return the number of unsatisfied goals as heuristic cost
    count = 0

    kb = PropKB()
    kb.tell(decode_state(node.state, self.state_map).pos_sentence())
    for clause in self.goal:
        if clause not in kb.clauses:
            count += 1
	    
    return count
```

### Planning Graph Level-Sum Heuristic

Level-sum heuristic from planning graph is implemented in <a href="my_planning_graph.py">my_planning_graph.py</a>
```python
def h_levelsum(self):
    """The sum of the level costs of the individual goals (admissible if goals independent)

    :return: int
    """
    level_sum = 0
    
    # for each goal in the problem, determine the level cost, then add them together
    for goal in self.problem.goal:
        # identify the shallowest level containing current goal state:
        for level, state_level in enumerate(self.s_levels):
            # extract state fingerprints:
            states = set(state.symbol for state in state_level if state.is_pos)
            if goal in states:
                level_sum += level
                break

    return level_sum
```

## Performance Comparison

### Uninformed Algorithms

The following three uninformed algorithms are evaluated and their corresponding KPIs are as follows:

| Problem |           Name           | Is Optimal | Time Elapsed | Node Expansions | Goal Tests | New Nodes |
|:-------:|:------------------------:|:----------:|:------------:|:---------------:|:----------:|:---------:|
|    1    |   Breadth First Search   |    True    |    0.0284    |        43       |     56     |    180    |
|    2    |   Breadth First Search   |    True    |    3.8321    |       1855      |    2582    |   14801   |
|    3    |   Breadth First Search   |    True    |    37.3692   |      14120      |    17673   |   124926  |
|    1    | Depth First Graph Search |    False   |    0.0124    |        21       |     22     |     84    |
|    2    | Depth First Graph Search |    False   |    0.3721    |       184       |     185    |    1143   |
|    3    | Depth First Graph Search |    False   |     1.081    |       292       |     293    |    2388   |
|    1    |    Uniform Cost Search   |    True    |    0.03170   |        55       |     57     |    224    |
|    2    |    Uniform Cost Search   |    True    |    5.4067    |       2724      |    2726    |   21377   |
|    3    |    Uniform Cost Search   |    True    |    45.4621   |      18223      |    18225   |   159618  |

### Algorithms using Automated Heuristics

The following three automated heuristics for a-star search are evaluated and their corresponding KPIs are as follows

| Problem |              Name              | Is Optimal | Time Elapsed | Node Expansions | Goal Tests | New Nodes |
|:-------:|:------------------------------:|:----------:|:------------:|:---------------:|:----------:|:---------:|
|    1    |           A* with h_1          |    True    |    0.0330    |        55       |     57     |    224    |
|    2    |           A* with h_1          |    True    |    5.9361    |       2724      |    2726    |   21377   |
|    3    |           A* with h_1          |    True    |    49.8126   |      18223      |    18225   |   159618  |
|    1    | A* with h_ignore_preconditions |    True    |    0.0325    |        41       |     43     |    170    |
|    2    | A* with h_ignore_preconditions |    True    |    2.2290    |       876       |     878    |    7199   |
|    3    | A* with h_ignore_preconditions |    True    |    15.6028   |       5040      |    5042    |   44944   |
|    1    |      A* with h_pg_levelsum     |    True    |    0.5447    |        11       |     13     |     50    |
|    2    |      A* with h_pg_levelsum     |    True    |    57.2826   |       238       |     240    |    1911   |
|    3    |      A* with h_pg_levelsum     |    True    |   241.8140   |       325       |     327    |    3002   |

### KPI Analysis
