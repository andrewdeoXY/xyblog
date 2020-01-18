DROP SCHEMA IF EXISTS edw;
DROP SCHEMA IF EXISTS exposome_pici;
DROP TABLE IF EXISTS edw.fivehundredcities_data;
DROP TABLE IF EXISTS edw.fivehundredcities_data_2015_2016;
DROP TABLE IF EXISTS edw.shapefile_fivehundredcities_census_tracts;
DROP TABLE IF EXISTS edw.shapefile_fivehundredcities_census_tracts_2015_2016;
DROP TABLE IF EXISTS exposome_pici.shapefile;

CREATE SCHEMA edw;
CREATE SCHEMA exposome_pici;

CREATE TABLE edw.fivehundredcities_data(
	stateabbr TEXT,
	placename TEXT,
	fips_place_tract TEXT,
	"CANCER_CrudePrev" DOUBLE PRECISION,
	"CHD_CrudePrev" DOUBLE PRECISION,
	"STROKE_CrudePrev" DOUBLE PRECISION,
	"Geolocation" TEXT
);

CREATE TABLE edw.fivehundredcities_data_2015_2016(
	stateabbr TEXT,
	placename TEXT,
	fips_place_tract TEXT,
	"CANCER_CrudePrev" DOUBLE PRECISION,
	"CHD_CrudePrev" DOUBLE PRECISION,
	"STROKE_CrudePrev" DOUBLE PRECISION,
	"Geolocation" TEXT
);

CREATE TABLE edw.shapefile_fivehundredcities_census_tracts(
	stateabbr VARCHAR (50),
	placename VARCHAR (50),
	fips_place_tract VARCHAR (50),
	geometrywkt geometry,
	summarylevelid VARCHAR (50) NOT NULL
);

CREATE TABLE edw.shapefile_fivehundredcities_census_tracts_2015_2016(
	stateabbr VARCHAR (50) NOT NULL,
	placename VARCHAR (50) NOT NULL,
	fips_place_tract VARCHAR (50) NOT NULL,
	geometrywkt geometry,
	summarylevelid VARCHAR (50) NOT NULL
);

CREATE TABLE exposome_pici.shapefile(
	shape_id BIGINT,
	startdate timestamp,
	summarylevelid VARCHAR (50),
	statefip VARCHAR (50),
	fipcode VARCHAR (50),
	geometrywkt geometry
);

COPY edw.fivehundredcities_data("CANCER_CrudePrev","STROKE_CrudePrev","CHD_CrudePrev",stateabbr,placename,"Geolocation",fips_place_tract) FROM '/home/andrew/blogs/edw.fivehundredcities_data.tsv' DELIMITER E'\t' CSV HEADER;
COPY edw.fivehundredcities_data_2015_2016("CANCER_CrudePrev","STROKE_CrudePrev","CHD_CrudePrev",stateabbr,placename,"Geolocation",fips_place_tract) FROM '/home/andrew/blogs/edw.fivehundredcities_data_2015_2016.tsv' DELIMITER E'\t' CSV HEADER;
COPY edw.shapefile_fivehundredcities_census_tracts(geometrywkt,placename,stateabbr,fips_place_tract,summarylevelid) FROM '/home/andrew/blogs/edw.shapefile_fivehundredcities_census_tracts.tsv' DELIMITER E'\t' CSV HEADER;
COPY edw.shapefile_fivehundredcities_census_tracts_2015_2016(geometrywkt,placename,stateabbr,fips_place_tract,summarylevelid) FROM '/home/andrew/blogs/edw.shapefile_fivehundredcities_census_tracts_2015_2016.tsv' DELIMITER E'\t' CSV HEADER;
COPY exposome_pici.shapefile(statefip,fipcode,geometrywkt,summarylevelid,startdate) FROM '/home/andrew/blogs/exposome_pici.shapefile.tsv' DELIMITER E'\t' CSV HEADER;
