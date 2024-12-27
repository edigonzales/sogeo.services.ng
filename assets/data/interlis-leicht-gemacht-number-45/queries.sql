LOAD spatial;

--######################################################################################
--TODO: separate Datei
DELETE FROM 
	sein_konfig.sein_thema_gemeinde; 

DELETE FROM 
	sein_konfig.sein_gemeinde; 

--######################################################################################

INSERT INTO 
	sein_konfig.sein_gemeinde
	(
		aname,
		bfsnr
	)
	SELECT 
		gemeindename,
		bfs_gemeindenummer
	FROM 
		agi_hoheitsgrenzen_pub.hoheitsgrenzen_gemeindegrenze 
	WHERE 
		bfs_gemeindenummer = ${bfsnr}
;

--######################################################################################
-- Amphibienlaichgebiete ortsfeste Objekte

CREATE TEMP TABLE t_betroffen AS 
WITH gemeinde AS 
(
	SELECT 
		g2.t_id AS gemeinde_t_id,
		gemeindename,
		bfs_gemeindenummer,
		geometrie 
	FROM 
		agi_hoheitsgrenzen_pub.hoheitsgrenzen_gemeindegrenze AS g1
		INNER JOIN sein_konfig.sein_gemeinde AS g2
		ON g1.bfs_gemeindenummer = g2.bfsnr
	WHERE 
		bfs_gemeindenummer = ${bfsnr}
)
,
themadaten AS 
(
	SELECT 
		ST_Multi(geom) AS geom
	FROM 
	ST_Read('/Users/stefan/Downloads/data/Amphibien_LV95/amphibLaichgebiet.shp', spatial_filter_box={min_x: 2590925, min_y: 1212325, max_x: 2645288, max_y: 1263441}::BOX_2D)

)
,
thema AS 
(
	SELECT 
		t_id AS thema_t_id
	FROM 
		sein_konfig.sein_thema 
	WHERE
		karte = 'ch.bafu.bundesinventare-amphibien'
)
,
betroffen AS
(
	SELECT 
		gemeinde.gemeinde_t_id,
		gemeinde.gemeindename,
		gemeinde.bfs_gemeindenummer,
		ist_betroffen,
		thema.thema_t_id
	FROM 
	(
		SELECT 
			count(*) > 0 AS ist_betroffen
		FROM 
			gemeinde 
			INNER JOIN themadaten 
			ON ST_Overlaps(gemeinde.geometrie, themadaten.geom)
	) AS foo
	LEFT JOIN gemeinde
	ON 1=1
	LEFT JOIN thema 
	ON 1=1
)
SELECT
	*
FROM 
	betroffen
;

INSERT INTO sein_konfig.sein_thema_gemeinde 
(
	thema_r,
	gemeinde_r,
	ist_betroffen
)
SELECT 
	thema_t_id,
	gemeinde_t_id,
	ist_betroffen
FROM 
	t_betroffen
;

DROP TABLE 
	t_betroffen
;

--######################################################################################
-- Amphibienlaichgebiete Wanderobjekte

CREATE TEMP TABLE t_betroffen AS 
WITH gemeinde AS 
(
	SELECT 
		g2.t_id AS gemeinde_t_id,
		gemeindename,
		bfs_gemeindenummer,
		geometrie 
	FROM 
		agi_hoheitsgrenzen_pub.hoheitsgrenzen_gemeindegrenze AS g1
		INNER JOIN sein_konfig.sein_gemeinde AS g2
		ON g1.bfs_gemeindenummer = g2.bfsnr
	WHERE 
		bfs_gemeindenummer = ${bfsnr}
)
,
themadaten AS 
(
	SELECT 
		ST_Multi(geom) AS geom
	FROM 
	ST_Read('/Users/stefan/Downloads/data/Amphibien_LV95/amphibWanderobjekt.shp', spatial_filter_box={min_x: 2590925, min_y: 1212325, max_x: 2645288, max_y: 1263441}::BOX_2D)

)
,
thema AS 
(
	SELECT 
		t_id AS thema_t_id
	FROM 
		sein_konfig.sein_thema 
	WHERE
		karte = 'ch.bafu.bundesinventare-amphibien_wanderobjekte'
)
,
betroffen AS
(
	SELECT 
		gemeinde.gemeinde_t_id,
		gemeinde.gemeindename,
		gemeinde.bfs_gemeindenummer,
		ist_betroffen,
		thema.thema_t_id
	FROM 
	(
		SELECT 
			count(*) > 0 AS ist_betroffen
		FROM 
			gemeinde 
			INNER JOIN themadaten 
			ON ST_Overlaps(gemeinde.geometrie, themadaten.geom)
	) AS foo
	LEFT JOIN gemeinde
	ON 1=1
	LEFT JOIN thema 
	ON 1=1
)
SELECT
	*
FROM 
	betroffen
;

INSERT INTO sein_konfig.sein_thema_gemeinde 
(
	thema_r,
	gemeinde_r,
	ist_betroffen
)
SELECT 
	thema_t_id,
	gemeinde_t_id,
	ist_betroffen
FROM 
	t_betroffen
;

DROP TABLE 
	t_betroffen
;

--######################################################################################
-- ISOS

CREATE TEMP TABLE t_betroffen AS 
WITH gemeinde AS 
(
	SELECT 
		g2.t_id AS gemeinde_t_id,
		gemeindename,
		bfs_gemeindenummer,
		geometrie 
	FROM 
		agi_hoheitsgrenzen_pub.hoheitsgrenzen_gemeindegrenze AS g1
		INNER JOIN sein_konfig.sein_gemeinde AS g2
		ON g1.bfs_gemeindenummer = g2.bfsnr
	WHERE 
		bfs_gemeindenummer = ${bfsnr}
)
,
themadaten AS 
(
	SELECT 
		koordinaten AS geom
	FROM 
		bak_isos.isosbase_ortsbild
)
,
thema AS 
(
	SELECT 
		t_id AS thema_t_id
	FROM 
		sein_konfig.sein_thema 
	WHERE
		karte = 'ch.bak.bundesinventar-schuetzenswerte-ortsbilder'
)
,
betroffen AS
(
	SELECT 
		gemeinde.gemeinde_t_id,
		gemeinde.gemeindename,
		gemeinde.bfs_gemeindenummer,
		ist_betroffen,
		thema.thema_t_id
	FROM 
	(
		SELECT 
			count(*) > 0 AS ist_betroffen
		FROM 
			gemeinde 
			INNER JOIN themadaten 
			ON ST_Intersects(gemeinde.geometrie, themadaten.geom)
	) AS foo
	LEFT JOIN gemeinde
	ON 1=1
	LEFT JOIN thema 
	ON 1=1
)
SELECT
	*
FROM 
	betroffen
;

INSERT INTO sein_konfig.sein_thema_gemeinde 
(
	thema_r,
	gemeinde_r,
	ist_betroffen
)
SELECT 
	thema_t_id,
	gemeinde_t_id,
	ist_betroffen
FROM 
	t_betroffen
;

DROP TABLE 
	t_betroffen
;


--DROP SCHEMA bak_isos CASCADE;
