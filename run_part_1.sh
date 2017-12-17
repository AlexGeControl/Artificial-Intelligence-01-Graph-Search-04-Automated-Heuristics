#!/bin/bash

# problem1, breadth_first_search
python run_search.py -p 1 -s 1
echo "Solving Air Cargo Problem 1 using breadth_first_search done.\n"
# problem1, depth_first_graph_search
python run_search.py -p 1 -s 3
echo "Solving Air Cargo Problem 1 using depth_first_graph_search done.\n"
# problem1, uniform_cost_search
python run_search.py -p 1 -s 5
echo "Solving Air Cargo Problem 1 using uniform_cost_search done.\n"

# problem2, breadth_first_search
python run_search.py -p 2 -s 1
echo "Solving Air Cargo Problem 2 using breadth_first_search done.\n"
# problem2, depth_first_graph_search
python run_search.py -p 2 -s 3
echo "Solving Air Cargo Problem 2 using depth_first_graph_search done.\n"
# problem2, uniform_cost_search
python run_search.py -p 2 -s 5
echo "Solving Air Cargo Problem 2 using uniform_cost_search done.\n"

# problem3, breadth_first_search
python run_search.py -p 3 -s 1
echo "Solving Air Cargo Problem 3 using breadth_first_search done.\n"
# problem3, uniform_cost_search
python run_search.py -p 3 -s 5
echo "Solving Air Cargo Problem 3 using uniform_cost_search done.\n"
# problem3, depth_first_graph_search
python run_search.py -p 3 -s 3
echo "Solving Air Cargo Problem 3 using depth_first_graph_search done.\n"
