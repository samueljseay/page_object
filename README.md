# PageObject

[![Build Status](https://travis-ci.org/samueljseay/page_object.svg?branch=master)](https://travis-ci.org/samueljseay/page_object)

PageObject is a DSL implementing something akin to the
Page Object pattern for automated testing in Elixir. The API is inspired by [ember-cli-page-object](https://github.com/san650/ember-cli-page-object).

To find out more about the PageObject pattern check out the [selenium documentation](https://seleniumhq.github.io/docs/best.html#page_object_models).

## Install

PageObject is not published on hex yet, so if you want to use it at the moment you'll need to add the following to your mix.exs in deps:

`{:page_object, git: "https://github.com/samueljseay/page_object"}`

To use PageObject in your tests you'll still need to setup hound in your test environment. To find out more about that go to the [hound repository](https://github.com/HashNuke/hound).

Once you have hound and have started a `hound_session` in your test you can use PageObject modules you've defined as in the API examples below.

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

For more API examples see the [tests](https://github.com/samueljseay/page_object/tree/master/test). Documentation coming soon.

### Running the tests

Browser automation is handled by Hound but you'll also need phantomjs installed.

1. `npm install -g phantomjs`
2. `phantomjs --wd > /dev/null 2>&1 & mix test; && killall phantomjs`

### TODO
* publish on hex
* moduledoc
