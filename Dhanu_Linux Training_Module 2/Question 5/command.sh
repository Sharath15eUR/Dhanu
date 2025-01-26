ip route | awk '{print $3}' | sort -u > output.txt
cat output.txt
