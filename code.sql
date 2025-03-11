create or replace file format my_csv_ff
type = csv,
record_delimiter = '\n'
field_delimiter = ","
skip_header = 1,
null_if = ('NULL', 'null'),
empty_field_as_null = TRUE,
  FIELD_OPTIONALLY_ENCLOSED_BY = '0x22';

create or replace storage integration s3_int3
 TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = s3
    ENABLED = TRUE 
    -- aws iam role - trust rel - top ARN
    STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::559050221880:role/snowflake-s3-con'
     STORAGE_ALLOWED_LOCATIONS = ('s3://spotify-etl-prj1/transformed_data/')
   COMMENT = 'conn to s3 bucket'

      desc integration s3_int3


create or replace stage aws_stage6
url = "s3://spotify-etl-prj1/transformed_data/"
storage_integration = s3_int3

list @aws_stage6


---artist
create or replace table artist(
	artist_id varchar,
	artist_name varchar,
	external_url varchar
);

select * from artist


create or replace pipe test_pipe_artist
auto_ingest = True
AS
Copy into artist
from @AWS_STAGE6/artists_data/
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY='"' SKIP_HEADER = 1)
ON_ERROR = 'CONTINUE';

select * from artist

desc pipe test_pipe_artist

---album

CREATE TABLE album (
    album_id VARCHAR(50),
    name VARCHAR(255),
    release_date DATE,
    total_tracks INT,
    url VARCHAR(500)
);


select * from album


create or replace pipe test_pipe_album
auto_ingest = True
AS
Copy into album
from @AWS_STAGE6/albums_data/
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY='"' SKIP_HEADER = 1)
ON_ERROR = 'CONTINUE';

select * from album

desc pipe test_pipe_album


---song

CREATE TABLE song (
    song_id VARCHAR(50) ,
    song_name VARCHAR(255),
    duration_ms INT,
    url VARCHAR(500),
    popularity INT,
    song_added TIMESTAMP,
    album_id VARCHAR(50),
    artist_id VARCHAR(50)
);




select * from song


create or replace pipe test_pipe_song
auto_ingest = True
AS
Copy into song
from @AWS_STAGE6/songs_data/
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY='"' SKIP_HEADER = 1)
ON_ERROR = 'CONTINUE';

select * from song

desc pipe test_pipe_song

