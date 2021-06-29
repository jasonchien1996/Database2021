# coding=UTF-8
import mysql.connector
import pandas as pd
import cv2
import numpy as np

#pwd = input("enter password:")
mydb = mysql.connector.connect(host="127.0.0.1", user="root", passwd='', raw=True)
mycursor = mydb.cursor()
mycursor.execute("use demo")

mycursor.execute("select id, aug(image) from img")
buf = None
for i in mycursor:
    buf = i[1]

#print(len(buf))
nparr = np.asarray(buf, np.uint8)
print(len(nparr))
i0 = cv2.imdecode(nparr,cv2.IMREAD_COLOR)
cv2.imshow('decoded',i0)
cv2.waitKey(0)

'''
nparr = np.asarray(buf, np.uint8)
nparr = np.reshape(nparr, (1440,2560,3))
cv2.imshow("xd", nparr)
cv2.waitKey(0)
'''

'''
1 cvt2gray
1 hflip
1 vflip
1 chshuffle
1 randcrop 10 10 255 255 255
1 rotation -20
1 noise gaussian 0 20
1 medianblur 10
1 gaussianblur 0.5 0.5 2 3
1 resize 0.5 0.5
'''
