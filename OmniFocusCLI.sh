#!/bin/sh 
#  OmniFocusCLI v.1.1.1
#  Created by Donald Southard aka @binaryghost on 2011-05-14

#Declaration of my variables
iniCheck=`echo "$*"`
if [ -z $iniCheck ]
then
	echo "No task detected, please try again."
	exit
fi
d=86400 #initialize d variable equal to number of seconds in 1 day.
my_context_check=1 #initialize my_context variable
noon_check=0 #initialize noon_check variable
weekday_check=0 #initialize weekday_check variable
monthname_check=0 #initialize month_check variable
start_check=0 #initialize start_check variable
time_check=0 #initialize time_check variable
mon_day_check=0
num_date_check=0
due_check=0
abbrv_date_check=0
today=0
tomorrow=0
hr=12
wd=7
month=`date +%m` #find current month
day_mon=`date +%d`	#find current day of the month
day_week=`date +%w` #find current day of the week


#Define my time/code saving arrays
Months=(31 28 31 30 31 30 31 31 30 31 30 31)
Mon_names=('january' 'february' 'march' 'april' 'may' 'june' 'july' 'august' 'september' 'october' 'november' 'december')
Abbrv_Mon_names=('jan' 'feb' 'mar' 'apr' 'may' 'jun' 'jul' 'aug' 'sept' 'oct' 'nov' 'dec')
Week_days=('sunday' 'monday' 'tuesday' 'wednesday' 'thursday' 'friday' 'saturday')
Abbrv_days=('sun' 'mon' 'tues' 'wed' 'thurs' 'fri' 'sat' 'sun')

echo `clear`
echo "---------------------"
echo "::DIAGNOSTIC REPORT::"
echo "---------------------"


#Funtions for checking for a start date
#First one checks for a start date in a #d format
for i in "$@"
do
	if [[ $i =~ ^[0-9]d ]] || [[ $i =~ ^[0-9][0-9]d ]]; then
		abbrv_date_check=1
		abbrv_date_taskname=$i
		num_days=`echo $@ | tr -dc '[0-9]'`
		temp_days=`echo ""$num_days"*$d" | bc`
	fi
done

#if no days entered set value to zero as fallback
if [ -z $temp_days ]
then
	temp_days=0
fi

#Test for number of weeks i.e. #w... 2w for 2 weeks
for i in "$@"
do
	if [[ $i =~ ^[0-9]w ]] || [[ $i =~ ^[0-9][0-9]w ]]; then
		abbrv_date_check=1
		abbrv_date_taskname=$i
		num_weeks=`echo $@ | tr -dc '[0-9]'`
		temp_weeks=`echo "("$num_weeks"*7)*$d" | bc`
	fi
done
#if no weeks entered set value to zero as fallback
if [ -z $temp_weeks ]
then
	temp_weeks=0
fi

#Test for number of months i.e. #m... 2m for 2 months
for i in "$@"
do
	if [[ $i =~ ^[0-9]m ]] || [[ $i =~ ^[0-9][0-9]m ]]; then
		abbrv_date_check=1
		abbrv_date_taskname=$i
		num_monthz=`echo $@ | tr -dc '[0-9]'`
		temp_monthz=`echo "("$num_monthz"*31)*$d" | bc`
	fi
done
#if no weeks entered set value to zero as fallback
if [ -z $temp_monthz ]
then
	temp_monthz=0
fi
#add days entered to days from weeks entered
sdays=`echo "$temp_days" + "$temp_weeks" + "$temp_monthz" | bc`
echo "Weeks until started: "$num_weeks
echo "Days until started: "$num_days



