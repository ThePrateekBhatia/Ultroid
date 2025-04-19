<p align="center">
  <img src="./resources/extras/logo_readme.jpg" alt="TeamUltroid Logo">
</p>
<h1 align="center">
  <b>Ultroid - UserBot</b>
</h1>

> **Note**: This fork is optimized specifically for deployment on Heroku and Koyeb platforms.

<b>A stable pluggable Telegram userbot + Voice & Video Call music bot, based on Telethon.</b>

[![](https://img.shields.io/badge/Ultroid-v0.8-crimson)](#)
[![Stars](https://img.shields.io/github/stars/TeamUltroid/Ultroid?style=flat-square&color=yellow)](https://github.com/TeamUltroid/Ultroid/stargazers)
[![Forks](https://img.shields.io/github/forks/TeamUltroid/Ultroid?style=flat-square&color=orange)](https://github.com/TeamUltroid/Ultroid/fork)
[![Size](https://img.shields.io/github/repo-size/TeamUltroid/Ultroid?style=flat-square&color=green)](https://github.com/TeamUltroid/Ultroid/)   
[![Python](https://img.shields.io/badge/Python-v3.10.3-blue)](https://www.python.org/)
[![CodeFactor](https://www.codefactor.io/repository/github/teamultroid/ultroid/badge/main)](https://www.codefactor.io/repository/github/teamultroid/ultroid/overview/main)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/TeamUltroid/Ultroid/graphs/commit-activity)
[![Docker Pulls](https://img.shields.io/docker/pulls/theteamultroid/ultroid?style=flat-square)](https://img.shields.io/docker/pulls/theteamultroid/ultroid?style=flat-square)   
[![Open Source Love svg2](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/TeamUltroid/Ultroid)
[![Contributors](https://img.shields.io/github/contributors/TeamUltroid/Ultroid?style=flat-square&color=green)](https://github.com/TeamUltroid/Ultroid/graphs/contributors)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://makeapullrequest.com)
[![License](https://img.shields.io/badge/License-AGPL-blue)](https://github.com/TeamUltroid/Ultroid/blob/main/LICENSE)   
[![Sparkline](https://stars.medv.io/Teamultroid/Ultroid.svg)](https://stars.medv.io/TeamUltroid/Ultroid)
----

# Deploy
- [Heroku](#deploy-to-heroku)
- [Koyeb](#deploy-to-koyeb)

# Documentation 
[![Documentation](https://img.shields.io/badge/Documentation-Ultroid-blue)](http://ultroid.tech/)

# Tutorial 
- Full Tutorial - [![Full Tutorial](https://img.shields.io/badge/Watch%20Now-blue)](https://www.youtube.com/watch?v=0wAV7pUzhDQ)

- Tutorial to get Redis URL and password - [here.](./resources/extras/redistut.md)
---

## Deploy to Heroku
Get the [Necessary Variables](#Necessary-Variables) and then click the button below!  

<p>
<a href="https://heroku.com/deploy">
  <img src="https://www.herokucdn.com/deploy/button.svg" alt="Deploy">
</a>
</p>

## Deploy to Koyeb
Get the [Necessary Variables](#Necessary-Variables) and then click the button below!

<a href="https://app.koyeb.com/deploy?type=git&repository=github.com/TeamUltroid/Ultroid&branch=main&name=ultroid">
  <img src="https://www.koyeb.com/static/images/deploy/button.svg" alt="Deploy to Koyeb">
</a>

---
## Necessary Variables
- `SESSION` - SessionString for your accounts login session. Get it from [here](#Session-String)

One of the following database:
- For **Redis** (tutorial [here](./resources/extras/redistut.md))
  - `REDIS_URI` - Redis endpoint URL, from [redislabs](http://redislabs.com/).
  - `REDIS_PASSWORD` - Redis endpoint Password, from [redislabs](http://redislabs.com/).
- For **MONGODB**
  - `MONGO_URI` - Get it from [mongodb](https://mongodb.com/atlas).
- For **SQLDB**
  - `DATABASE_URL`- Get it from [elephantsql](https://elephantsql.com).

## Session String
Different ways to get your `SESSION`:
* [![Run on Repl.it](https://replit.com/badge/github/TeamUltroid/Ultroid)](https://replit.com/@TeamUltroid/UltroidStringSession)
* TelegramBot : [@SessionGeneratorBot](https://t.me/SessionGeneratorBot)

---

# License
[![License](https://www.gnu.org/graphics/agplv3-155x51.png)](LICENSE)   
Ultroid is licensed under [GNU Affero General Public License](https://www.gnu.org/licenses/agpl-3.0.en.html) v3 or later.

---

# Credits
* [![TeamUltroid-Devs](https://img.shields.io/static/v1?label=Teamultroid&message=devs&color=critical)](https://t.me/UltroidDevs)
* [Lonami](https://github.com/LonamiWebs/) for [Telethon.](https://github.com/LonamiWebs/Telethon)
* [MarshalX](https://github.com/MarshalX) for [PyTgCalls.](https://github.com/MarshalX/tgcalls)

> Made with 💕 by [@TeamUltroid](https://t.me/TeamUltroid).    
