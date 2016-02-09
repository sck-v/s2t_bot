defmodule S2tBot.GoogleSpeechApi do
	@api_key Application.get_env(:s2t_bot, :google_speech_api_secret)
	@endpoint "https://www.google.com/speech-api/v2/recognize?output=json&lang=ru-ru&key=#{@api_key}"
  
	def recognize(file_name) do
		{:ok, flac_file} = convert_to_flac(file_name)

		# Send flac file to google speech recognizer
		%HTTPotion.Response{body: body} = 
				HTTPotion.post(@endpoint, [body: flac_file, 
					headers: ["Content-Type": "audio/x-flac; rate=48000;"],
					timeout: 50_000])

		[_, response, _] = String.split(body, "\n")	
		
		response |> Poison.decode! |> extract_result
	end

	def extract_result(%{"result" => [%{"alternative" => [%{"transcript" => result} | _]}]}) do
		result
	end
	def extract_result(%{"result" => []}) do
		""
	end

	defp convert_to_flac(file_name) do
		System.cmd "ffmpeg", ["-i", file_name, "-c:a", "flac", "#{file_name}.flac"]

		File.read("#{file_name}.flac")
	end
end