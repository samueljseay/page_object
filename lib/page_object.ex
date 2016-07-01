defmodule PageObject do
  defmacro __using__(_opts) do
    quote do
      import PageObject
      import PageObject.Actions.Visitable
      import PageObject.Actions.Clickable
      import PageObject.Collections.Collection
      import PageObject.Queries.{Attribute, Property, Text, Value}
    end
  end
end
