'''
3. Use Python SQL to complete the below.
Books(ISBN, Name, Price, NumberOfCopies)
- Identify a primary key generate and execute a python SQL DDL command to Create table.
- Make your own data and insert 10 rows in the table created using python SQLite.
- Retrieve all the records from the table Books.
- Insert another record in the table as ('9875465248','Programming With Python',100,50)
- Update the record inserted above
– Price -> new Value -> 60 and Number of copies -> new value -> 100
- Delete the record from the above table where number of copies = 100
- Retrieve all the records again from the Books table.
- Retrieve sum of all copies and the avg price from the above table.
'''
#Books(ISBN, Name, Price, NumberOfCopies)$
import sqlite3

conn = sqlite3.connect('CSC455.db')
c = conn.cursor()

c.execute('drop table if exists Books')

# Identify a primary key generate and execute a python SQL DDL command to Create table.
BooksTable = '''CREATE TABLE Books(
             ISBN VARCHAR2(20) NOT NULL,
             Name VARCHAR2(100),
             Price NUMBER(5,2),
             NumberOfCopies INT,

             CONSTRAINT BOOKS_ISBN_PK PRIMARY KEY(ISBN)
);'''

c.execute(BooksTable)

# Make your own data and insert 10 rows in the table created using python SQLite.
bookdata = [('1234567890','Book A',11.11,100), ('2234567890','Book B',22.22,200), \
            ('3234567890','Book C',33.33,300),('4234567890','Book D',44.44,400), \
            ('5234567890','Book E',55.55,500), ('6234567890','Book F',66.66,600), \
            ('7234567890','Book G',77.77,700), ('8234567890','Book H',88.88,800), \
            ('9234567890','Book I',99.99,900),('1023456789','Book J',100.10,1000),]
c.executemany('INSERT INTO Books VALUES (?,?,?,?)', bookdata)

# Retrieve all the records from the table Books.
c.execute('SELECT * FROM Books ORDER BY ISBN')
print(c.fetchall())

# Insert another record in the table as ('9875465248','Programming With Python',100,50)
c.execute("INSERT INTO Books VALUES ('9875465248','Programming With Python',100,50)")

# Update the record inserted above – Price -> new Value -> 60 and Number of copies -> new value -> 100
c.execute("UPDATE Books SET Price = 60, NumberOfCopies = 100 WHERE ISBN = '9875465248'")

# Delete the record from the above table where number of copies = 100
c.execute('DELETE FROM Books WHERE NumberOfCopies = 100')

# Retrieve all the records again from the Books table.
c.execute('SELECT * FROM Books ORDER BY ISBN'):
print(c.fetchall())

# Retrieve sum of all copies and the avg price from the above table.
c.execute('SELECT SUM(NumberOfCopies), AVG(Price) FROM Books'):
print(c.fetchall())
