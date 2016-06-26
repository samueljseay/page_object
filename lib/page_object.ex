defmodule PageObject do
  defmacro __using__(_opts) do
    quote do
      import PageObject
      import PageObject.Actions.Visitable
      import PageObject.Actions.Clickable
      import PageObject.Collections.Collection
    end
  end
end

# testing the API
defmodule DashboardPage do
  use PageObject

  visitable :visit, "http://localhost:4001/account/:account_id/dashboard"
  clickable :submit, "input[type='submit']"

  collection :things, scope: ".things" do
    clickable :click, "button"
  end

  def visit_and_submit(account_id) do
    visit(account_id: account_id, test_param: "filter")
    submit
  end
end

# visit http://localhost:4001/account/1/dashboard?test_param=filter
DashboardPage.visit_and_submit(1)

# how many ".things" are there
DashboardPage.Things.count

# get 0th item from collection of elements and click button on that item
DashboardPage.Things.get(0)
|> DashboardPage.Things.click
