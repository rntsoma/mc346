from solver import Solver

# Funcao principal
def main():
    solver=Solver()
    arr=solver.treatInput()
    head = arr.pop(0)
    print solver.findElo(arr, head)

main()