using Accounting
using Test

@testset "Accounting.jl" begin

    # Extending the interface for my own types/valuation basis

    struct MyValuationBasis <: Accounting.ValuationBasis end

    struct MyBond <: Accounting.Asset
        par
    end

    Accounting.value(::MyValuationBasis,b::MyBond) = b.par

    gl = GeneralLedger()
    
    b = MyBond(100)
    addAsset!(gl,b)

    bal = Balance(MyValuationBasis(),gl)

    @test sum(bal.assets) == 100.0
    @test length(bal.liabilities) == 0
    @test sum(bal.equity) == 100.0

    



end
