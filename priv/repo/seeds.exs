alias Anvil.Repo
alias Anvil.Category

for category <- ~w(Action Drama Romance Comedy Sci-fi) do
    Repo.insert!(%Category{name: category})
end