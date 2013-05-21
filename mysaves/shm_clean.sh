#!/bin/sh
#
# shm_clear: clean out unattached (NATTACH=0) shm segments.
# See ipcs(1) and ipcrm(1).  Tested on Linux and Solaris.
#
# Usage:
#    shm_clear      list and prompt for removal of your unattached shm segments.
#    shm_clear -y   assume "yes" to all the removal prompts.
#    shm_clear -l   only list (all of) your shm segments and exit.
#    shm_clear -y [name] only yes to the username

#set -xv
if echo "$1" | grep '^-h' > /dev/null; then
	# -h or -help
	tail +3 $0 | head -9
	exit
fi
NEW_GROUP_NAME=""
if [ "X$NEW_GROUP_NAME" = "X" ]; then
	NEW_GROUP_NAME=$LOGNAME
fi
l_arg="shmid.*owner|CREATOR|$NEW_GROUP_NAME"

# set up OS dependent cmdline opts, etc.
if [ `uname` = "Linux" ]; then
	m_arg="-m"
	r_arg="shm"
	g_arg="^0x"
	s_cmd="ipcs $m_arg -i %ID"
	awkcut='{print $2, $6}'
elif [ `uname` = "SunOS" ]; then
	m_arg="-ma"
	r_arg="-m"
	g_arg="^m"
	s_cmd="ipcs $m_arg | egrep '  %ID  |CREATOR' | grep -v IPC.status"
	awkcut='{print $2, $9}'
else
	echo unsupported OS: `uname`
	exit 1
fi

list() {
	if [ "X$1" = "X-L" ]; then
		l_arg="$l_arg|."
		echo "All shm segments for all:"
	else
		echo "All shm segments for $NEW_GROUP_NAME:"
	fi
	ipcs $m_arg | egrep "$l_arg"
	echo
}

show() {
	cmd=`echo "$s_cmd" | sed -e "s/%ID/$1/g"`
	eval $cmd
}

remove() {
	echo ipcrm $r_arg $1
	     ipcrm $r_arg $1
}

if [ "X$1" = "X-l" -o "X$1" = "X-L" ]; then
	# list only.  both attached and unattached listed.
	list $1
	exit 0
fi

if [ "X$1" = "X-y" ]; then
	shift
	yes=1	# assume "yes" to all delete questions.
  if [ "X$1" != "X" ]; then
    NEW_GROUP_NAME=$1
    echo 'GET PARAM NEW_GROUP_NAME:'$NEW_GROUP_NAME
  fi
else
	yes=""
fi

list
echo 'NEW_GROUP_NAME:'$NEW_GROUP_NAME
ids=`ipcs $m_arg | grep "$g_arg" | grep $NEW_GROUP_NAME | awk "$awkcut" | grep ' 0$' | awk '{print $1}'`
if [ "X$ids" = "X" ]; then
	echo "No unattached shmids for $NEW_GROUP_NAME."
fi

for id in $ids
do
	if [ $yes ]; then
		:
	else
		echo "-------------------------------------"
		show $id
		printf "\nDelete? [y]/n "
		read x
		if echo "$x" | grep -i n > /dev/null; then
			continue
		fi
	fi
	remove $id
done
