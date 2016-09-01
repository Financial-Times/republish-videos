# Video republishing script

```
# jump on a secondary mongo machine
fleetctl ssh mongodb@2.service

# obtain public ip of mongo machine
curl http://169.254.169.254/latest/meta-data/public-ipv4

# in another shell copy the mongo script to the mongo machine
scp find-videos.js core@52.18.122.127:/tmp/find-videos.js

# obtain mongo container id
docker ps | grep mongo

# copy the script to the mongo container
docker cp /tmp/find-videos.js 60553e98af4b:/tmp/find-videos.js

# run the query - Attention!
docker exec 60553e98af4b sh -c "mongo localhost:27017/upp-store < /tmp/find-videos.js" > /tmp/videos.txt

# tar the result file
tar -czvf videos.tar.gz videos.txt

# in another shell copy results to local machine
scp core@52.18.122.127:/tmp/videos.tar.gz ./videos.tar.gz

# untar results file
tar -xzvf videos.tar.gz

# strip first and last bits of the results file, to make it a valid json.
sed '1,2d;$d' videos.txt > videos-cut.txt
mv videos-cut.txt videos.txt

# exctract only video identifiers
cat videos.txt | jq '.[].identifiers[].identifierValue' > identifiers.txt

# republish - Attention!!
ruby republish-videos.rb pub-prod-uk identifiers.txt
```
