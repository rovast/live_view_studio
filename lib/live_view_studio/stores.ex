defmodule LiveViewStudio.Stores do
  def search_by_zip(zip) do
    :timer.sleep(1000)

    if String.length(zip) == 0 do
      list_stores()
    else
      list_stores()
      |> Enum.filter(&(&1.zip == zip))
    end
  end

  @spec list_stores :: [%{name: <<_::64, _::_*8>>, zip: <<_::8>>}, ...]
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
