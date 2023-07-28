#Clear Proxmox Cache
#!/bin/bash
################################################

### PARAMETERS
while [ $# -gt 0 ]
    do
        case "$1" in
            # Option -e for "execute"
            -e)     execute="true"; shift;;
            # für alle anderen Optionen:
            -*)
                    echo >&2 \
                    "usage: linuxCleanup.sh [-e]"
                    exit 1;;
            # terminate while loop
            *)  break;;
            esac
        shift
done



### Cleaning up
clear



################################################
# Configuration section
# cleanup directories
cleanVarLog="yes"
cleanVarLogJournal="yes"
cleanVarLogSave="yes"
cleanVarLogJournalSave="yes"
cleanVarCacheE2fsck="yes"
cleanVarLibClamav="yes"
cleanEtcAptCache="yes"
# clean old kernels and boot
cleanOldKernels="yes"
# cleanup config files from removed packages
cleanRemovedConfigFiles="yes"
# cleanup via apt-command
cleanApt="yes"
# reduce the journal (e.g. truncate it)
reduceJournal="yes"
# size Journal is allowed to use
vacuumSize="100M"
################################################



if ! [[ "$execute" == "true" ]] ;
    then
        execute="false"
        echo "### RUNNING IN DRY RUN MODE - NOT ISSUING ANY COMMAND!"
    else
        echo "### CLEANING UP LINUX INSTALLATION"
fi



counter=0

#-------------------------------------------------------------------------------------

# /var/log
if [[ "$cleanVarLog" == "yes" ]] ;
    then
        myPath="/var/log"
        if [[ -d "$myPath" ]] ;
            then
                echo "Cleaning up >$myPath<"
                myPathContent=$null
                myPathContent=`sudo find $myPath`
                for file in $myPathContent ;
                    do
                        delete="false"
                        postdot=""
                        postdot=$(echo $file | rev | cut -d. -f1 | rev)
                        if [[ "$postdot" == "0" ]] ;
                            then
                                delete="true"
                        elif [[ "$postdot" == "1" ]] ;
                            then
                                delete="true"
                        elif [[ "$postdot" == "gz" ]] ;
                            then
                                delete="true"
                        fi
                        
                        # if a extension is detected to be cleaned up
                        if [[ "$delete" == "true" ]] ;
                            then
                                if [[ "$execute" == "true" ]] ;
                                    then
                                        #echo "delete >$file<"
                                        if ! [[ -d "$file" ]] ;
                                            then
                                                sudo rm -f "$file"
                                                counter=$(($counter+1))
                                        fi
                                    else
                                        echo "DRY: >$file< would be deleted."
                                fi
                        fi
                done
        fi
    else
        echo "# SKIPPING /var/log cleanup."
fi

#-------------------------------------------------------------------------------------

# reduce journal size
if [[ "$reduceJournal" == "yes" ]] ;
    then
        if [[ "$execute" == "true" ]] ;
            then
                sudo journalctl --vacuum-size=$vacuumSize
            else
                echo "DRY: would execute >sudo journalctl --vacuum-size=$vacuumSize<."
        fi
    else
        echo "# SKIPPING reduction of journal size reduction."
fi

#-------------------------------------------------------------------------------------

# /var/log/journal
if [[ "$cleanVarLogJournal" == "yes" ]] ;
    then
        myPath="/var/log/journal"
        if [[ -d "$myPath" ]] ;
            then
                echo "Cleaning up >$myPath<"
                myPathContent=$null
                myPathContent=`sudo find "$myPath" -mtime +3`
                for file in $myPathContent ;
                    do
                        if ! [[ -d "$file" ]] ;
                            then
                                if [[ "$execute" == "true" ]] ;
                                    then
                                        #echo "delete >$file<"
                                        sudo rm -f "$file"
                                        counter=$(($counter+1))
                                    else
                                        echo "DRY: >$file< would be deleted."
                                fi
                        fi
                done
        fi
    else
        echo "# SKIPPING /var/log/journal cleanup."
fi

#-------------------------------------------------------------------------------------

# /var/log.save
if [[ "$cleanVarLogSave" == "yes" ]] ;
    then
        myPath="/var/log.save"
        if [[ -d "$myPath" ]] ;
            then
                echo "Cleaning up >$myPath<"
                myPathContent=$null
                myPathContent=`sudo find $myPath`
                for file in $myPathContent ;
                    do
                        delete="false"
                        postdot=""
                        postdot=$(echo $file | rev | cut -d. -f1 | rev)
                        if [[ "$postdot" == "0" ]] ;
                            then
                                delete="true"
                        elif [[ "$postdot" == "1" ]] ;
                            then
                                delete="true"
                        elif [[ "$postdot" == "gz" ]] ;
                            then
                                delete="true"
                        fi
                        
                        if [[ "$delete" == "true" ]] ;
                            then
                                if [[ "$execute" == "true" ]] ;
                                    then
                                        #echo "delete >$file<"
                                        sudo rm -f "$file"
                                        counter=$(($counter+1))
                                    else
                                        echo "DRY: >$file< would be deleted."
                                fi
                        fi
                done
        fi
    else
        echo "# SKIPPING /var/log.save cleanup."
fi

#-------------------------------------------------------------------------------------

# /var/log.save/journal
if [[ "$cleanVarLogJournalSave" == "yes" ]] ;
    then
        myPath="/var/log.save/journal"
        if [[ -d "$myPath" ]] ;
            then
                echo "Cleaning up >$myPath<"
                myPathContent=$null
                myPathContent=`sudo find "$myPath" -mtime +3`
                for file in $myPathContent ;
                    do
                        if [[ "$execute" == "true" ]] ;
                            then
                                #echo "delete >$file<"
                                sudo rm -f "$file"
                                counter=$(($counter+1))
                            else
                                echo "DRY: >$file< would be deleted."
                        fi
                done
        fi
    else
        echo "# SKIPPING /var/log.save/journal cleanup."
