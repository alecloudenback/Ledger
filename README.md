# Ledger

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://alecloudenback.github.io/Ledger.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://alecloudenback.github.io/Ledger.jl/dev)

Primary interface:
- Defining a `Ledger.ValuationBasis`
- Defining how to account for that with `Ledger.value(::ValuationBasis,myType)`

## Example

Define a new valuation basis and a simple asset type:

```julia
    # Extending the interface for my own types/valuation basis

    struct MyValuationBasis <: Ledger.ValuationBasis end

    struct MyCash <: Ledger.Asset
        balance
    end

    Ledger.value(::MyValuationBasis,b::MyCash) = b.balance

```

Now create a `GeneralLedger` which will contain references to the underlying objects and be able to value them:

```julia
    gl = GeneralLedger()
    
    addAsset!(gl,MyCash(100))
```

With a single asset in the ledger, show the assets, liabilities, and equity:

```julia
    bal = Balance(MyValuationBasis(),gl)

    @test sum(bal.assets) == 100.0
    @test length(bal.liabilities) == 0
    @test sum(bal.equity) == 100.0
```

Extending the example to include a liability with a more complex `value` function:

```julia
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
```