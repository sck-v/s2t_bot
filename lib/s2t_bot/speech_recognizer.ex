defmodule S2tBot.SpeechRecognizer do
	alias S2tBot.Telegram
	alias S2tBot.GoogleSpeechApi

	def process_message(%{"message" => %{"reply_to_message" => message}}) do
		process_message(%{"message" => message})
	end
	def process_message(%{"message" => message}) do
		%{"chat" => %{"id" => chat_id}, "voice" => %{"file_id" => file_id}} = message	

		Task.start_link fn -> recognize(file_id) |> reply(chat_id) end
	end

	defp recognize(file_id) do
		{:ok, file_name} = Telegram.get_file(file_id)

		GoogleSpeechApi.recognize(file_name)
	end

	defp reply(text, chat_id) do
		Telegram.send_message(text, chat_id)		
	end
end