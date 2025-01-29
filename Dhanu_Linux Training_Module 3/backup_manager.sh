#!\bin\bash

#storing all data
echo -e "\n"

Source_Dir=$1
BackUp_dir=$2
File_ext=$3

Total_Size=0

export BACKUP_COUNT=0 #exporting backup_count variable to global

#checking for directory and creating it if not exists

if [ ! -d "$BackUp_dir" ]; then
	mkdir -p "$BackUp_dir"
	if [ $? -ne 0 ]; then 
		echo "Error Creating Backup Folder"
		exit 100
	fi
fi

# collecting the file with given extension and storing it in assoiated array

declare -A files

for i in $(find "${Source_Dir}" -type f -name "*${File_ext}");
do
	files[$i]=$(stat -c "%s" $i)
done

echo -e "Total files found = ${#files[@]}"
sleep 1
if [ ${#files[@]} == 0 ];
then
	echo "No ${File_ext} found"
	exit 200
fi

echo -e "File path \t\t File Size"
for i in ${!files[@]}; do
echo -e "$( basename $i) \t ${files[$i]} "
done  
sleep 0.3
echo -en "Starting Backup"
for i in 1 2 3; do
echo -n "."
sleep 0.3
done
echo -e "\n"

one_file_percent=$(echo "scale=0; 100/${#files[@]}" | bc)
total=0

echo -n "Percentage Completed : 00%"
for i in ${!files[@]};
do
	
	if [ $(ls "${BackUp_dir}" | grep $( basename $i )) ]; then
		time_stamp=$(stat -c "%Y" "${BackUp_dir}/$( basename $i )")
		if [ ${time_stamp} -lt $(stat -c "%Y" "$i") ]; then
			mv $i ${BackUp_dir}
			Total_Size=$((Total_Size + ${files[$i]}))
			total=$((total + one_file_percent))
			if [ $((100-total)) -lt $one_file_percent ]; then total=100; fi
			echo -ne "\b\b\b${total}%"
			((BACKUP_COUNT++))
		
		else
			rm -f $i
		fi
	
	else
		mv $i ${BackUp_dir}
		Total_Size=$((Total_Size + ${files[$i]}))
		total="$((total + one_file_percent))"
		
		if [ $((100-total)) -lt $one_file_percent ]; then total=100; fi
		echo -ne "\b\b\b${total}%"
		((BACKUP_COUNT++))
	fi
	sleep 0.2
done

echo -e "\n"

# Generating Backup_report.log file

echo "Generating backup_report.log"
echo "Total file processed = ${#files[@]}" >> "${BackUp_dir}/backup_report.log"
echo "Total Size of file BackedUp = ${Total_Size}" >> "${BackUp_dir}/backup_report.log"
echo "Path to backup directory = ${BackUp_dir}" >> "${BackUp_dir}/backup_report.log"
echo -e "\nlog file generated successfully @ ${BackUp_dir}\n"

echo "Note : The files with same name is overwritten only if the file is older then the source file"








