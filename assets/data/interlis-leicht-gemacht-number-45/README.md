```
java -jar /Users/stefan/sources/ili2db-duckdb/dist/ili2duckdb-5.2.2-SNAPSHOT.jar --dbfile arp_sein_processing.duckdb --nameByTopic --defaultSrsCode 2056 --strokeArcs --models SO_ARP_SEin_Konfiguration_20241217 --modeldir "." --dbschema sein_konfig --schemaimport
```

```
java -jar /Users/stefan/sources/ili2db-duckdb/dist/ili2duckdb-5.2.2-SNAPSHOT.jar --dbfile arp_sein_processing.duckdb --nameByTopic --defaultSrsCode 2056 --strokeArcs --models SO_ARP_SEin_Konfiguration_20241217 --modeldir "." --dbschema sein_konfig --import themen.xtf
```

```
java -jar /Users/stefan/sources/ili2db-duckdb/dist/ili2duckdb-5.2.2-SNAPSHOT.jar --dbfile arp_sein_processing.duckdb --nameByTopic --defaultSrsCode 2056 --strokeArcs --models SO_ARP_SEin_Konfiguration_20241217 --modeldir "." --dbschema sein_konfig --export themen_und_konfig.xtf
```



```
java -jar /Users/stefan/sources/ili2db-duckdb/dist/ili2duckdb-5.2.2-SNAPSHOT.jar --dbfile arp_sein_processing.duckdb --nameByTopic --defaultSrsCode 2056 --strokeArcs --createGeomIdx --disableValidation --models SO_Hoheitsgrenzen_Publikation_20170626 --dbschema agi_hoheitsgrenzen_pub --doSchemaImport --import ilidata:ch.so.agi.av.hoheitsgrenzen
```

```
java -jar /Users/stefan/sources/ili2db-duckdb/dist/ili2duckdb-5.2.2-SNAPSHOT.jar --dbfile sein_processing.duckdb --nameByTopic --defaultSrsCode 2056 --strokeArcs --createGeomIdx --disableValidation --createBasketCol --createTidCol --models ISOS_V2 --dbschema bak_isos --schemaimport 

java -jar /Users/stefan/sources/ili2db-duckdb/dist/ili2duckdb-5.2.2-SNAPSHOT.jar --dbfile sein_processing.duckdb --nameByTopic --defaultSrsCode 2056 --strokeArcs --disableValidation --createBasketCol --importTid --models ISOS_V2 --dbschema bak_isos --import /Users/stefan/Downloads/bundesinventar-schuetzenswerte-ortsbilder_2056.xtf/ISOS_Catalogues_V2_20220426.xml

# TODO: nur ISOSBase-Topic
java -jar /Users/stefan/sources/ili2db-duckdb/dist/ili2duckdb-5.2.2-SNAPSHOT.jar --dbfile sein_processing.duckdb --nameByTopic --defaultSrsCode 2056 --strokeArcs --disableValidation --createBasketCol --importTid --models ISOS_V2 --dbschema bak_isos --import /Users/stefan/Downloads/bundesinventar-schuetzenswerte-ortsbilder_2056.xtf/20240415-ISOS-XTF.xtf



```
