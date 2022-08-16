defmodule LiveViewStudio.Names do
  def search_by_name(""), do: []

  def search_by_name(name) do
    Enum.filter(list_stores(), &has_prefix?(&1, name))
  end

  defp has_prefix?(store, prefix) do
    String.starts_with?(String.downcase(store.name), String.downcase(prefix))
  end

  def list_stores do
    [
      %{name: "Jack's store", zip: "1"},
      %{name: "John's store", zip: "2"},
      %{name: "Rose's store", zip: "3"},
      %{name: "Mick's store", zip: "4"},
      %{name: "Jimmy's store", zip: "5"},
      %{name: "Tony's store", zip: "6"}
    ]
  end
end
