defmodule VisitableTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  defmodule AccountPage do
    use PageObject

    visitable :visit, "http://localhost:4000/account/:account_id/view.html"
  end

  test "visiting the visitable with an account id inserts it into the url" do
    AccountPage.visit(account_id: 1)

    assert current_url == "http://localhost:4000/account/1/view.html"
  end

  test "visiting the visitable with query params inserts them into the url" do
    AccountPage.visit(account_id: 2, param: "param1", other_param: "param2")

    assert current_url == "http://localhost:4000/account/2/view.html?param=param1&other_param=param2"
  end
end
