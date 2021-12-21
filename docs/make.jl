using Etcetera
using Documenter

DocMeta.setdocmeta!(Etcetera, :DocTestSetup, :(using Etcetera); recursive=true)

makedocs(;
    modules=[Etcetera],
    authors="René Olsthoorn <39967488+rene-olsthoorn@users.noreply.github.com> and contributors",
    repo="https://github.com/rene-olsthoorn/Etcetera.jl/blob/{commit}{path}#{line}",
    sitename="Etcetera.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://rene-olsthoorn.github.io/Etcetera.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/rene-olsthoorn/Etcetera.jl",
    devbranch="main",
)
