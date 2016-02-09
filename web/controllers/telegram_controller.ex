defmodule S2tBot.TelegramController do
	use S2tBot.Web, :controller
	import S2tBot.Router.Helpers		

	def show(conn, _params) do
		S2tBot.Telegram.set_hook(telegram_url(S2tBot.Endpoint, :hook))

		conn |> put_status(:ok) |> text("ok")
	end

	def hook(conn, params) do
		S2tBot.SpeechRecognizer.process_message(params)

		conn |> put_status(:ok) |> text("ok")
	end
end