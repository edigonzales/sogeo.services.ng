python -m venv .venv
source .venv/bin/activate
pip install pandas
pip install setuptools
pip install openpyxl

pyspark --packages org.apache.iceberg:iceberg-spark-runtime-3.5_2.12:1.7.1 < to_excel.py

------------

https://github.com/duckdb/duckdb-iceberg/issues/29
https://github.com/duckdb/duckdb-iceberg/issues/16

```
INSTALL iceberg;
LOAD iceberg;

SELECT count(*)
FROM iceberg_scan('/Users/stefan/tmp/warehouse/agem_steuerfuesse/natuerliche_personen', allow_moved_paths = true) AS f;

SELECT *
FROM iceberg_metadata('/Users/stefan/tmp/warehouse/agem_steuerfuesse/natuerliche_personen', allow_moved_paths = true);

SELECT *
FROM iceberg_snapshots('/Users/stefan/tmp/warehouse/agem_steuerfuesse/natuerliche_personen');

SELECT 
	*
FROM 
	iceberg_scan('/Users/stefan/tmp/warehouse/agem_steuerfuesse/natuerliche_personen', allow_moved_paths = true)
WHERE
	jahr = 2000

INSTALL spatial;
LOAD spatial;

CREATE TEMP TABLE myresult AS
WITH steuern AS (
	SELECT
		*
	FROM 
		iceberg_scan('/Users/stefan/tmp/warehouse/agem_steuerfuesse/natuerliche_personen', allow_moved_paths = true)
)
SELECT 
	gemndname,
	ST_Area(geom),
	steuerfuss_in_prozent
FROM 
	ST_Read('/vsizip//vsicurl/https://files.geo.so.ch/ch.so.agi.av.hoheitsgrenzen/aktuell/ch.so.agi.av.hoheitsgrenzen.shp.zip', layer='gemeindegrenze') AS g
	LEFT JOIN steuern 
	ON g.gemndname = steuern.gemeinde
;	
COPY (SELECT * FROM myresult) TO '/Users/stefan/tmp/myresult.xlsx' WITH (FORMAT GDAL, DRIVER 'xlsx');
```

------------

ABAC:
Warum Ranger nicht genügt: https://trino.io/assets/blog/trino-summit-2023/opa-trino.pdf

```
docker compose up
```

```
java -jar /Users/stefan/apps/ili2pg-5.1.1/ili2pg-5.1.1.jar --dbhost localhost --dbport 54322 --dbdatabase pub --dbusr postgres --dbpwd secret --nameByTopic --defaultSrsCode 2056 --strokeArcs --disableValidation --models SO_Hoheitsgrenzen_Publikation_20170626 --dbschema agi_hoheitsgrenzen_pub_v1 --doSchemaImport --import ilidata:ch.so.agi.av.hoheitsgrenzen
```

```
SELECT
	ST_Area(geometrie),
	*
FROM 
	pg_pub.agi_hoheitsgrenzen_pub_v1.hoheitsgrenzen_gemeindegrenze hg 
	
SELECT
	np.gemeinde,
	ST_Area(hg.geometrie),
	np.steuerfuss_in_prozent
FROM 
	pg_pub.agi_hoheitsgrenzen_pub_v1.hoheitsgrenzen_gemeindegrenze AS hg 
	LEFT JOIN iceberg.agem_steuerfuesse.natuerliche_personen AS np 
	ON np.gemeinde = hg.gemeindename
WHERE 
  jahr = 2000
;
```

java -jar trino-cli-468-executable.jar http://localhost:8080 --file=query.sql --output-format=CSV > myresult.csv

-----------

pyiceberg -> to_pandas()
