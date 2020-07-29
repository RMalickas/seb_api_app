create_db_sql.sql

-- *************** SqlDBM: PostgreSQL ****************;
-- ***************************************************;
CREATE SCHEMA "seb_api";

-- ************************************** "actors"

CREATE TABLE "seb_api"."actors"
(
 "actor_id"   serial NOT NULL,
 "actor_name" text NOT NULL,
 CONSTRAINT "PK_actors" PRIMARY KEY ( "actor_id" )
);

CREATE TABLE "seb_api"."authors"
(
 "author_id"   serial NOT NULL,
 "author_name" text NOT NULL,
 CONSTRAINT "PK_authors" PRIMARY KEY ( "author_id" )
);

CREATE TABLE "seb_api"."books"
(
 "book_id"      serial NOT NULL,
 "book_name"    text NOT NULL,
 "authors_id"   integer NOT NULL,
 "release_date" timestamp with time zone NOT NULL,
 CONSTRAINT "PK_books" PRIMARY KEY ( "book_id" )
);

CREATE TABLE "seb_api"."characters"
(
 "character_id"   serial NOT NULL,
 "character_name" text NOT NULL,
 "gender"         text NOT NULL,
 CONSTRAINT "PK_characters" PRIMARY KEY ( "character_id" )
);

CREATE TABLE "seb_api"."hauses"
(
 "house_id"    serial NOT NULL,
 "house_name"  text NOT NULL,
 "region"      text NOT NULL,
 "overlord_id" integer NULL,
 CONSTRAINT "PK_hauses" PRIMARY KEY ( "house_id" ),
 CONSTRAINT "FK_71" FOREIGN KEY ( "overlord_id" ) REFERENCES "seb_api"."hauses" ( "house_id" )
);

CREATE INDEX "fkIdx_71" ON "seb_api"."hauses"
(
 "overlord_id"
);

CREATE TABLE "seb_api"."titles"
(
 "title_id" serial NOT NULL,
 "title"    text NOT NULL,
 CONSTRAINT "PK_titles" PRIMARY KEY ( "title_id" )
);

CREATE TABLE "seb_api"."book_to_author"
(
 "id"        serial NOT NULL,
 "book_id"   integer NOT NULL,
 "author_id" integer NOT NULL,
 CONSTRAINT "PK_book_to_author" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_18" FOREIGN KEY ( "book_id" ) REFERENCES "seb_api"."books" ( "book_id" ),
 CONSTRAINT "FK_21" FOREIGN KEY ( "author_id" ) REFERENCES "seb_api"."authors" ( "author_id" )
);

CREATE INDEX "fkIdx_18" ON "seb_api"."book_to_author"
(
 "book_id"
);

CREATE INDEX "fkIdx_21" ON "seb_api"."book_to_author"
(
 "author_id"
);

CREATE TABLE "seb_api"."book_to_character"
(
 "id"           serial NOT NULL,
 "book_id"      integer NOT NULL,
 "character_id" integer NOT NULL,
 CONSTRAINT "PK_book_to_character" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_59" FOREIGN KEY ( "book_id" ) REFERENCES "seb_api"."books" ( "book_id" ),
 CONSTRAINT "FK_62" FOREIGN KEY ( "character_id" ) REFERENCES "seb_api"."characters" ( "character_id" )
);

CREATE INDEX "fkIdx_59" ON "seb_api"."book_to_character"
(
 "book_id"
);

CREATE INDEX "fkIdx_62" ON "seb_api"."book_to_character"
(
 "character_id"
);



CREATE TABLE "seb_api"."character_to_actor"
(
 "id"           serial NOT NULL,
 "actor_id"     integer NOT NULL,
 "character_id" integer NOT NULL,
 CONSTRAINT "PK_character_to_actor" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_50" FOREIGN KEY ( "actor_id" ) REFERENCES "seb_api"."actors" ( "actor_id" ),
 CONSTRAINT "FK_53" FOREIGN KEY ( "character_id" ) REFERENCES "seb_api"."characters" ( "character_id" )
);

CREATE INDEX "fkIdx_50" ON "seb_api"."character_to_actor"
(
 "actor_id"
);

CREATE INDEX "fkIdx_53" ON "seb_api"."character_to_actor"
(
 "character_id"
);

CREATE TABLE "seb_api"."character_to_title"
(
 "id"           serial NOT NULL,
 "character_id" integer NOT NULL,
 "title_id"     integer NOT NULL,
 CONSTRAINT "PK_character_to_title" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_37" FOREIGN KEY ( "character_id" ) REFERENCES "seb_api"."characters" ( "character_id" ),
 CONSTRAINT "FK_40" FOREIGN KEY ( "title_id" ) REFERENCES "seb_api"."titles" ( "title_id" )
);

CREATE INDEX "fkIdx_37" ON "seb_api"."character_to_title"
(
 "character_id"
);

CREATE INDEX "fkIdx_40" ON "seb_api"."character_to_title"
(
 "title_id"
);



CREATE TABLE "seb_api"."sworn_member"
(
 "id"           serial NOT NULL,
 "house_id"     integer NOT NULL,
 "character_id" integer NOT NULL,
 CONSTRAINT "PK_sworn_member" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_77" FOREIGN KEY ( "house_id" ) REFERENCES "seb_api"."hauses" ( "house_id" ),
 CONSTRAINT "FK_80" FOREIGN KEY ( "character_id" ) REFERENCES "seb_api"."characters" ( "character_id" )
);

CREATE INDEX "fkIdx_77" ON "seb_api"."sworn_member"
(
 "house_id"
);

CREATE INDEX "fkIdx_80" ON "seb_api"."sworn_member"
(
 "character_id"
);