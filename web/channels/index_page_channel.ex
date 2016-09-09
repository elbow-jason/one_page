defmodule OnePage.IndexPageChannel do
  use OnePage.Web, :channel
  require Logger


  def join("index_page:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("click", %{"id" => ""}, socket) do
    Logger.debug("unidentified element clicked")
    {:noreply, socket}
  end
  def handle_in("click", %{"id" => id} = payload, socket) do
    Logger.debug("click: #{id}")
    broadcast socket, "click", payload
    {:noreply, socket}
  end

  def handle_in("mousemove", payload, socket) do
    Logger.debug("mousemove: #{inspect payload}")
    broadcast socket, "mousemove", payload
    {:noreply, socket}
  end

  def handle_in("keydown", payload, socket) do
    Logger.debug("keydown: #{inspect payload}")
    broadcast socket, "keydown", payload
    {:noreply, socket}
  end


  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (index_pages:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # This is invoked every time a notification is being broadcast
  # to the client. The default implementation is just to push it
  # downstream but one could filter or change the event.
  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
