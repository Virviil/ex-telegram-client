defmodule TgClient do
  use Application

  alias TgClient.{Utils, Session}
  import Supervisor.Spec, only: [worker: 3]

  ### Application callbacks

  def start(_type, _args) do
    children = Utils.supervisor_spec ++ Utils.event_manager_pool_spec

    opts = [strategy: :one_for_one, name: TgClient.Supervisor]
    {:ok, _pid} = Supervisor.start_link(children, opts)
  end

  def start_session(phone) do
    Supervisor.start_child(TgClient.Supervisor, worker(Session, [phone], []))
  end

end