fi

#-------------------------------------------------------------------------------------

# /var/cache/e2fsck
if [[ "$cleanVarCacheE2fsck" == "yes" ]] ;
    then
        myPath="/var/cache/e2fsck"
        if [[ -d "$myPath" ]] ;
            then
                echo "Cleaning up >$myPath<"
                myPathContent=$null
                myPathContent=`sudo find "$myPath" -mtime +3`
                for file in $myPathContent ;
                    do
                        if [[ "$execute" == "true" ]] ;
                            then
                                #echo "delete >$file<"
                                sudo rm -f "$file"
                                counter=$(($counter+1))
                            else
                                echo "DRY: >$file< would be deleted."
                        fi
                done
        fi
    else
        echo "# SKIPPING /var/cache/e2fsck cleanup."
fi

#-------------------------------------------------------------------------------------

# /var/lib/clamav
if [[ "$cleanVarLibClamav" == "yes" ]] ;
    then
        myPath="/var/lib/clamav"
        if [[ -d "$myPath" ]] ;
            then
                echo "Cleaning up >$myPath<"
                myPathContent=$null
                myPathContent=`sudo find "$myPath" -mtime +3`
                for file in $myPathContent ;
                    do
                        if [[ "$execute" == "true" ]] ;
                            then
                                #echo "delete >$file<"
                                sudo rm -f "$file"
                                counter=$(($counter+1))
                            else
                                echo "DRY: >$file< would be deleted."
                        fi
                done
        fi
    else
        echo "# SKIPPING /var/lib/clamav cleanup."
fi

#-------------------------------------------------------------------------------------

# /lib/modules AND /boot
if [[ "$cleanOldKernels" == "yes" ]] ;
    then
        kernelVersion=`uname -r`
        myPath="/lib/modules"
        echo "Cleaning up >$myPath<"
        myPathContent=$null
        myPathContent=`ls -1 "$myPath"`
        for item in $myPathContent ;
            do
                if ! [[ "$item" == "$kernelVersion" ]] ;
                    then
                        if [[ "$execute" == "true" ]] ;
                            then
                                #echo "delete >$myPath/$item<"
                                sudo rm -rf "$myPath/$item"
                                counter=$(($counter+1))
                            else
                                echo "DRY: >$myPath/$item< would be deleted."
                        fi
                        
                        #boot files
                        correspondingBootFiles=`sudo find /boot | grep $item`
                        for bootItem in $correspondingBootFiles ;
                            do
                                if [[ "$execute" == "true" ]] ;
                                    then
                                        #echo "delete >$bootItem<"
                                        sudo rm -f "$bootItem"
                                        counter=$(($counter+1))
                                    else
                                        echo "DRY: >$bootItem< would be deleted."
                                fi
                        done
                    else
                        echo "detected running kernel >$kernelVersion<."
                        break
                fi
        done

        # update grub after cleanup
        if [[ "$execute" == "true" ]] ;
            then
                echo "Updating grub"
                sudo update-grub
            else
                echo "DRY: would execute >sudo update grub<"
            fi
    else
        echo "# SKIPPING cleanup of old kernel and /lib/modules."
fi

#-------------------------------------------------------------------------------------

# Cleaning old configuration files of packages been removed
if [[ "$cleanRemovedConfigFiles" == "yes" ]] ;
    then
        echo "Cleaning up configuration files from removed packages"
        if [[ "$execute" == "true" ]] ;
            then
                sudo dpkg -l | awk '/^rc/{print $2}' | sudo xargs apt-get purge -y
            else
                echo "DRY: would execute >sudo dpkg -l | awk '/^rc/{print $2}' | sudo xargs apt-get purge -y<."
                echo "DRY: list of packages is"
                sudo dpkg -l | awk '/^rc/{print $2}'
        fi

    else
        echo "# SKIPPING cleanup of old config files of removed packages"
fi

#-------------------------------------------------------------------------------------

# Cleanup apt cache
if [[ "$cleanApt" == "yes" ]] ;
    then
        echo "Cleaning up apt-cache via apt-get"
        if [[ "$execute" == "true" ]] ;
            then
                sudo apt-get clean -y
                sudo apt-get autoremove -y
                # update grub after cleanup
                echo "Updating grub"
                sudo update-grub
            else
                echo "DRY: would execute >sudo apt-get clean -y<"
                echo "DRY: would execute >sudo apt-get autoremove -y<"
                echo "DRY: would execute >sudo update-grub<"
        fi
    else
        echo "# SKIPPING cleanup via apt-get"
fi

#-------------------------------------------------------------------------------------

# /etc/apt/cache
if [[ "$cleanApt" == "yes" ]] ;
    then
        myPath="/etc/apt/cache"
        echo "Cleaning up >$myPath<"
        if [[ -d "$myPath" ]] ;
            then
                myPathContent=$null
                myPathContent=`sudo find "$myPath/*"  -mtime +3`
                for item in $myPathContent ;
                    do
                        if [[ "$execute" == "true" ]] ;
                            then
                                #echo "delete >$item<"
                                sudo rm -f "$item"
                                counter=$(($counter+1))
                            else
                                echo "DRY: >$item< would be deleted."
                        fi
                done
        fi
    else
        echo "# SKIPPING /etc/apt/cache cleanup."
fi

#-------------------------------------------------------------------------------------

# Closing down
 if [[ "$execute" == "true" ]] ;
    then
        echo "Cleaned up >$counter< elements."
    else
        echo "DRY: system was not modified"
fi

echo "     Current state:"
sudo df -h /

.
