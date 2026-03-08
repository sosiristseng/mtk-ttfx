using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D
using OrdinaryDiffEq

function main()
    @parameters β=0.2 γ=0.15 N=1000
    @variables S(t)=0.99*N I(t)=0.01*N R(t)
    eqs = [
        D(S) ~ -β * S * I / N,
        D(I) ~ β * S * I / N - γ * I,
        R ~ N - S - I
    ]
    @time "Build system" @named _sys = System(eqs, t)
    @time "MTKCompile" sys = mtkcompile(_sys)
    @time "Build problem" prob = ODEProblem(sys, [], (0.0, 100.0))
    @time "Solve problem" sol = solve(prob, Tsit5())
end

main()