#This on checks for a start date in a (#|##)/(#|##) format
#Complicated embedded loops and arrays... good luck figuring this code out :P 
for i in "$@"
do
	if [[ $i =~ ^[0-9]/[0-9] ]] || [[ $i =~ ^[0-9][0-9]/[0-9] ]] || [[ $i =~ ^[0-9]/[0-9[0-9]] ]] || [[ $i =~ ^[0-9][0-9]/[0-9][0-9] ]]; then
		num_date_check=1
		start_value_mon=`echo $i | sed 's/\/[0-9]*//'`
		start_value_day=`echo $i | sed 's/[0-9]*\///'`
		echo "Start value (month): "$start_value_mon
		echo "Start value (day): "$start_value_day
		result_day=`echo "$start_value_day" | bc`
		month_counter_max=`echo "("$start_value_mon"-1)" | bc`
		day_counter=0
		array_var=${Months[$month_counter]}
		i=`echo "("$day_mon"+1)" | bc`
		x=`date +%m`
		if [[ "$start_value_mon" -ne $month ]]; then
		while [[ $x -le $month_counter_max ]]
		do
			while [[ $i -le $array_var ]]; do
			(( day_counter++ ))
			(( i++ ))
			done		
			month=`echo "("$month"+1)" | bc`
			array_var="${Months[$month]}"
			i=1
			((x++))
		done
		start_check=1
			if [[ ${Months[("$start_value_mon"-1)]} -eq 31 ]] 
			then
				day_counter=`echo "("$day_counter"-1)" | bc`
			fi
		echo "Number of days from month inputed passed: "$day_counter
		echo "Number of days from day inputed passed: "$result_day
		else
			if [[ "$start_value_day" -gt $day_mon ]]; then
				result_day=`echo ""$start_value_day"-$day_mon" | bc`
				start_check=1
			fi
		fi
	fi
#start_check=1
done

#Find name of month and set it start date
for i in "$@"
do
	mon_formatted=`echo $i | tr A-Z a-z`
	for (( m=0;m<12;m++)); do
	    mon_input=`echo ${Mon_names[${m}]}`
		abbrv_mon_input=`echo ${Abbrv_Mon_names[${m}]}`
		if [[ $mon_formatted = "$mon_input" ]] || [[ $mon_formatted = "$abbrv_mon_input" ]]; then
			monthname_check=1
			monthname_taskname=$i
			month=`date +%m`
			my_mon=`echo "("$m"+1)" | bc`
			month_counter_max=$m
			NatMon_day_counter=0
			array_var=${Months[$asdf]}
			i=`echo "("$day_mon"+1)" | bc`
			x=`date +%m`
			if [[ $my_mon -ne $month ]]; then
				while [[ $x -le $month_counter_max ]]
				do
					while [[ $i -le $array_var ]]; do
					(( NatMon_day_counter++ ))
					(( i++ ))
					done		
					month=`echo "("$month"+1)" | bc`
					array_var="${Months[$month]}"
					i=1
					((x++))
				done
				if [[ ${Months[($m)]} -eq 30 ]]; then
					NatMon_day_counter=`echo "("$NatMon_day_counter"+1)" | bc`
				elif [[ ${Months[($m)]} -eq 28 ]]; then
					NatMon_day_counter=`echo "("$NatMon_day_counter"+3)" | bc`
				fi
				start_check=1
			fi
		fi
	done
done

#check for numerical day after natural month ending "th""st""nd""rd"
for i in "$@"
do
	if [[ $i =~ [0-9]st ]] || [[ $i =~ [0-9]nd ]] || [[ $i =~ [0-9]rd ]] || [[ $i =~ [0-9]th ]] || [[ $i =~ [0-9][0-9]st ]] || [[ $i =~ [0-9][0-9]nd ]] || [[ $i =~ [0-9][0-9]rd ]] || [[ $i =~ [0-9][0-9]th ]]; then
		mon_day_check=1
		mon_day_taskname=$i
		start_value_day=`echo $i | sed 's/st*//' | sed 's/nd*//' | sed 's/rd*//' | sed 's/th*//'`
		echo "Start value (day): "$start_value_day
		result_day=`echo "("$start_value_day"-1)" | bc`
		start_check=1
	fi
done


echo "Start check value (0/1): "$start_check
echo "Start date result (#months in days): "$result_mon
echo "Start date result (#days): "$result_day

#hidden feature for manual due date in this format: "d:#d" i.e. d:3d (for a 3 day due date)
#This is the only format for due dates right now, who cares though because you should be using
#START DATES!!! and a DAILY REVIEW!!! if not you need to GTD YO SHIT PLAYA!!
for i in "$@"
do
	due_formatted=`echo $i | tr A-Z a-z`
	if [[ $due_formatted =~ d:[0-9]d ]] || [[ $due_formatted =~ d:[0-9][0-9]d ]]; then
		due_num_days=`echo $i | sed -n 's/.*d:\(.*\)d.*/\1/p'`
		due_check=1
		due_taskname=`echo "d:"$due_num_days"d"`
	fi
done

if [ -z $due_num_days ]
then
	due_num_days=0
fi
echo "days until due: "$due_num_days
ddays=`echo ""$due_num_days"*$d" | bc`

#Check for a start date of Today
for i in "$@"
do
	today_formatted=`echo $i | tr A-Z a-z`
	if [ $today_formatted = "today" ]; then
		today_taskname=$i
		today=1
	fi
