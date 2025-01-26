ps --no-header aux --sort -rss | head -n 1 | awk '{print $2}' | xargs kill -9

