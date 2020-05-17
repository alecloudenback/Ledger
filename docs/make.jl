using Documenter, Ledger

makedocs(;
    modules=[Ledger],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/alecloudenback/Ledger.jl/blob/{commit}{path}#L{line}",
    sitename="Ledger.jl",
    authors="Alec Loudenback",
    assets=String[],
)
