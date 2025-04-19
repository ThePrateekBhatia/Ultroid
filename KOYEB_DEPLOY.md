# Deploy Ultroid on Koyeb

This guide will help you deploy Ultroid UserBot on Koyeb.

## Prerequisites

Before you begin, make sure you have:

1. A Telegram account
2. A Koyeb account (Sign up at [https://app.koyeb.com/](https://app.koyeb.com/))
3. Your `API_ID` and `API_HASH` from [my.telegram.org](https://my.telegram.org/)
4. Your `SESSION` string (Generate using [Replit](https://replit.com/@TeamUltroid/UltroidStringSession) or [@SessionGeneratorBot](https://t.me/SessionGeneratorBot))
5. A Redis database from [redislabs.com](https://redislabs.com/)

## Deployment Steps

1. **Get your Redis credentials**
   - Sign up at [redislabs.com](https://redislabs.com/)
   - Create a new Redis database
   - Note the Redis URI and Password

2. **Deploy to Koyeb**
   - Click the Deploy to Koyeb button on the main page of this repository
   - Or use this direct link: [Deploy to Koyeb](https://app.koyeb.com/deploy?type=git&repository=github.com/TeamUltroid/Ultroid&branch=main&name=ultroid)

3. **Configure Environment Variables**
   - During Koyeb deployment, set the following environment variables:
     - `API_ID` - Your Telegram API ID
     - `API_HASH` - Your Telegram API Hash
     - `SESSION` - Your Telegram user session string
     - `REDIS_URI` - Your Redis database URI
     - `REDIS_PASSWORD` - Your Redis database password
     - `BOT_TOKEN` (Optional) - Token for your assistant bot
     - `LOG_CHANNEL` (Optional) - Channel ID for logging

4. **Deploy and Wait**
   - Complete the deployment process
   - Koyeb will automatically build and deploy your Ultroid UserBot
   - This may take a few minutes

5. **Check Logs**
   - Once deployed, you can check the logs in your Koyeb dashboard to ensure everything is working

## Additional Information

- Koyeb provides a reliable platform for running your Ultroid UserBot
- The deployment has automatic restart capabilities if any issues occur
- For support, join the [Ultroid Support Group](https://t.me/UltroidSupport) 