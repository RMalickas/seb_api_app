import requests

def clean_db(cur):
	print("Cleaning database")
	try: 
		cur.execute("""TRUNCATE TABLE seb_api.characters, seb_api.actors, seb_api.character_to_actor CASCADE""")
		conn.commit()
		print("success, database prepared")
	except:
		''' need to add error handling '''
		print('Something went wrong.')