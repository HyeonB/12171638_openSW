#! /bin/bash
echo -n "User Name: SongHyeonBin"
echo "Student Number: 12171638"
echo "[ MENU ]"
echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item'"
echo "2. Get the data of action genre movies from 'u.item'"
echo "3. Get the average 'rating’ of the movie identified by specific 'movie id' from 'u.data’"
echo "4. Delete the ‘IMDb URL’ from ‘u.item"
echo "5. Get the data about users from 'u.user’"
echo "6. Modify the format of 'release date' in 'u.item’"
echo "7. Get the data of movies rated by a specific 'user id' from 'u.data'"
echo "8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'"
echo "9. Exit"
echo "--------------------------"
while true
do
	read -p "Enter your choice [ 1-9 ] " num
	case $num in
		1)
			echo ""
			read -p "Please enter 'movie id'(1~1682):" id
			echo ""
			cat u.item | awk -F\| -v i=$id '$1==i {print $0}'
			echo ""
			;;
		2)
			echo ""
			read -p "Do you want to get the data of ‘action’ genre movies from 'u.item'?(y/n):" yn
			echo ""
			if [ "$yn" = 'y' ]
			then
				cat u.item | awk -F\| '$7=="1" {print $1,$2}' | head -n 10
			fi
			echo ""
			;;
		3)
			echo ""
			read -p "Please enter the 'movie id’(1~1682):" id
			echo ""
			sum=0
			count=0
			cat u.data | awk -F"\t" -v i=$id '$2==i {sum += $3; count++} END {printf "average rating of $i: %.5f", (sum/count)}'
			echo ""
			echo ""
			;;
		4)
			echo ""
			read -p "Do you want to delete the ‘IMDb URL’ from ‘u.item’?(y/n):" yn
			echo ""
			if [ "$yn" = 'y' ]
			then
				cat u.item | sed -E -e 's/(http[^)]*\))//g' | head -n 10
			fi
			echo ""
			;;
		5)
			echo ""
			read -p "Do you want to get the data about users from‘u.user’?(y/n):" yn
			echo ""
			if [ "$yn" = 'y' ]
			then
				cat u.user | awk -F\| '{print $1,$2,$3,$4}' | head -n 10 | sed -E 's/([0-9]+) ([0-9]+) (M|F) (.*)/user \1 is \2 years old \3 \4/' | sed -E 's/M/male/g' | sed -E 's/F/female/g'
			fi
			echo ""
			;;
		6)
			echo ""
			read -p "Do you want to Modify the format of ‘release data’ in ‘u.item’?(y/n):" yn
			echo ""
			if [ "$yn" = 'y' ]
			then
				cat u.item | sed -E 's/([0-9]{2})-([A-Za-z]{3})-([0-9]{4})/\3\2\1/g' | sed -e 's/Jan/01/' -e 's/Feb/02/' -e 's/Mar/03/' -e 's/Apr/04/' -e 's/May/05/' -e 's/Jun/06/' -e 's/Jul/07/' -e 's/Aug/08/' -e 's/Sep/09/' -e 's/Oct/10/' -e 's/Nov/11/' -e 's/Dec/12/'| tail -n 10
			fi
			echo ""
			;;
		7)
			echo ""
			read -p "Please enter the ‘user id’(1~943):" id
			echo ""
			cat u.data | awk -F"\t" -v i=$id '$1==i {print $2}' | sort -n | tr '\n' '| ' | sed 's/|$//'
			echo""
			echo""
			for i in $(cat u.data | awk -F"\t" '$1==12 {print $2}' | sort -n | head -n 10)
			do
				cat u.item | awk -F\| -v id=$i '$1==id {print $1"|"$2}'
			done
			echo ""
			;;
		8)
			echo ""
			read -p "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'?(y/n):" yn
			
			echo ""
			;;
		9)
			echo "Bye"
			exit 0
			;;

	esac

done



