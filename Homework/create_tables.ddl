-- Table: seb_api.books
-- DROP TABLE seb_api.books;
CREATE TABLE seb_api.books
(
    book_id integer NOT NULL,
    book_name text COLLATE pg_catalog."default",
    release_date timestamp with time zone,
    CONSTRAINT "PK_books" PRIMARY KEY (book_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE seb_api.books
    OWNER to postgres;


-- Table: seb_api.authors
-- DROP TABLE seb_api.authors;
CREATE TABLE seb_api.authors
(
    author_id integer NOT NULL,
    author_name text COLLATE pg_catalog."default",
    CONSTRAINT "PK_authors" PRIMARY KEY (author_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE seb_api.authors
    OWNER to postgres;


-- Table: seb_api.book_to_author
-- DROP TABLE seb_api.book_to_author;
CREATE TABLE seb_api.book_to_author
(
    book_id integer NOT NULL,
    author_id integer NOT NULL,
    CONSTRAINT "PK_book_to_author" PRIMARY KEY (book_id, author_id),
    CONSTRAINT "FK_18" FOREIGN KEY (book_id)
        REFERENCES seb_api.books (book_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_21" FOREIGN KEY (author_id)
        REFERENCES seb_api.authors (author_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE seb_api.book_to_author
    OWNER to postgres;

-- Index: fkIdx_18
-- DROP INDEX seb_api."fkIdx_18";
CREATE INDEX "fkIdx_18"
    ON seb_api.book_to_author USING btree
    (book_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Index: fkIdx_21
-- DROP INDEX seb_api."fkIdx_21";
CREATE INDEX "fkIdx_21"
    ON seb_api.book_to_author USING btree
    (author_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: seb_api.characters
-- DROP TABLE seb_api.characters;
CREATE TABLE seb_api.characters
(
    character_id integer NOT NULL,
    character_name text COLLATE pg_catalog."default",
    gender text COLLATE pg_catalog."default",
    CONSTRAINT "PK_characters" PRIMARY KEY (character_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE seb_api.characters
    OWNER to postgres;


-- Table: seb_api.actors
-- DROP TABLE seb_api.actors;
CREATE TABLE seb_api.actors
(
    actor_id integer NOT NULL,
    actor_name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "PK_actors" PRIMARY KEY (actor_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE seb_api.actors
    OWNER to postgres;

-- Table: seb_api.titles
-- DROP TABLE seb_api.titles;
CREATE TABLE seb_api.titles
(
    title_id integer NOT NULL DEFAULT nextval('seb_api.titles_title_id_seq'::regclass),
    title text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "PK_titles" PRIMARY KEY (title_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE seb_api.titles
    OWNER to postgres;

-- Table: seb_api.character_to_actor
-- DROP TABLE seb_api.character_to_actor;
CREATE TABLE seb_api.character_to_actor
(
    actor_id integer NOT NULL,
    character_id integer NOT NULL,
    CONSTRAINT "PK_character_to_actor" PRIMARY KEY (character_id, actor_id),
    CONSTRAINT "FK_50" FOREIGN KEY (actor_id)
        REFERENCES seb_api.actors (actor_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_53" FOREIGN KEY (character_id)
        REFERENCES seb_api.characters (character_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE seb_api.character_to_actor
    OWNER to postgres;

-- Index: fkIdx_50
-- DROP INDEX seb_api."fkIdx_50";
CREATE INDEX "fkIdx_50"
    ON seb_api.character_to_actor USING btree
    (actor_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Index: fkIdx_53
-- DROP INDEX seb_api."fkIdx_53";
CREATE INDEX "fkIdx_53"
    ON seb_api.character_to_actor USING btree
    (character_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: seb_api.character_to_title
-- DROP TABLE seb_api.character_to_title;
CREATE TABLE seb_api.character_to_title
(
    character_id integer NOT NULL,
    title_id integer NOT NULL,
    CONSTRAINT "PK_character_to_title" PRIMARY KEY (character_id, title_id),
    CONSTRAINT "FK_37" FOREIGN KEY (character_id)
        REFERENCES seb_api.characters (character_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_40" FOREIGN KEY (title_id)
        REFERENCES seb_api.titles (title_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE seb_api.character_to_title
    OWNER to postgres;

-- Index: fkIdx_37
-- DROP INDEX seb_api."fkIdx_37";
CREATE INDEX "fkIdx_37"
    ON seb_api.character_to_title USING btree
    (character_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Index: fkIdx_40
-- DROP INDEX seb_api."fkIdx_40";
CREATE INDEX "fkIdx_40"
    ON seb_api.character_to_title USING btree
    (title_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: seb_api.houses
-- DROP TABLE seb_api.houses;
CREATE TABLE seb_api.houses
(
    house_id integer NOT NULL,
    house_name text COLLATE pg_catalog."default",
    region text COLLATE pg_catalog."default",
    overlord_id integer,
    CONSTRAINT "PK_hauses" PRIMARY KEY (house_id),
    CONSTRAINT "FK_71" FOREIGN KEY (overlord_id)
        REFERENCES seb_api.houses (house_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE seb_api.houses
    OWNER to postgres;

-- Index: fkIdx_71
-- DROP INDEX seb_api."fkIdx_71";
CREATE INDEX "fkIdx_71"
    ON seb_api.houses USING btree
    (overlord_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: seb_api.sworn_member
-- DROP TABLE seb_api.sworn_member;
CREATE TABLE seb_api.sworn_member
(
    house_id integer NOT NULL,
    character_id integer NOT NULL,
    CONSTRAINT "PK_sworn_member" PRIMARY KEY (character_id, house_id),
    CONSTRAINT "FK_77" FOREIGN KEY (house_id)
        REFERENCES seb_api.houses (house_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_80" FOREIGN KEY (character_id)
        REFERENCES seb_api.characters (character_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE seb_api.sworn_member
    OWNER to postgres;

-- Index: fkIdx_77
-- DROP INDEX seb_api."fkIdx_77";
CREATE INDEX "fkIdx_77"
    ON seb_api.sworn_member USING btree
    (house_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Index: fkIdx_80
-- DROP INDEX seb_api."fkIdx_80";
CREATE INDEX "fkIdx_80"
    ON seb_api.sworn_member USING btree
    (character_id ASC NULLS LAST)
    TABLESPACE pg_default;