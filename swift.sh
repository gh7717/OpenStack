#/usr/bin/env bash

#magic numbers
bytes=0
TB=1099511627776

#credentials
user="test"
password="test"
tenant="test-swift"
url="http://172.16.5.2:5000/v2.0/"

#limits = 25 TB

limit=25

for i in `swift list --os-username=$user --os-password=$password --os-tenant-name=$tenant --os-auth-url=$url`
  do
    tmp=`swift stat $i --os-username=$user --os-password=$password --os-tenant-name=$tenant --os-auth-url=$url | grep Bytes | awk {'print $2'}`
    let "bytes= bytes + tmp"
  done
let "size=bytes/TB"
if [ "$size"  -lt "$limit" ]; then
  exit 0
else
  exit 1
fi

