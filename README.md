# PageObject - Work In Progess

## What is a Page Object?

Within your web app's UI there are areas that your tests interact with. A Page Object simply models these as objects within the test code. This reduces the amount of duplicated code and means that if the UI changes, the fix need only be applied in one place.


## API Example

```elixir
defmodule DashboardPage do
  use PageObject

  visitable :visit, "http://localhost:4001/account/:account_id/dashboard"

  clickable :submit, "input[type='submit']"
  clickable :logout, "button.logout"

  collection :things, item_scope: ".thing" do
    clickable :click, "button"
    value :name_value, "input[name='name']"
  end

  def visit_and_submit(account_id) do
    visit(account_id: account_id, test_param: "filter")
    submit
  end
end

# visit http://localhost:4001/account/1/dashboard?test_param=filter
DashboardPage.visit_and_submit(1)

# click logout
DashboardPage.logout

# how many ".things" are there
count =
  DashboardPage.Things.all
  |> Enum.count

IO.puts count

# get 0th item from collection of elements and click button on that item
DashboardPage.Things.get(0)
|> DashboardPage.Things.click

#get 0th item from collection and query the value of "input[name='name']"
DashboardPage.Things.get(0)
|> DashboardPage.Things.name_value
```

## Automated Browser Tests

Browser automation is handled by Hound but you'll also need phantomjs installed.

1. `npm install -g phantomjs`
2. `phantomjs --wd > /dev/null 2>&1 & mix test; killall phantomjs`
