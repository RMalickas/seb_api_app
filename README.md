Assignment for ETL developer
Using any open source technology write a schedulable client to collect data from Game of Thrones
https://anapioficeandfire.com/ API and store data to any open source DB.

Technical requirements:
1. Create data model for storing books, characters and houses entities. (provide DDL or Data
Diagram)
2. Data model should satisfy against queries:
	a. Be able to extract total count of each entities from DB (provide example query)
	b. Be able to extract list of all book names, authors, release dates and character names,
genders and titles mentioned in the book in the best manner for human-readable format.
(provide example query)
	c. Be able to extract list of all character names and played by actor names. (provide example
query)
	d. Be able to extract list of all house names, regions, overlord names and sworn member
names. (provide example query)
3. Develop a data extraction client (fulfilling requirements in section 2)
	a. Extraction should reflect up-to-date data
	b. Process should be able run on demand or be scheduled
4. Document the solution and put to gitHub providing project’s URL.


To solve given problem selected techologies:
	DataBase - PostgreSQL 10
	ETL - Python 3
	OS - Linux
	Process scheduling - Crontab

DataBase:
	DB schema snapshot - Homework/database_schema.png
	DDL file - Homework/create_tables.ddl

ETL:
	run file = main.py
	extraction related process - extract_data.py
	transformation related process - transfrom.py
	loading related process - load_data.py
	util process - utils.py

Process scheduling:
	bash script - crontab/run_seb_api_app.sh
	schedulet every monday at 9:00  - 0 9 * * MON /home/ricardas/test/seb_api_app/crontab/run_seb_api_app.sh
	run on demand: execute main.py

SQL queries for testing: 
	Assignment 2: Homework/example_queries.sql
