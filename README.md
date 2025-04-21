# Ultroid Extended - Heroku Only Edition

A stable pluggable Telegram userbot based on Telethon, focused exclusively on Heroku deployment.

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/ThePrateekBhatia/Ultroid)

## Deploy to Heroku

1. Click the Deploy to Heroku button above.
2. Fill in the required environment variables (see below).
3. Wait for the build to finish and open the app.


### Necessary Variables

- `SESSION` - SessionString for your account's login session. Get it from [here](#session-string)
- `HEROKU_API` - Your Heroku API key
- `HEROKU_APP_NAME` - Your Heroku app name
- One of the following database URLs:
  - `REDIS_URI` (recommended)
  - `MONGO_URI`
  - `DATABASE_URL`


### Health Check

Heroku requires a web process. This bot exposes a minimal web server at `/` and `/health`.


## License

This project is licensed under the AGPL License.


## Credits

- Based on [TeamUltroid/Ultroid](https://github.com/TeamUltroid/Ultroid)
- Extended and maintained for Heroku by [ThePrateekBhatia](https://github.com/ThePrateekBhatia)
