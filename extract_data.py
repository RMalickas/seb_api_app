'''
Data extraction from API

'''
import json
import requests

class Extract:
	def __init__(self, object_name, page_nr, page_size):
		self.object_name = object_name
		self.page_nr = page_nr
		self.page_size = page_size
		self.data = []

	def api_data(self, f):
		f.write("Requesting {} data. page size - {}\n".format(self.object_name, self.page_nr))
		while True:
			response = requests.get('https://anapioficeandfire.com/api/{}?page={}&pageSize={}'.format(self.object_name,self.page_nr,self.page_size))
			if len(json.loads(response.text)) == 0:
				break

			self.data += json.loads(response.text)
			
			f.write('Downloaded {} page\n'.format(self.page_nr))
			self.page_nr += 1

		f.write('Total {} records received related to {}\n'.format(len(self.data),self.object_name))
		
		return	self.data	
