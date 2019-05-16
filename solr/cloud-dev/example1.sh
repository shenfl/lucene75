#!/bin/bash

cd ..

rm -r -f example2

rm -r -f dist
rm -r -f build
rm -r -f example/solr/zoo_data
rm -r -f example/solr/collection1/data
rm -f example/example.log

ant server dist

cp -r -f example example2


cd example
java -DzkRun -DnumShards=2 -DSTOP.PORT=7983 -DSTOP.KEY=key -Dbootstrap_conf=true -jar start.jar 1>example.log 2>&1 &

sleep 10

cd ../example2
java -Djetty.port=9574 -DzkRun -DzkHost=localhost:9983 -DSTOP.PORT=6574 -DSTOP.KEY=key -jar start.jar 1>example2.log 2>&1 &


