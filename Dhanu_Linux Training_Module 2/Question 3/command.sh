grep -i ERROR log.txt | grep -iv DEBUG > filtered_log.txt
cat filtered_log.txt
