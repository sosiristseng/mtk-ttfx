using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D
using OrdinaryDiffEq

function main()
    @parameters τ = 3.0 # parameters
    @variables x(t) = 0.0 # dependent variables
    eqs = [D(x) ~ (1 - x) / τ]
    @time "Build system" @named sys = System(eqs, t)
    @time "MTKCompile" fol = mtkcompile(sys)
    @time "Build problem" prob = ODEProblem(fol, [], (0.0, 10.0))
    @time "Solve problem" sol = solve(prob, Tsit5())
end

main()
