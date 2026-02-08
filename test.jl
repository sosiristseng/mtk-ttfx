using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D
using OrdinaryDiffEq

@parameters τ = 3.0 # parameters
@variables x(t) = 0.0 # dependent variables
eqs = [D(x) ~ (1 - x) / τ]

@time "Build system" @mktcompile fol = System(eqs, t)
@time "Build problem" prob = ODEProblem(fol, [], (0.0, 10.0))
@time "Solve problem" sol = solve(prob, Tsit5())
