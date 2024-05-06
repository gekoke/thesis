def make_plus_or_minus():
    return random.choice(["+", "-"])

def make_comparison_operator(allow_eq: bool = True):
    """allow_eq: Whether to allow generating the '=' operator."""
    return random.choice(["<", "<=", ">=", ">"] + (["=="] if allow_eq else []))

def make_quadratic() -> Expr:
    def make_coeffiecient():
        return random.randint(-12, 12)

    a, b, c = make_coeffiecient(), make_coeffiecient(), make_coeffiecient()
    op1, op2 = make_plus_or_minus(), make_plus_or_minus()
    return sympify(f"{a}*x**2 {op1} {b}*x {op2} {c}", evaluate=False)

def make_quadratic_inequality_problem() -> Problem:
    """
    Make a quadratic inequality problem.

    Example:
    -------
    `-5x**2 + 9x + 2 > 0`.
    """
    quadratic = make_quadratic()
    comparison = make_comparison_operator(allow_eq=False)

    problem_definition = sympify(f"{quadratic} {comparison} 0")
    problem_solution = solveset(problem_definition, "x", S.Reals)

    problem = Problem()
    problem.definition = latex(problem_definition)
    problem.solution = latex(problem_solution)
    problem.kind = ProblemKind.QUADRATIC_INEQUALITY
    return problem
