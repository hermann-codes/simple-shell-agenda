#!/bin/bash
clear
my_db_file=db.txt

add()
{
  clear
  echo -e "\nInformations about the new entry"
  while [ -z "$_title" ]
  do 
    read -p "Title --> " _title
  done
  while [ -z "$_date" ]
  do 
    read -p "Date (AAAAMMJJ) --> " _date
  done
  while [ -z "$_hour" ]
  do 
    read -p "Hour (HH:MM) --> " _hour
  done
  echo "$_title\t$_date\t$_hour" >> "$my_db_file"
  unset _title
  unset _date
  unset _hour
  clear
}

delete()
{
  clear
  echo -e "\nEnter the id of the entry to delete"
  while [ -z "$_entry_id" ]
  do
    read -p "Id --> " _entry_id
  done
  read -p "Are you sure? [ Y or y to confirm / Any other key to abort ] " _confirm
  if [ "$_confirm" = "Y" ] || [ "$_confirm" = "y" ]; then
    _entry_id+="d"
    sed -i".bak" $_entry_id "$my_db_file"
  fi
  unset _entry_id
  unset _cofnirm
  clear
}

consult()
{
  if [ -f "$my_db_file" ];then
    i=1
    while IFS= read -r title date hour
    do
        echo -e "$i\t$title\t$date\t$hour"
        i=$(($i+1))
    done < "$my_db_file"
  else
    echo -e "Database file not found, add an entry to create it.\n"
  fi
}

while true 
do
    clear
    actual_date=$(date +%d-%m-%Y)
    actual_hour=$(date +%H:%M)
    echo -e "Today: $actual_date $actual_hour\n**************************\nList of entries\nid\tTitle\tDate and Hour\n"
    consult
    echo -e "**************************\nMenu\n1- Add an etry\n2- Delete an entry\n0- Exit\nEnter your selection"
    read -p "--> " _selection
    case $_selection in
        1) add ;;
        2) delete ;;
        0) clear
           echo "Press enter to exit"
           read
           clear
           exit;;
        *) echo "Unknown choice";;
    esac
done
exit