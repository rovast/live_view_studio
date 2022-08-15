defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :brightness, 10)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Front Porch Light</h1>
    <div style="margin-bottom: 10px">
      <span style="display:inline-block; background: red; width: <%= @brightness %>%"><%= @brightness %></span>
    </div>
    <button phx-click="off">off</button>
    <button phx-click="down">-</button>
    <button phx-click="up">+</button>
    <button phx-click="on">on</button>
    """
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  # 一种更新 brightness 的写法
  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &(&1 + 10))
    {:noreply, socket}
  end

  # 另一种更新 brightness 的写法
  def handle_event("down", _, socket) do
    brightness = socket.assigns.brightness
    socket = assign(socket, :brightness, brightness - 10)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end
end
