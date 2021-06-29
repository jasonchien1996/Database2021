import pandas as pd
import sqlalchemy as sql
import mysql.connector

#1
sql_engine = sql.create_engine("mysql+mysqlconnector://root:@jasonchien1996@localhost/DB_class")
df = pd.read_csv('EE5178_student_data.csv', index_col=0, encoding='utf-8')
df.to_sql('students', sql_engine, if_exists='replace')

#2
mydbcon = mysql.connector.connect(host="localhost", user="root", passwd="@jasonchien1996", database="DB_class" )
mycursor = mydbcon.cursor()
mycursor.execute("select * from students where 學號='r09922146'")
print(mycursor.fetchone())

#3
mycursor.execute("select * from students where 系所='資工系碩士班' and 年級='一年級\xa0'")
print(mycursor.fetchall())

#4
mycursor.execute("select count(學號) from students;")
print(mycursor.fetchone()[0])

#5
select = "SELECT * FROM students where 學號 = %(學號)s"
mycursor.execute(select, { '學號': 'r09921000' })
print(mycursor.fetchone())

#6
mycursor.execute("update students set 身份='特優生' where 學號='r09922146'")
mycursor.execute("select * from students where 學號='r09922146'")
print(mycursor.fetchone())

#7
data = [('旁聽生','歷史系','b09900201','小花','一年級'),
        ('校內生','歷史系','b06900332','小草','四年級'),
        ('校內生','機械系','b06502055','小天','四年級')]
insert = "insert into students (身份,系所,學號,姓名,年級) values (%s,%s,%s,%s,%s)"
mycursor.executemany(insert, data)

#8
mycursor = mydbcon.cursor(prepared=True)
select = "SELECT * FROM students where 學號 = %s"
mycursor.execute(select, ('b09900201',))
print(mycursor.fetchone())
mycursor.execute(select, ('b06900332',))
print(mycursor.fetchone())
mycursor.execute(select, ('b06502055',))
print(mycursor.fetchone())

mydbcon.commit()

mycursor.close()
mydbcon.close()