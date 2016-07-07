defmodule PageObject do
  @moduledoc """
    PageObject wraps all the available macros and is the target module you should `use` in your PageObject module.
  """

  defmacro __using__(_opts) do
    quote do
      use Hound.Helpers

      import PageObject
      import PageObject.Collections.Collection
      import PageObject.Actions.{Visitable, Clickable, Fillable}
      import PageObject.Queries.{Attribute, Text, Value}
    end
  end
end
