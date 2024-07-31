source ~/.bashrc

export ANDROID_HOME=~/home/cs/android_sdk
export PATH=$ANDROID_HOME/emulator/:$PATH
export PATH=$ANDROID_HOME/platform-tools/:$PATH
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin/:$PATH

export PATH="/usr/bin/flutter/bin:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"
