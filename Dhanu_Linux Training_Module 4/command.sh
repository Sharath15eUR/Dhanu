read -p "input file name with extension :" input_file
until [[ -e ${input_file} || -s ${input_file} ]]; do
	echo "!!Invalid file or file seems to be empty!! try again "
	read -p "input file name with extension :" input_file
done

read -p "output file name with extension :" output_file

mapfile -t lines < ${input_file}


for i in "${lines[@]}";
do 
	if [[ $i == *"\"frame.time\":"* || $i == *"\"wlan.fc.type\":"* || $i == *"\"wlan.fc.subtype\":"* ]]; then 
		echo $i >> ${output_file}
	fi
done

echo "The ${output_file} file is ready to view"
