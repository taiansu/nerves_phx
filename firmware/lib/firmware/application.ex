defmodule Firmware.Application do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    :ok = setup_db(:ui)

    # Define workers and child supervisors to be supervised
    children = [
      # worker(Firmware.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Firmware.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def setup_db(app) do
    for repo <- Application.get_env(app, :ecto_repos)do
      setup_repo(app, repo)
      migrate_repo(app, repo)
    end
    :ok
  end

  def setup_repo(app, repo) do
    db_file = Application.get_env(app, repo)[:database]
    unless File.exists?(db_file) do
      :ok = repo.__adapter__.storage_up(repo.config)
    end
  end

  def migrate_repo(app, repo) do
    opts = [all: true]
    {:ok, pid, apps} = Mix.Ecto.ensure_started(repo, opts)

    pool = repo.config[:pool]
    migrations_path = app
                      |> :code.priv_dir
                      |> to_string
                      |> Path.join("repo/migrations")

    migrator = fn ->
      Ecto.Migrator.run(repo, migrations_path, :up, opts)
    end

    migrated =
      if function_exported?(pool, :unboxed_run, 2) do
        pool.unboxed_run(repo, migrator)
      else
        migrator.()
      end

    pid && repo.stop(pid)
    Mix.Ecto.restart_apps_if_migrated(apps, migrated)
  end
end
