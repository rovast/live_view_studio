defmodule LiveViewStudioWeb.AutocompleteLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Names

  def mount(_params, _sessions, socket) do
    socket =
      assign(socket,
        name: "",
        stores: [],
        loading: false
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Fina a store</h1>
    <form phx-change="suggest">
       <input type="text" name="name" autocomplete="off" autofocus placeholder="Input j or r"
       phx-debounce="300"
       value="<%= @name %>"
      />
    </form>
    <%= if @loading do %>
      Loading...
    <% end %>
    <ul>
    <%= for store <- @stores do %>
      <li><b>name:</b><%= store.name %>, <b>name:</b><%= store.name %></li>
    <% end %>
    </ul>
    """
  end

  def handle_event("suggest", %{"name" => name}, socket) do
    send(self(), {:run_name_search, name})

    socket =
      assign(
        socket,
        name: name,
        stores: [],
        loading: true
      )

    {:noreply, socket}
  end

  def handle_info({:run_name_search, name}, socket) do
    case Names.search_by_name(name) do
      [] ->
        socket =
          socket
          |> put_flash(:info, "No stores matching \"#{name}\"")
          |> assign(stores: [], loading: false)

        {:noreply, socket}

      stores ->
        socket = assign(socket, stores: stores, loading: false)
        {:noreply, socket}
    end
  end
end
