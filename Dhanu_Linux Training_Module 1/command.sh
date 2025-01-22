echo "\n Question 1 \n"
touch file1
ls -lrt file1
chmod a+x file1
ls -lrt file1
echo "\n Question 2 \n"
touch file2
ls -lrt file2
chmod g-w file2
ls -lrt file2
echo "\n Question 3 \n"
mkdir dir1 dir2
touch dir1 file1
ln -s dir1/file1 dir2/file1_link
cd dir2
ls
cd ..
echo "\n Question 4 \n"
ps -au
echo "\n Question 5 \n"
mkdir dir
touch dir/file1 dir/file2 dir/file3
ls -lt dir >  Q5_output.txt
echo "Output of this Question is saved to the Q5_output.txt file \n"


read -p "Do you want to erase all footprints of the particular execution? y/n " data
data=$(echo "$data" | tr '[:upper:]' '[:lower:]')
case "$data" in 
	"y")
		rm -rf dir1 dir2 dir
		rm file1 file2
		echo "\n The unwanted folders was deleted successfully"
		;;
	"n")
		echo -p "\n You selected NO "
		;;
	*)
		;;
esac

echo "\n Thank you\n"
