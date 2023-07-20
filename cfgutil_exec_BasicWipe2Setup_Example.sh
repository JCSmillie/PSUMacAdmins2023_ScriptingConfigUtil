# !/bin/zsh
#
# JCS - 7/15/23
#
# Example of CFGUTIL script.  This would be launched from 
# the command line as so-> /usr/local/bin/cfgutil exec -a /Users/Shared/blah/<thisscript>.sh
# to filter out all the junk.

# This scripts job would be to get an iPad into Restored state, drop a wifi profile on it,
# and then pass the iPad to DEP for the finish.
#
# NOTE THIS SCRIPT WILL KEEP RUNNING OVER AND OVER AGAIN UNTIL YOU PRESS CONTROL X..  This is because
# the starter line you used is effectively telling cfgutil to go into loop mode and execute the script
# everytime an iPad is connected.
# 
# 
#Profile to get iPad onto a temporary provisioning network.  DO NOT USE YOUR MAIN NETWORK.
#This profile can be exported from your MDM or created using Apple Configurator2 before hand.
#TEMPORARYWIFIPROFILE="/Users/jsmillie//GitHub/CustomProfiles/SmillieWifiAutoJoinProfile-Signed.mobileconfig"
TEMPORARYWIFIPROFILE="/Users/presenter/Desktop/TempProfilePresentation.mobileconfig"

#Restore device which is connected.
####NOTE THIS WILL ONLY WORK ON A DEVICE YOUR MACHINE HAS TRUST WITH
bash -c "/usr/local/bin/cfgutil --ecid "$ECID" restore"  2>/dev/null 

#Install Wifi Profile 
####NOTE THIS WILL ALSO ACTIVATE THE DEVICE 
bash -c "/usr/local/bin/cfgutil --ecid "$ECID" install-profile $TEMPORARYWIFIPROFILE" 2>/dev/null

#Call up Apple and get the relay to your MDM.  MDM takes over.
bash -c "/usr/local/bin/cfgutil --ecid "$ECID" prepare --dep --skip-language --skip-region"  2>/dev/null


#just making sure we have a clean break at the end of this script.
exit 0




