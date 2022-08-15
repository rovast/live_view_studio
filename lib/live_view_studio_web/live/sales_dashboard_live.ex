defmodule LiveViewStudioWeb.SalesDashboardLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Sales

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    socket = assign_stat(socket)

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Dashboard</h1>
    <p>New orders: <%= @new_orders %></p>
    <p>Sales amount: <%= @sales_amount %></p>
    <p>Satisfaction: <%= @satisfaction %></p>
    <button phx-click="refresh">Refresh</button>
    """
  end

  def handle_event("refresh", _, socket) do
    socket = assign_stat(socket)
    {:noreply, socket}
  end

  def handle_info(:tick, socket) do
    socket = assign_stat(socket)
    {:noreply, socket}
  end

  defp assign_stat(socket) do
    assign(socket,
      new_orders: Sales.new_orders(),
      sales_amount: Sales.sales_amount(),
      satisfaction: Sales.satisfaction()
    )
  end
end
