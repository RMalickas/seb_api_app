import psycopg2
from time import gmtime, strftime

import utils
import transform 
import extract_data 
import load_data

#connecting to database
try:
	conn = psycopg2.connect(host="localhost", port = 5432, database="seb_api", user="seb_api_got", password="got_api_seb")
except:
	print ("I am unable to connect to the database.")
cur = conn.cursor()

#open log file
log = open("logs/log_{}.txt".format(strftime("%Y%m%d_%H%M%S", gmtime())), "w")



##### Main #####
utils.clean_database(cur, conn, log)

#Initiate extract 
ext_characters = extract_data.Extract("characters", 1, 50) #"characters", from page{], page size{}
ext_books = extract_data.Extract("books", 1, 50) #"books", from page{], page size{}
ext_house = extract_data.Extract("houses", 1, 50) #"houses", from page{], page size{}



#Character entity
characters_data = ext_characters.api_data(log)

characters_list = transform.extract_data('character', characters_data, 'name', 'gender', 'url', log)

denorm_character_data_1 = transform.denormalizing_data_list('Characters', characters_data, 'titles', 'name', 'gender', 'playedBy', 'url', log )
denorm_character_data_2 = transform.denormalizing_data_list('Characters', denorm_character_data_1, 'playedBy', 'name', 'gender', 'titles', 'url', log )
denorm_character_data = transform.dict_to_list(denorm_character_data_2)

trf_char = transform.Transform(denorm_character_data)
character_actor_dictionary = dict(trf_char.key_values(3))
character_to_actor = trf_char.relate_entities(character_actor_dictionary, 3)
character_title_dictionary = dict(trf_char.key_values(2))
character_to_title = trf_char.relate_entities(character_title_dictionary, 2)

character_load = load_data.Load(cur, conn, log)
character_load.load_three_fields('characters', 'character_name', 'gender', 'character_id', characters_list)
character_load.load_two_fields('actors', 'actor_name', 'actor_id', trf_char.key_values(3))
character_load.load_two_fields('character_to_actor', 'character_id', 'actor_id', character_to_actor)
character_load.load_two_fields('titles', 'title', 'title_id', trf_char.key_values(2))
character_load.load_two_fields('character_to_title', 'character_id', 'title_id', character_to_title)



#Book entity
book_data = ext_books.api_data(log)

denorm_book_data_1 = transform.denormalizing_data_list('Books', book_data, 'authors', 'name', 'released', 'characters', 'url', log )
denorm_book_data = transform.denormalizing_data_val('Books', denorm_book_data_1, 'characters', 'name', 'released', 'authors', 'url', log )

trf_book = transform.Transform(denorm_book_data)

book_list = transform.extract_data('books', book_data, 'name', 'released', 'url', log)

authors_list = trf_book.key_values(2)
authors_dict = dict(authors_list)

book_to_author_dictionary = dict(trf_book.key_values(2))
book_to_author = trf_book.relate_entities(book_to_author_dictionary, 2)

#Creating relations between books and characters
book_to_character = [[row[3], row[4]] for row in denorm_book_data if (row[3]!='' and row[4]!='')]
book_to_character = set(tuple(r) for r in book_to_character)

book_load = load_data.Load(cur, conn, log)
book_load.load_three_fields('books', 'book_name', 'release_date', 'book_id', book_list)
book_load.load_two_fields('authors', 'author_name', 'author_id', authors_list)
book_load.load_two_fields('book_to_author', 'book_id', 'author_id', book_to_author)
book_load.load_two_fields('book_to_character', 'character_id', 'book_id', book_to_character)



#House entity
houses_data = ext_house.api_data(log)

denorm_house_data = transform.denormalizing_data_val('Houses', houses_data, 'swornMembers', 'name', 'region', 'overlord', 'url', log )

house_list = transform.extract_data('houses', houses_data, 'name', 'region', 'url', log)
house_list_overlord = transform.extract_house_data_overlord('overlord', houses_data, 'overlord', 'url', log)

#Creating relations between houses and characters
house_to_character = [[row[3], row[4]] for row in denorm_house_data if (row[3]!='' and row[4]!='')]
house_to_character = set(tuple(r) for r in house_to_character)

house_load = load_data.Load(cur, conn, log)
house_load.load_three_fields('houses', 'house_name', 'region', 'house_id', house_list)
house_load.update_table('houses','overlord_id', 'house_id', house_list_overlord)
house_load.load_two_fields('sworn_member', 'character_id', 'house_id', house_to_character)


conn.close()
cur.close()
log.close()