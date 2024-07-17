#!/bin/bash

# Load environment variables and cli jar
source ./env_loader.sh

# Read the plugins file and install each plugin
while read -r line || [ -n "$line" ];
do
    echo "LINE = $line"
    plugin=$(echo "$line" | cut -d':' -f1)
#    version=$(echo "$line" | cut -d':' -f2)
    if [ -n "$plugin" ]; then
        echo "Attempting to install $plugin"
        # java command child process inherits plugins file descriptor,
        # interprets it as input and reads plugins file till the end,
        # moving read file pointer to the end after first line.
        # In this case, only first line is processed.
        # < /dev/null suffix redirects java child process input to null device,
        # so plugins file pointer remains intact.

        output=$(java -jar "$JENKINS_CLI" -s "$JENKINS_URL" -auth "$JENKINS_AUTH" install-plugin "$plugin" -deploy 2>&1 < /dev/null)
        echo "$output"
    fi
done < "$PLUGINS_LIST_FILE"

echo "Finished processing all plugins"

# Restart Jenkins to apply changes
echo "Restarting Jenkins..."
java -jar "$JENKINS_CLI" -s "$JENKINS_URL" -auth "$JENKINS_AUTH" safe-restart
