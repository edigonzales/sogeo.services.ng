LOAD spatial;

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