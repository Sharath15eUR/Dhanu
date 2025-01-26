echo "\n Question 1 \n"
find . -type f -size +1M > large_files.txt
cat large_files.txt

echo "\n Question 2 \n"
sed 's/localhost/127.0.0.1/g' config.txt > updated_config.txt
cat updated_config.txt

echo "\n Question 3 \n"
grep -i ERROR log.txt | grep -iv DEBUG > filtered_log.txt
cat filtered_log.txt

echo "\n Question 4 \n"
ps --no-header aux --sort -rss | head -n 1 | awk '{print $2}' | xargs kill -9

echo "\n Question 5 \n"

ip route | awk '{print $3}' | sort -u > output.txt
cat output.txt





echo "\n Thank you\n"
