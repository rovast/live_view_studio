defmodule LiveViewStudioWeb.LicenseLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Licesences

  import Number.Currency

  def mount(_params, _session, socket) do
    socket = assign(socket, seats: 2, amount: Licesences.calculate(2))
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Team Licenses</h1>
    <p>Your license is currently for <strong><%= @seats %></strong> seats.</p>
    <form phx-change="update">
      <input type="range" name="seats" value="<%= @seats %>" min="1" max="10" />
    </form>
    <p><%= number_to_currency(@amount) %></p>
    """
  end

  def handle_event("update", %{"seats" => seats}, socket) do
    seats = String.to_integer(seats)

    socket =
      assign(socket,
        seats: seats,
        amount: Licesences.calculate(seats)
      )

    {:noreply, socket}
  end
end
