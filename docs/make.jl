using Documenter, Accounting

makedocs(;
    modules=[Accounting],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/alecloudenback/Accounting.jl/blob/{commit}{path}#L{line}",
    sitename="Accounting.jl",
    authors="Alec Loudenback",
    assets=String[],
)
