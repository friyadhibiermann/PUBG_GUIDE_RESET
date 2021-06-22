#!/data/data/com.termux/files/usr/bin/bash
req(){
pkg update
pkg install sqlite jq
}
req
start_ran(){
random_huruf_angka(){
tr -dc A-Za-z0-9 </dev/urandom | head -c $1 ; echo ''
}
random_angka(){
tr -dc 0-9 </dev/urandom | head -c $1 ; echo ''
}
random_huruf(){
tr -dc A-Za-z0-9 </dev/urandom | head -c $1 ; echo ''
}
case $1 in
	"AH")
	random_huruf_angka $2
	;;
	"A")
	random_angka $2
	;;
	"H")
	random_huruf $2
	;;
	*)
esac
}
loginDB(){
sqlite3 -json /data/data/com.tencent.ig/databases/iMSDK.db "select * from login_info" |\
 sed 's/\\//g; s/\"{/{/g; s/}"/}/g ' | jq $1
}
#-------------------------------------------------------------------------------------------------------------------
read -p "anda yakin ingin reset akun guide PUBG-M ? :" YES
if [ $YES == 'y'] || [ $YES == 'yes' ] || [ $YES == 'Y' ] || [ $YES == "YES"];then
set_path="/data/data/com.tencent.ig"
#CLEAR_CACHE
rm $set_path/cache/*.tmp > /dev/null 2>&1
rm $set_path/cache/volley/* > /dev/null 2>&1
echo "cache selesai"
#CHANGE STRING
imsdk_s="imsdk_settings.xml"
imsdk_st="AH"
imsdk_sn="32"
imsdk_sp="${set_path}/shared_prefs/$imsdk_s"
imsdk_sd=`cat $imsdk_sp |\
 awk -F'>' '{print $2}' |\
 awk -F'<' '{print $1}' |\
 grep '[0-9]'`
chimsdk_s=$(start_ran $imsdk_st $imsdk_sn)
if [ -z $imsdk_sd ];then
sed -i "s/${imsdk_sd}/${chimsdk_s}/g" $imsdk_sp
fi
echo "imsdk setting selesai"
#------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------
iMSDK="/data/data/com.tencent.ig/databases/iMSDK.db"
#iExtTokenExpireTime
numberiExtTokenExpireTime=$(loginDB '.[].metadata.iExtTokenExpireTime')
LenghtiExtTokenExpireTime=${#numberiExtTokenExpireTime}
CnumberiExtTokenExpireTime=$(start_ran A $LenghtiExtTokenExpireTime)
sed -i "s/$numberiExtTokenExpireTime/$CnumberiExtTokenExpireTime/g" $iMSDK
echo "iExtTokenExpireTime =$numberiExtTokenExpireTime"
echo "Ubah iExtTokenExpireTime =$(start_ran A $LenghtiExtTokenExpireTime)"
echo ""
#sChannelId
numbersChannelId=$(loginDB '.[].metadata.sChannelId' | sed 's/\"//g')
LenghtsChannelId=${#numbersChannelId}
CnumbersChannelId=$(start_ran AH $LenghtsChannelId)
sed -i "s/$numbersChannelId/$CnumbersChannelId/g" $iMSDK
echo "sChannelId = $numbersChannelId"
echo "ubah sChannelId = $CnumbersChannelId"

#iChannel
numberiChannel=$(loginDB '.[].metadata.iChannel' | sed 's/\"//g')
LenghtiChannel=${#numberiChannel}
CnumberiChannel=$(start_ran A $LenghtiChannel)
sed -i "s/$numberiChannel/$CnumberiChannel/g" $iMSDK
echo "numberiChannel = $numberiChannel"
echo "ubah iChannel = $CnumberiChannel"

#iGameId
numberiGameId=$(loginDB '.[].metadata.iGameId' | sed 's/\"//g')
LenghtiGameId=${#numberiGameId}
CnumberiGameId=$(start_ran A $LenghtiGameId)
sed -i "s/$numberiGameId/$CnumberiGameId/g" $iMSDK
echo "iGameId = $numberiGameId"
echo "ubah iGameId = $CnumberiGameId"

#iGuid
numberiGuid=$(loginDB '.[].metadata.iGuid' | sed 's/\"//g')
LenghtiGuid=${#numberiGuid}
CnumberiGuid=$(start_ran A $LenghtiGuid)
sed -i "s/$numberiGuid/$CnumberiGuid/g" $iMSDK
echo "iGuid = $numberiGuid"
echo "ubah iGuid = $CnumberiGuid"

#sUserName
numbersUserName=$(loginDB '.[].metadata.sUserName' | awk -F'_' '{print $2}'  | sed 's/\"//g')
LenghtsUserName=${#numbersUserName}
CnumbersUserName=$(start_ran A $LenghtsUserName | sed 's/\"//g')
sed -i "s/$numbersUserName/$CnumbersUserName/g" $iMSDK
echo "numbersUserName = $numbersUserName"
echo "ubah CnumbersUserName = $CnumbersUserName"

#sInnerToken
numbersInnerToken=$(loginDB '.[].metadata.sInnerToken' | sed 's/\"//g')
LenghtsInnerToken=${#numbersInnerToken}
CnumbersInnerToken=$(start_ran AH $LenghtsInnerToken)
sed -i "s/$numbersInnerToken/$CnumbersInnerToken/g" $iMSDK
echo "sInnerToken = $numbersInnerToken"
echo "ubah sInnerToken = $CnumbersInnerToken"

#iExpireTime
numberiExpireTime=$(loginDB '.[].metadata.iExpireTime ' | sed 's/\"//g')
LenghtiExpireTime=${#numberiExpireTime}
CnumberiExpireTime=$(start_ran A $LenghtiExpireTime)
sed -i "s/$numberiExpireTime/$CnumberiExpireTime/g" $iMSDK
echo "iExpireTime = $numberiExpireTime"
echo "ubah numberiExpireTime = $CnumberiExpireTime"

#iOpenid
numberiOpenid=$(sqlite3 -json /data/data/com.tencent.ig/databases/iMSDK.db "select * from login_info" | sed 's/\\//g; s/\"{/{/g; s/}"/}/g ' | jq '.[].metadata.iOpenid' |  sed 's/\"//g')
LenghtiOpenid=${#numberiOpenid}
CnumberiOpenid=$(start_ran A $LenghtiOpenid)
sed -i "s/$numberiOpenid/$CnumberiOpenid/g" $iMSDK
echo "iOpenid = $numberiOpenid"
echo "ubah iOpenid = $CnumberiOpenid"
#firstLoginTag
sed -i "s/\"firstLoginTag\":0/\"firstLoginTag\":1/g" $iMSDK
echo "firsttag `loginDB '.[].metadata.firstLoginTag'`"
#--------------------------------------------------------------------------------------------------------------------
#APMCfg.xml
pathshared_prefs="/data/data/com.tencent.ig/shared_prefs"
file="/data/data/com.tencent.ig/shared_prefs/APMCfg.xml"
VAL=`echo $(grep -oP '(?<=value=\")[^</\"\>]+' "$file") | sed 's/-//g'`
for i in $VAL;do
if [ $i -ne '1' ];then
	N=${#i}
	echo "sebelum $i"
	NC=$(start_ran A $N)
	sed -i "s/$i/$NC/g" $file
	echo "sesudah $NC"
fi
done
#APMCfg.xml apm_user_name
apm_user_name=`echo $(grep -oP '(?<=apm_user_name">)[^</]+' "$file") | sed 's/-//g'`
N=${#apm_user_name}
Capm_user_name=$(start_ran A $N)
sed -i 's/$apm_user_name/$Capm_user_name/g' $file
echo "apm_user_name  = $apm_user_name"
echo "ubah apm_user_name = $Capm_user_name"
#APMCfg.xml apm_uuid_str
apm_uuid_str=`echo $(grep -oP '(?<=apm_uuid_str">)[^</\"\>]+' "$file") | awk -F'-' '{print $1}'`
N=${#apm_uuid_str}
Capm_uuid_str=$(start_ran AH $N)
sed -i 's/$apm_uuid_str/$Capm_uuid_str/g' $file
echo "apm_uuid_str = $apm_uuid_str"
echo "ubah apm_uuid_str = $Capm_uuid_str"
#APMCfg.xml apm_linked_uuid
apm_linked_uuid=`echo $(grep -oP '(?<=apm_linked_uuid">)[^</\"\>]+' "$file") | awk -F'-' '{print $1}'`
N=${#apm_linked_uuid}
Capm_linked_uuid=$(start_ran AH $N)
sed -i "s/$apm_linked_uuid/$Capm_linked_uuid/g" $file
echo "apm_linked_uuid =$apm_linked_uuid"
echo "ubah apm_linked_uuid = $Capm_linked_uuid "

#GCloudCoreSP.xml
file="/data/data/com.tencent.ig/shared_prefs/GCloudCoreSP.xml"
GCloudCoreSP=`echo $(grep -oP '(?<=GCloud.config">)[^<\"\>]+' "$file") | awk -F'=' '{print $1}'`
echo $GCloudCoreSP | if grep -q '/';then
GCloudCoreSP=`echo $(grep -oP '(?<=GCloud.config">)[^<\"\>]+' "$file") | awk -F'=' '{print $1}' | awk -F'/' '{print $NF}'`
else
GCloudCoreSP=`echo $(grep -oP '(?<=GCloud.config">)[^<\"\>]+' "$file") | awk -F'=' '{print $1}'`
fi

N=${#GCloudCoreSP}
CGCloudCoreSP=$(start_ran AH $N)
sed -i  "s/$GCloudCoreSP/$$CGCloudCoreSP/g" $file
echo "GCloudCoreSP = $GCloudCoreSP"
echo "rubah GCloudCoreSP = $CGCloudCoreSP"

#GCloudCoreSP.xml Gremote
Gremote=`echo $(grep -oP '(?<=RemoteConfig.config">)[^<\"\>]+' "$file") | awk -F'=' '{print $1}' `
echo $Gremote | if grep -q '/';then
Gremote=`echo $(grep -oP '(?<=RemoteConfig.config">)[^<\"\>]+' "$file") | awk -F'=' '{print $1}' | awk -F'/' '{print $NF}'`
else
Gremote=`echo $(grep -oP '(?<=RemoteConfig.config">)[^<\"\>]+' "$file") | awk -F'=' '{print $1}' `
fi
N=${#Gremote}
CGremote=$(start_ran AH $N)
sed -i "s/$Gremote/$CGremote/g" $file
echo "Gremote = $Gremote"
echo "ubah Gremote  = $CGremote"
#------------------------------------------------------------------------------------------------------------------------------------------------------
#device_id.xml
file="/data/data/com.tencent.ig/shared_prefs/device_id.xml"
device_idInstall=`echo $(grep -oP '(?<=install">)[^<\"\>]+' "$file") | awk -F'=' '{print $1}' `
N=${#device_idInstall}
Cdevice_idInstall=$(start_ran AH $N)
sed -i "s/$device_idInstall/$Cdevice_idInstall/g" $file
echo "device_idInstall = $device_idInstall"
echo "rubah device_idInstall = $device_idInstall"

device_uuid=`echo $(grep -oP '(?<=uuid">)[^<\"\>]+' "$file") | awk -F'=' '{print $1}' `
N=${#device_uuid}
Cdevice_uuid=$(start_ran AH $N)
sed -i "s/$device_uuid/$Cdevice_uuid/g" $file
echo "device_uuid = $device_uuid"
echo "rubah device_uuid = $Cdevice_uuid"
#------------------------------------------------------------------------------------------------------------------------------------------------------
#gsdk_prefs.xml
file="/data/data/com.tencent.ig/shared_prefs/gsdk_prefs.xml"
open_id=`echo $(grep -oP '(?<=open_id">)[^<\"\>]+' "$file") | awk -F'=' '{print $1}'`
N=${#open_id}
Copen_id=$(start_ran A $N)
sed -i "s/$open_id/$Copen_id/g" $file
echo "open_id = $open_id"
echo "rubah open_id = $Copen_id"
#-------------------------------------------------------------------------------------------------------------------------------------------------------
#adjust_preferences.xml
file="/data/data/com.tencent.ig/shared_prefs/adjust_preferences.xml"
push_token=`echo $(grep -oP '(?<=push_token">)[^<\"\>]+' "$file") | awk -F'=' '{print $1}'`
N=${#push_token}
Cpush_token=$(start_ran AH $N)
sed -i "s/$push_token/$Cpush_token/g" $file
echo "push_token = $push_token"
echo "rubah push_token = $Cpush_token"
#-------------------------------------------------------------------------------------------------------------------------------------------------------
#admob.xml
file="/data/data/com.tencent.ig/shared_prefs/admob.xml"
app_last_background_time_ms=`echo $(grep -oP '(?<=value=")[^<\"\>]+' "$file") | awk -F'=' '{print $1}'`
N=${#app_last_background_time_ms}
Capp_last_background_time_ms=$(start_ran A $N)
sed -i "s/$app_last_background_time_ms/$Capp_last_background_time_ms/g" $file
echo "app_last_background_time_ms = $app_last_background_time_ms"
echo "rubah app_last_background_time_ms = $Capp_last_background_time_ms"
else
echo "membatalkan perintah/ tulis Y YES y atau yes"
fi
