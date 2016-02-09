# S2tBot

[Telegram bot](https://telegram.org/blog/bot-revolution) for decoding audio messages to text using google speech api.

## Installation

1. Register new Telegram bot [here](https://core.telegram.org/bots#3-how-do-i-create-a-bot)
2. Get google speech api token like described in [howto](http://www.chromium.org/developers/how-tos/api-keys)
3. Put your api tokens in `config/prod.secret.exs`
4. [Deploy](http://www.phoenixframework.org/docs/deployment) application. You will need a server capable to run erlang applications and `ffmpeg` installed.
You can use heroku with buildpacks:
	*https://github.com/HashNuke/heroku-buildpack-elixir.git
	*https://github.com/gjaldon/heroku-buildpack-phoenix-static.git
	*https://github.com/HYPERHYPER/heroku-buildpack-ffmpeg.git
5. Go to `<your application url>/setup`	to register your bot handler
6. Add bot in your contact list
7. Try to say him something or forward some message with voice.
8. Enjoy

## Caveats

* Google API only accepts up to ~10-15 seconds of audio.
* You can only make 50 requests per day to the Google speech API.

## Links

* [gillesdemey/google-speech-v2](https://github.com/gillesdemey/google-speech-v2) - Google speech api reverse
* http://www.phoenixframework.org/
* http://elixir-lang.com

## Roadmap

* Get rid of database and assets stuff
* Reply with error messages if there are any
* ... any idea?