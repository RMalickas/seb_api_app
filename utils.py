'''
Various utilities needed for project


'''

def clean_database(cur, conn, f):
	f.write("Cleaning database\n")
	#print("Cleaning database")
	try: 
		cur.execute("""TRUNCATE TABLE 
			seb_api.characters, 
			seb_api.actors, 
			seb_api.character_to_actor,
			seb_api.titles,
			seb_api.character_to_title,
			seb_api.books,
			seb_api.authors,
			seb_api.book_to_character,
			seb_api.book_to_author,
			seb_api.houses,
			seb_api.sworn_member CASCADE""")
		conn.commit()
		#print("success, database prepared")
		f.write("success, database prepared\n")
	except:
		''' need to add error handling '''
		#print('Something went wrong.')
		f.write('Something went wrong\n')
