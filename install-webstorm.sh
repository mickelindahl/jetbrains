#!/bin/bash

if [ -z $1 ];then
  echo "Argument missing"
  echo "Run as: ./install-webstorm  Webstorm-XXXX.X.X.tar.gx"
  exit 1
fi

echo "Find path to unpacked webstorm"
tar -tf WebStorm-2019.1.1.tar.gz > tmp
line=$(head -n 1 tmp)
IFS='/' read -r -a array <<< $line
webstorm_path=${array[0]}
echo "Path found  $webstorm_path"

if [ ! -d $webstorm_path ];then

   echo "Unpacking $1..."
   tar -zxf $1
   echo "Unpacking done"

else
   echo "$1 is already unpacked skipping"
fi

echo "Enter $webstorm/bin"
cd $webstorm_path/bin

echo "Set new desktop icon and path"
echo "Edit ~/.local/share/applications/jetbrains-webstorm.desktop"

DESKTOP="$(echo ~)/.local/share/applications/jetbrains-webstorm.desktop"
TMP=`grep -r "Icon=" $DESKTOP`
CHANGE="Icon=$(pwd)/webstorm.svg"

echo "Changing $TMP -> $CHANGE"
sed -i "s#$TMP#$CHANGE#g" $DESKTOP

TMP=`grep -r "Exec=" $DESKTOP`
CHANGE='Exec="'$(pwd)'/webstorm.sh" %f'

echo "Changing $TMP -> $CHANGE"
sed -i "s#$TMP#$CHANGE#g" $DESKTOP


echo "Install webstorm ..."
./webstorm.sh