done
echo "Starts today? (0/1): "$today

#Check for a start date of Tomorrow
for i in "$@"
do
	tom_formatted=`echo $i | tr A-Z a-z`
	if [[ $tom_formatted = "tomorrow" ]] || [[ $i = "tom" ]]; then
		tom_taskname=$i
		tomorrow=1
	fi
done
echo "Starts tomorrow? (0/1): "$tomorrow

#check for week day name as start value
for i in "$@"
do
	day_formatted=`echo $i | tr A-Z a-z`
	for (( w=0;w<7;w++)); do
	    week_day_input=`echo ${Week_days[${w}]}`
		abbrv_day_input=`echo ${Abbrv_days[${w}]}`
		#My lovely wife came up with this elegant solution below:
		if [[ $day_formatted = "$week_day_input" ]] || [[ $day_formatted = "$abbrv_day_input" ]]; then
			weekday_check=1
			weekday_taskname=$i
			if [[ $w -ge $day_week ]]; then
				week_day_value=`echo ""$w"-$day_week" | bc`
				echo "Week day value passed: "$week_day_value
				start_check=1
			elif [[ $w -lt $day_week ]]; then
				week_day_value=`echo "("$wd"-$day_week)" | bc`
				echo "Week day value passed: "$week_day_value
				start_check=1
			fi
		fi
	done
done


#Find time #(am|pm) format and check for "noon"
for i in "$@"
do
	noon_formatted=`echo $i | tr A-Z a-z`
	if [[ $i =~ ^[0-9]am ]] ||  [[ $i =~ ^[0-9][0-9]am ]]; then
		time_check=1
		time_taskname=$i
		time_value=`echo $i | sed 's/am//'`
		start_check=1
	elif [[ $i =~ ^[0-9]:[0-9][0-9]am ]] ||  [[ $i =~ ^[0-9][0-9]:[0-9][0-9]am ]]; then
		time_check=1
		time_taskname=$i
		time_value=`echo $i | awk 'BEGIN { FS = ":" } ; { print $1}' | tr -dc '[0-9]'`
		start_check=1
	elif [[ $i =~ ^[0-9]pm ]] || [[ $i =~ ^[0-9][0-9]pm ]]; then
		time_check=1
		time_taskname=$i
		time_value_pm=`echo $i | sed 's/pm//'`
		time_value=`echo ""$time_value_pm"+$hr" | bc`
		if [[ $time_value = 24 ]]; then
			time_value=12
		fi
		start_check=1
	elif [[ $i =~ ^[0-9]:[0-9][0-9]pm ]] ||  [[ $i =~ ^[0-9][0-9]:[0-9][0-9]pm ]]; then
		time_check=1
		time_taskname=$i
		time_value_pm=`echo $i | awk 'BEGIN { FS = ":" } ; { print $1}' | tr -dc '[0-9]'`
		time_value=`echo ""$time_value_pm"+$hr" | bc`
		if [[ $time_value = 24 ]]; then
			time_value=12
		fi
		start_check=1
	elif [[ $noon_formatted =~ "noon" ]]; then
		time_value=12
		noon_check=1
		noon_taskname=$i
		start_check=1
	fi
done
echo "Start date (hours): "$time_value

#This on checks for a time : minutes
for i in "$@"
do
	if [[ $i =~ ^[0-9]:[0-9][0-9](am|pm) ]] || [[ $i =~ ^[0-9][0-9]:[0-9][0-9](am|pm) ]]; then
		minutes=`echo $i | awk 'BEGIN { FS = ":" } ; { print $2}' | tr -dc '[0-9]'`
		echo "Start date (minutes): "$minutes
		start_check=1
	fi
done
echo "Start date (minutes): "$minutes

#READ CONTEXTS FROM DB -- WORK IN PROGRESS
declare -a contextArray
if [ ! -d ~/Library/Caches/com.omnigroup.OmniFocus.MacAppStore/ ]; then
	contextArray=(`sqlite3 ~/Library/Caches/com.omnigroup.OmniFocus/OmniFocusDatabase2 'select name from context where parent is null;'`)
else
	contextArray=(`sqlite3 ~/Library/Caches/com.omnigroup.OmniFocus.MacAppStore/OmniFocusDatabase2 'select name from context where parent is null;'`)
fi
context_total=`echo ${#contextArray[*]}`
for i in "$@"
do
		for (( c=0;c<$context_total;c++ )); do
		if [[ $i = ${contextArray[$c]} ]]; then
			my_context=$i
		fi
	done
