defmodule S2tBot.Telegram do
	@token Application.get_env(:s2t_bot, :telegram_api_secret)
	@host "https://api.telegram.org"
	@endpoint "#{@host}/bot#{@token}"

	# Set Tekegram bot web hook
	def set_hook(url) do
		HTTPotion.get "#{@endpoint}/setWebhook?url=#{URI.encode(url)}"
	end

	# Download file by its id and store it in temp location
	def get_file(file_id) do
		%{"ok" => true, "result" => %{"file_path" => file_path}} = 
			HTTPotion.get("#{@endpoint}/getFile?file_id=#{file_id}").body
			|> Poison.decode!
		
		%HTTPotion.Response{body: body} = HTTPotion.get("#{@host}/file/bot#{@token}/#{file_path}")
		File.write!("tmp/#{file_id}.ogg", body)

		{:ok, "tmp/#{file_id}.ogg"}
	end

	# Send text to chat +chat_id+
	def send_message(message, chat_id) do
		 HTTPotion.get("#{@endpoint}/sendMessage?chat_id=#{chat_id}&text=#{URI.encode(message)}")
	end	
end