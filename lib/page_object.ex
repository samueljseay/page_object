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

  collection :things, scope: ".um" do
    clickable :submit, "input[type='submit']"
  end

  def visit_and_submit(account_id) do
    visit(account_id: account_id, test_param: "filter")
    submit
  end
end

DashboardPage.visit_and_submit(1)
