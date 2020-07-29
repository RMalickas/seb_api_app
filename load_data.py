'''
Load data to Database

'''

class Load:
	
	def __init__(self, cur, conn, f):
		self.cur = cur
		self.conn = conn
		self.f = f
	
	def load_three_fields(self, table, arg1, arg2, arg3, my_list):
		self.f.write("Inserting list into {} table\n".format(table))
		q = "INSERT INTO seb_api.{}({}, {}, {}) VALUES(%s, %s, %s)".format(table, arg1, arg2, arg3)
		self.cur.executemany(q, my_list)
		self.conn.commit()
		self.f.write("Success, inserted {} records\n".format(len(my_list)))

	def load_two_fields(self, table, arg1, arg2, my_list):
		self.f.write("Inserting list into {} table\n".format(table))
		q = "INSERT INTO seb_api.{}({}, {}) VALUES(%s, %s)".format(table, arg1, arg2)
		self.cur.executemany(q, my_list)
		self.conn.commit()
		self.f.write("Success, inserted {} records\n".format(len(my_list)))

	def update_table(self, table, set_arg, where_arg, my_list):
		self.f.write("Updating {} table with parent keys\n".format(table))
		q = "UPDATE seb_api.{} SET {} = %s WHERE {} = %s".format(table, set_arg, where_arg)
		self.cur.executemany(q, my_list)
		self.conn.commit()
		self.f.write("Success, inserted {} records\n".format(len(my_list)))