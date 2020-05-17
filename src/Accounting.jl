module Accounting

using Transducers

abstract type Ledger end

struct SubLedger 
    name
    contents
end

struct GeneralLedger
    assets
    liabilities
    equity
end

function GeneralLedger()
    return GeneralLedger([],[],[])
end

function addAsset!(gl::GeneralLedger,a)
    push!(gl.assets,a)
end

function addLiabilitity!(gl::GeneralLedger,l)
    push!(gl.liabilities,l)
end

struct Balance 
    assets
    liabilities
    equity
end

abstract type ValuationBasis end




abstract type Asset end

abstract type Liability end



function value(basis,obj)
    return obj
end


function Balance(basis::ValuationBasis,l::GeneralLedger)
    val = Map(x -> value(basis,x))
    a = tcopy(val,l.assets)
    l = tcopy(val,l.liabilities)
    a_sum = length(a) == 0 ? 0.0 : reduce(+,a) 
    l_sum = length(l) == 0 ? 0.0 : reduce(+,l) 
    eq = a_sum - l_sum

    return Balance(a,l,eq)
end

export value, Asset, Liability, Balance, GeneralLedger,
        addAsset!,addLiabilitity!

end # module