done

echo "Context Check (0/1): "$my_context_check
echo "Context used: "$my_context
if [ -z $my_context ]
then
	my_context_check=0
fi

#Rebuilt Code to construct the task name
echo "Raw task name: "$task_name
task_name=`echo $@`

if [[ $my_context_check -gt 0 ]]; then
	task_name=`echo $task_name | sed "s/$my_context//g"`
fi

if [[ $noon_check -gt 0 ]]; then
	task_name=`echo $task_name | sed "s/$noon_taskname//g"`
fi

if [[ $weekday_check -gt 0 ]]; then
	task_name=`echo $task_name | sed "s/$weekday_taskname//g"`
fi

if [[ $monthname_check -gt 0 ]]; then
	task_name=`echo $task_name | sed "s/$monthname_taskname//g"`
fi

if [[ $tomorrow -gt 0 ]]; then
	task_name=`echo $task_name | sed "s/$tom_taskname//g"`
fi

if [[ $today -gt 0 ]]; then
	task_name=`echo $task_name | sed "s/$today_taskname//g"`
fi

if [[ $time_check -gt 0 ]]; then
	task_name=`echo $task_name | sed "s/$time_taskname//g"`
fi

if [[ $mon_day_check -gt 0 ]]; then
	task_name=`echo $task_name | sed "s/$mon_day_taskname//g"`
fi

if [[ $abbrv_date_check -gt 0 ]]; then
	task_name=`echo $task_name | sed "s/$abbrv_date_taskname//g"`
fi

if [[ $due_check -gt 0 ]]; then
	task_name=`echo $task_name | sed "s/$due_taskname//g"`
fi

if [[ $num_date_check -gt 0 ]]; then
	task_name=`echo $task_name | sed 's/[0-9]*\/[0-9]*//g'`
fi

echo "Final task name: "$task_name		
echo "======================"

osascript <<EOS
	--Check if OF is running, if not then open it dumbass
	tell application "System Events"
	   count (every process whose name is "OmniFocus")
		if result < 1 then
		tell application "OmniFocus" to activate
		--Uncomment line below to hide OmniFocus when launched
 		--set visible of process "OmniFocus" to false
		end if
	end tell
	
  tell front document of application "OmniFocus"
	if "$my_context_check" > 0 then
	set theContext to "$my_context"
	set MyContextArray to null
	set MyContextArray to complete theContext as context maximum matches 1
	set MyContextID to id of first item of MyContextArray
	set ThisContext to context id MyContextID
	set theTask to make new inbox task with properties {name:"$task_name", context:ThisContext}
	else
	set theTask to make new inbox task with properties {name:"$task_name"}
	end if
	
	set theDate to (current date) - (time of (current date))
	
	
	if "$start_check" = "1" then
	set theDate to (current date) - (time of (current date)) + ("$day_counter" * days) + ("$NatMon_day_counter" * days) + ("$result_day" * days) + ("$th_num_days" * days)+ ("$week_day_value" * days) + ("$time_value" * hours) + ("$minutes" * minutes)
	set the start date of theTask to theDate	
	end if
	
	if "$sdays" > 0 then
	set theDate to current date
	set time of theDate to "$sdays"
	set the start date of theTask to theDate
	end if
	
	if "$ddays" > 0 then
	set theDate to current date
	set time of theDate to "$ddays"
	set the due date of theTask to theDate
	end if
	
	if "$today" = "1" then
		set theDate to (current date) - (time of (current date))
		set the start date of theTask to (theDate + (0 * hours)) + ("$time_value" * hours) + ("$minutes" * minutes)
	end if
	
	if "$tomorrow" = "1" then
		set theDate to (current date) - (time of (current date))
		set the start date of theTask to (theDate + (24 * hours)) + ("$time_value" * hours) + ("$minutes" * minutes)
	end if
	
 	end tell

	tell application "GrowlHelperApp"
	 	set the allNotificationsList to ¬
		  {"OmniFocusCLI"}
		 set the enabledNotificationsList to ¬
		  {"OmniFocusCLI"}
		 register as application "OmniFocusCLI" ¬
		   all notifications allNotificationsList ¬
		   default notifications enabledNotificationsList ¬
		   icon of application "OmniFocus"
		 notify with name "OmniFocusCLI" ¬
		   title "OmniFocus Inbox Task Created" ¬
		   description "Task: \"$task_name\"" ¬
		   application name "OmniFocusCLI" 
	end tell
EOS
