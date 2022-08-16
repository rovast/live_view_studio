defmodule LiveViewStudioWeb.SearchLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Stores

  def mount(_params, _sessions, socket) do
    socket =
      assign(socket,
        zip: "",
        stores: [],
        loading: false
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Fina a store</h1>
    <form phx-submit="search">
      <input type="text" name="zip" autocomplete="off" autofocus placeholder="enter number 1~6"
        value="<%= @zip %>"
        <%= if @loading, do: "readonly" %>
       />
      <button type="submit">Search</button>
    </form>
    <%= if @loading do %>
      Loading...
    <% end %>
    <ul>
    <%= for store <- @stores do %>
      <li><b>name:</b><%= store.name %>, <b>zip:</b><%= store.zip %></li>
    <% end %>
    </ul>
    """
  end

  def handle_event("search", %{"zip" => zip}, socket) do
    send(self(), {:run_zip_search, zip})

    socket =
      assign(
        socket,
        zip: zip,
        stores: [],
        loading: true
      )

    {:noreply, socket}
  end

  def handle_info({:run_zip_search, zip}, socket) do
    socket =
      assign(
        socket,
        zip: zip,
        stores: Stores.search_by_zip(zip),
        loading: false
      )

    {:noreply, socket}
  end
end
