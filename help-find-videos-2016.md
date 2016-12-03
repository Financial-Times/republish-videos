```
db.content.find({"identifiers": {"$elemMatch": {"authority": "http://api.ft.com/system/BRIGHTCOVE"}}, "publishedDate":{$regex:/^2016/}}, {_id:0, uuid:1, publishedDate:1})

[3:24]  
in more depth:

[3:24]  
i made this find-videos-2016.js
rs.slaveOk()
db.content.find({"identifiers": {"$elemMatch": {"authority": "http://api.ft.com/system/BRIGHTCOVE"}}, "publishedDate":{$regex:/^2016/}}, {_id:0, uuid:1, publishedDate:1}).toArray()
(edited)

[3:25]  
then i uploaded the script on mongo container 
scp find-videos-2016.js core@52.18.xyz.127:/tmp/find-videos-2016.js

[3:26]  
docker cp /tmp/find-videos-2016.js xxxx3e98af4b:/tmp/find-videos-2016.js

[3:26]  
then i ran it

[3:26]  
docker exec xxxxe98af4b sh -c "mongo localhost:27017/upp-store < /tmp/find-videos-2016.js" > /tmp/videos-2016.txt

[3:27]  
then i copied it out to my laptop 
scp core@52.18.xxx.127:/tmp/videos-2016.txt ./videos-2016.txt

[3:27]  
then i extracted the uuids from inside to be just lines containing uuids 
grep uuid videos-2016.json | sed -n 's/.*: "\(.*\)",/\1/p;w videos-2016-uuids.txt'

[3:28]  
now i have a file starting like this
24044162-3ee1-3add-84e3-1d3e016fc912
e23d8bda-8737-3f40-8ab4-42a3389f21a0
03382b56-1b40-3c06-8777-58332ec2f1ec
1f9bf5dc-6a2b-3819-83e0-6a0e7b6e4342
931f794f-c409-3aa9-840b-bfd1491c1643
f9bc2036-86ce-3097-8f2c-363eaac81ed6
fa0fd9c0-a9b1-32b3-b280-274ce5a10e89
c6cfb6dd-436a-30c6-87a8-3e06e2b6179d
d693c5e3-8f42-3086-b255-6ea55912cba3
e6b4e12f-f04a-3e67-80b3-9d5246170ece

[3:28]  
i can put this list in the jenkins job
```