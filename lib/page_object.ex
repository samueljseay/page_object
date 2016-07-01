defmodule PageObject do
  defmacro __using__(_opts) do
    quote do
      use Hound.Helpers

      import PageObject
      import PageObject.Collections.Collection
      import PageObject.Actions.{Visitable, Clickable}
      import PageObject.Queries.{Attribute, Property, Text, Value}
    end
  end
end
