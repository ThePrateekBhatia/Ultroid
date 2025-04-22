# Ultroid UserBot - Koyeb Edition

This is a fork of the popular [Ultroid UserBot](https://github.com/TeamUltroid/Ultroid) specifically optimized for deployment on [Koyeb](https://www.koyeb.com/).

## Deployment on Koyeb

### Easy Deployment Method
Click the button below to deploy to Koyeb:

[![Deploy to Koyeb](https://www.koyeb.com/static/images/deploy/button.svg)](https://app.koyeb.com/deploy?type=git&repository=github.com/ThePrateekBhatia/Ultroid&branch=main&name=ultroid-userbot)

### Manual Deployment Steps

1. **Fork this repository**:
   Fork this repository to your GitHub account.

2. **Create a Koyeb account**:
   Sign up for a [Koyeb account](https://app.koyeb.com/auth/signup) if you don't have one.

3. **Create a new app on Koyeb**:
   - Go to the [Koyeb Control Panel](https://app.koyeb.com/)
   - Click "Create App"
   - Select "GitHub" as the deployment method
   - Connect your GitHub account and select your forked repository
   - Choose the main branch
   - Set the name to "ultroid-userbot" or your preferred name

4. **Configure Environment Variables**:
   Add the following environment variables in the Koyeb dashboard:

   - `API_ID`: Your Telegram API ID from [my.telegram.org](https://my.telegram.org)
   - `API_HASH`: Your Telegram API hash from [my.telegram.org](https://my.telegram.org)
   - `SESSION`: Your Telethon or Pyrogram session string
   - `REDIS_URI`: Redis database URL (you can use [upstash.com](https://upstash.com/) for a free Redis database)
   - `REDIS_PASSWORD`: Redis database password
   - `BOT_TOKEN`: Telegram bot token from [@BotFather](https://t.me/BotFather) (optional but recommended)
   - `LOG_CHANNEL`: Telegram channel ID for logging (optional)
   - Other optional variables as needed

5. **Deploy the App**:
   Click "Deploy" and wait for the deployment to complete.

## Session String

You can generate a session string using:
- Online: Visit [repl.it](https://replit.com/@TeamUltroid/UltroidStringSession)
- Locally: Run `python3 -m pyUltroid sessiongen`

## Features

- All original Ultroid features
- Optimized for Koyeb's free tier
- Automatic health checks to keep the bot running
- Easy deployment process

## Support

For support, join our Telegram group: [Your Support Group Link]

## Credits

- [Team Ultroid](https://github.com/TeamUltroid) for the original Ultroid UserBot
- [ThePrateekBhatia](https://github.com/ThePrateekBhatia) for the Koyeb-specific modifications

## License

This project is licensed under the GNU Affero General Public License v3.0 - see the [LICENSE](LICENSE) file for details.
