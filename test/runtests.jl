using Ledger
using Test

@testset "Ledger.jl" begin

    # Extending the interface for my own types/valuation basis

    struct MyValuationBasis <: Ledger.ValuationBasis end

    struct MyBond <: Ledger.Asset
        par
    end

    Ledger.value(::MyValuationBasis,b::MyBond) = b.par

    gl = GeneralLedger()
    
    addAsset!(gl,MyBond(100))

    bal = Balance(MyValuationBasis(),gl)

    @test sum(bal.assets) == 100.0
    @test length(bal.liabilities) == 0
    @test sum(bal.equity) == 100.0

    struct myDebt <: Ledger.Liability
        balance
        int_rate
        years_due
    end

    Ledger.value(::MyValuationBasis,b::myDebt) = b.balance / (1+ b.int_rate) ^ b.years_due
    
    addLiability!(gl,myDebt(50,0.05,3))

    bal = Balance(MyValuationBasis(),gl)

    @test sum(bal.assets) == 100.0
    @test sum(bal.liabilities) == 50 / 1.05 ^ 3
    @test sum(bal.equity) == 100.0 - 50 / 1.05 ^ 3


end
