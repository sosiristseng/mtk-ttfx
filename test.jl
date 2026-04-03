using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D
using OrdinaryDiffEq

function main()
    @parameters a1=3 a2=2.5 β=4 γ=4
    @variables i1(t) i2(t) s1(t)=0.075 s2(t)=2.5
    hil(x, k) = x / (x + k)
    hil(x, k, n) = hil(x^n, k^n)
    eqs = [
        D(s1) ~ a1 * hil(1 + i2, s2, β) - s1,
        D(s2) ~ a2 * hil(1 + i1, s1, γ) - s2,
        i1 ~ 10 * (t > 30) * (t < 40),
        i2 ~ 10 * (t > 10) * (t < 20)
    ]
    @time "Build system" @named sys = System(eqs, t) |> mtkcompile
    @time "Build problem" prob = ODEProblem(sys, [], (0.0, 50.0))
    @time "Solve problem" sol = solve(prob, Tsit5(), tstops=[10.0, 20.0, 30.0, 40.0])
end

main()
