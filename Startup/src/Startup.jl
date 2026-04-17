module Startup

using PrecompileTools

@recompile_invalidations begin
    using ModelingToolkit
    using OrdinaryDiffEq
    using Plots
    using CSV
    using DataFrames
end

end # module Startup
