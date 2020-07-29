'''
Transform methods

'''

class Transform:

	def __init__(self, denormalized_data):
		self.denormalized_data = denormalized_data


	def key_values(self, row_nr):
		my_list = list(set([row[row_nr] for row in self.denormalized_data if (row[row_nr]!='')] )) 
		return list(zip(my_list,list(range(1, len(my_list)+1))))


	def relate_entities(self, dictionary, elem_nr):
		relation = []
		for elem in self.denormalized_data:
			if elem[elem_nr]!='':
				relation.append(
					[elem[4],
					dictionary[elem[elem_nr]]
					])
		#removing duplicates
		return set(tuple(r) for r in relation)

def extract_house_data_overlord(object_name, object_data, key_field, field1, f):
		f.write("Extracting {} data\n".format(object_name))
		my_list=[]
		for dic in object_data:
			if dic[key_field] != '': 
				my_list.append([
					dic[key_field].split("/")[-1],
					dic[field1].split("/")[-1]
					])
		return my_list


def extract_data(object_name, object_data, field1, field2, field3, f):
	f.write("Extracting {} data\n".format(object_name))
	my_list=[]
	for dic in object_data:
		my_list.append([
			dic[field1] if dic[field1] else '', 
			dic[field2] if dic[field2] else '',
			dic[field3].split("/")[-1]
			])
	return my_list


def denormalizing_data_val(object_name, object_data, key_field, field1, field2, field3, field4, f):
	f.write("Denormalizing {} data\n".format(object_name))
	
	data_denormalized=[]
	for dic in object_data:
		if len(dic[key_field]) == 0:
			data_denormalized.append([
				dic[field1] if dic[field1] else '',
				dic[field2] if dic[field2] else '',
				dic[field3] if dic[field3] else '',
				'',
				dic[field4].split("/")[-1]
				])
		else:
			for val in dic[key_field]:
				data_denormalized.append([
					dic[field1] if dic[field1] else '',
					dic[field2] if dic[field2] else '',
					dic[field3] if dic[field3] else '',
					val.split("/")[-1],
					dic[field4].split("/")[-1]
					])

	f.write("{} data denormalization. Input {} records, output {} records\n".format(object_name, len(object_data), len(data_denormalized)))
	return data_denormalized


def denormalizing_data_list(object_name, object_data, key_field, field1, field2, field3, field4, f):
	f.write("Denormalizing {} data\n".format(object_name))
	
	data_denormalized=[]
	for dic in object_data:
		if (dic[key_field][0] == '' or len(dic[key_field]) == 0):
			data_denormalized.append({
				field1 : (dic[field1] if dic[field1] else ''),
				field2 : (dic[field2] if dic[field2] else ''),
				field3 : (dic[field3] if dic[field3] else ''),
				key_field : '',
				field4 : dic[field4].split("/")[-1]
				})
		else:
			for val in dic[key_field]:
				data_denormalized.append({
					field1 : (dic[field1] if dic[field1] else ''),
					field2 : (dic[field2] if dic[field2] else ''),
					field3 : (dic[field3] if dic[field3] else ''),
					key_field : val.split("/")[-1],
					field4 : dic[field4].split("/")[-1]
					})

	f.write("{} data denormalization. Input {} records, output {} records\n".format(object_name, len(object_data), len(data_denormalized)))
	return data_denormalized

def dict_to_list(object_data):
	my_list = []
	for elem in object_data:
		my_list.append(list(elem.values()))
	return my_list
