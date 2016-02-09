defmodule S2tBot.Router do
  use S2tBot.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", S2tBot do
    pipe_through :api

    get "/setup", TelegramController, :show
    get "/telegram", TelegramController, :hook
    post "/telegram", TelegramController, :hook
  end
end
