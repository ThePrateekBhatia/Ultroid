#!/usr/bin/env bash

REPO="https://github.com/TeamUltroid/Ultroid.git"
CURRENT_DIR="$(pwd)"
ENV_FILE_PATH=".env"
DIR="/root/TeamUltroid"

while [ $# -gt 0 ]; do
    case "$1" in
    --dir=*)
        DIR="${1#*=}" || DIR="/root/TeamUltroid"
        ;;
    --branch=*)
        BRANCH="${1#*=}" || BRANCH="main"
        ;;
    --env-file=*)
        ENV_FILE_PATH="${1#*=}" || ENV_FILE_PATH=".env"
        ;;
    --no-root)
        NO_ROOT=true
        ;;
    *)
        echo "Unknown parameter passed: $1"
        exit 1
        ;;
    esac
    shift
done

check_dependencies() {
    echo "Checking dependencies..."
    if ! [ -x "$(command -v python3)" ] || ! [ -x "$(command -v python)" ]; then
        echo -e "Python3 isn't installed. Please install python3.8 or higher to run this bot." >&2
        exit 1
    fi
    if [ $(python3 -c "import sys; print(sys.version_info[1])") -lt 8 ]; then
        echo -e "Python 3.8 or higher is required to run this bot."
        exit 1
    fi
    if ! command -v ffmpeg &>/dev/null || ! command -v mediainfo &>/dev/null || ! command -v neofetch &>/dev/null || ! command -v git &>/dev/null; then
        echo -e "Some dependencies aren't installed. Please install ffmpeg, mediainfo, neofetch and git to run this bot." >&2
        exit 1
    fi
}

clone_repo() {
    cd $DIR
    if [ -d $DIR ]; then
        if [ -d $DIR/.git ]; then
            echo -e "Updating Ultroid ${BRANCH}... "
            cd $DIR
            git pull
            currentbranch="$(git rev-parse --abbrev-ref HEAD)"
            if [ ! $BRANCH ]; then
                export BRANCH=$currentbranch
            fi
            case $currentbranch in
            $BRANCH)
                # do nothing
                ;;
            *)
                echo -e "Switching to branch ${BRANCH}... "
                echo -e $currentbranch
                git checkout $BRANCH
                ;;
            esac
        else
            rm -rf $DIR
            exit 1
        fi
        return
    else
        if [ ! $BRANCH ]; then
            export BRANCH="main"
        fi
        mkdir -p $DIR
        echo -e "Cloning Ultroid ${BRANCH}... "
        git clone -b $BRANCH $REPO $DIR
    fi
}

install_requirements() {
    pip3 install -q --upgrade pip
    echo -e "\n\nInstalling requirements... "
    pip3 install -q --no-cache-dir -r $DIR/requirements.txt
    pip3 install -q -r $DIR/resources/startup/optional-requirements.txt
}

dep_install() {
    echo -e "\n\nInstalling DB Requirement..."
    if [ $MONGO_URI ]; then
        echo -e "   Installing MongoDB Requirements..."
        pip3 install -q pymongo[srv]
    elif [ $DATABASE_URL ]; then
        echo -e "   Installing PostgreSQL Requirements..."
        pip3 install -q psycopg2-binary
    elif [ $REDIS_URI ]; then
        echo -e "   Installing Redis Requirements..."
        pip3 install -q redis hiredis
    fi
}

main() {
    echo -e "Starting Ultroid Setup..."
    if [ -d "pyUltroid" ] && [ -d "resources" ] && [ -d "plugins" ]; then
        DIR=$CURRENT_DIR
    fi
    if [ -f $ENV_FILE_PATH ]
    then
        set -a
        source <(cat $ENV_FILE_PATH | sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
        set +a
    fi
    check_dependencies
    clone_repo
    install_requirements
    dep_install
}

main
