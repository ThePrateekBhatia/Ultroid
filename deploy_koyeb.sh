#!/usr/bin/env bash
# Ultroid - UserBot
# Koyeb Deployment Helper
# Copyright (C) 2023-2025 ThePrateekBhatia
#
# This file is a part of < https://github.com/ThePrateekBhatia/Ultroid/ >

echo "
█─█─█ █───████ █──█ █───█ █──█ ████
█─█─█ █───█─── █──█ ██─██ █──█ █──█
█─█─█ █───█─── █──█ █─█─█ █──█ █──█
█─█─█ █───███─ █──█ █───█ █──█ █──█
█─█─█ █───█─── █──█ █───█ █──█ █──█
█─█─█ █───█─── █──█ █───█ █──█ █──█
─█─█─ ███─████ ████ █───█ ████ ████

Koyeb Deployment Helper for Ultroid
"

# Check if prerequisites are installed
check_command() {
    if ! command -v $1 &> /dev/null; then
        echo "$1 is not installed. Please install it first."
        exit 1
    fi
}

check_command git
check_command curl

# Check if user has Koyeb CLI installed
if ! command -v koyeb &> /dev/null; then
    echo "Koyeb CLI not found. Would you like to install it? (y/n)"
    read -r answer
    if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
        curl -fsSL https://cli.koyeb.com/install.sh | bash
    else
        echo "Please install Koyeb CLI manually from https://www.koyeb.com/docs/cli/installation"
        exit 1
    fi
fi

# Ask for deployment method
echo "How would you like to deploy Ultroid to Koyeb?"
echo "1. Deploy directly from GitHub (recommended)"
echo "2. Deploy from local directory (advanced)"
read -r deploy_option

case $deploy_option in
    1)
        echo "Enter your GitHub repository URL (e.g., https://github.com/ThePrateekBhatia/Ultroid):"
        read -r repo_url
        
        # Authenticate with Koyeb if needed
        koyeb login
        
        echo "Enter a name for your Koyeb app (default: ultroid-userbot):"
        read -r app_name
        app_name=${app_name:-ultroid-userbot}
        
        # Deploy using Koyeb CLI
        koyeb app create --name $app_name
        koyeb service create --app $app_name --git $repo_url --branch main --build-dockerfile Dockerfile.koyeb
        
        echo "Enter your API_ID from my.telegram.org:"
        read -r api_id
        echo "Enter your API_HASH from my.telegram.org:"
        read -r api_hash
        echo "Enter your SESSION string:"
        read -r session
        echo "Enter your REDIS_URI:"
        read -r redis_uri
        echo "Enter your REDIS_PASSWORD:"
        read -r redis_password
        
        # Set environment variables
        koyeb service env create --app $app_name --service $app_name --key API_ID --value $api_id
        koyeb service env create --app $app_name --service $app_name --key API_HASH --value $api_hash
        koyeb service env create --app $app_name --service $app_name --key SESSION --value $session
        koyeb service env create --app $app_name --service $app_name --key REDIS_URI --value $redis_uri
        koyeb service env create --app $app_name --service $app_name --key REDIS_PASSWORD --value $redis_password
        
        echo "Do you want to add BOT_TOKEN? (y/n)"
        read -r add_bot_token
        if [[ "$add_bot_token" == "y" || "$add_bot_token" == "Y" ]]; then
            echo "Enter your BOT_TOKEN from @BotFather:"
            read -r bot_token
            koyeb service env create --app $app_name --service $app_name --key BOT_TOKEN --value $bot_token
        fi
        
        echo "Do you want to add LOG_CHANNEL? (y/n)"
        read -r add_log_channel
        if [[ "$add_log_channel" == "y" || "$add_log_channel" == "Y" ]]; then
            echo "Enter your LOG_CHANNEL ID:"
            read -r log_channel
            koyeb service env create --app $app_name --service $app_name --key LOG_CHANNEL --value $log_channel
        fi
        
        # Start the deployment
        koyeb service redeploy --app $app_name --service $app_name
        
        echo "Deployment initiated! Your Ultroid bot should be up and running soon."
        echo "You can check the status with: koyeb service get --app $app_name --service $app_name"
        ;;
    2)
        echo "Advanced deployment option selected."
        echo "Please follow these steps:"
        echo "1. Make sure you have the Koyeb CLI installed and authenticated"
        echo "2. Run: koyeb app create --name ultroid-userbot"
        echo "3. Run: koyeb service create --app ultroid-userbot --docker . --dockerfile Dockerfile.koyeb"
        echo "4. Add all required environment variables using the Koyeb dashboard"
        echo "5. Deploy and enjoy your Ultroid bot on Koyeb!"
        ;;
    *)
        echo "Invalid option selected. Exiting."
        exit 1
        ;;
esac

echo "Thank you for using the Ultroid Koyeb Deployment Helper!"
