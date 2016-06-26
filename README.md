# What is a Page Object?

An excerpt from the Selenium Wiki

Within your web app's UI there are areas that your tests interact with. A Page Object simply models these as objects within the test code. This reduces the amount of duplicated code and means that if the UI changes, the fix need only be applied in one place.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `hound_page_object` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:hound_page_object, "~> 0.0.1"}]
    end
    ```

  2. Ensure `page_object` is started before your application:

    ```elixir
    def application do
      [applications: [:page_object]]
    end
    ```
