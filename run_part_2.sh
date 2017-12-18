#!/bin/bash

# problem1, breadth_first_search
python run_search.py -p 1 -s 8
echo "Solving Air Cargo Problem 1 using astar_search with h_1 heuristic done."
# problem1, depth_first_graph_search
python run_search.py -p 1 -s 9
echo "Solving Air Cargo Problem 1 using astar_search with h_ignore_preconditions' done."
# problem1, uniform_cost_search
python run_search.py -p 1 -s 10
echo "Solving Air Cargo Problem 1 using astar_search with h_pg_levelsum done."

# problem2, breadth_first_search
python run_search.py -p 2 -s 8
echo "Solving Air Cargo Problem 2 using astar_search with h_1 heuristic done."
# problem2, depth_first_graph_search
python run_search.py -p 2 -s 9
echo "Solving Air Cargo Problem 2 using astar_search with h_ignore_preconditions' done."
# problem2, uniform_cost_search
python run_search.py -p 2 -s 10
echo "Solving Air Cargo Problem 2 using astar_search with h_pg_levelsum done."

# problem3, breadth_first_search
python run_search.py -p 3 -s 8
echo "Solving Air Cargo Problem 3 using astar_search with h_1 heuristic done."
# problem3, uniform_cost_search
python run_search.py -p 3 -s 9
echo "Solving Air Cargo Problem 3 using astar_search with h_ignore_preconditions' done."
# problem3, depth_first_graph_search
python run_search.py -p 3 -s 10
echo "Solving Air Cargo Problem 3 using astar_search with h_pg_levelsum done."
