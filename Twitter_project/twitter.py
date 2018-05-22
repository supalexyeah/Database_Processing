# Problem 2
'''
c.	Create a new SQL table for the user dictionary. It should contain the following attributes
“id”, “name”, “screen_name”, “description” and “friends_count”.
Modify your SQL table from the class we did in class to include “user_id” which will be a foreign key
referencing the user table.
'''

import urllib.request, time, json, sqlite3

# Connect to database
conn = sqlite3.connect('csc455.db')
# Request a cursor from the database
c = conn.cursor()

# Create the user table
UserTable = '''CREATE TABLE User (
    id VARCHAR(20) PRIMARY KEY, 
    name VARCHAR(40), 
    screen_name VARCHAR(40), 
    description VARCHAR(100), 
    friends_count NUMBER(20)
);'''

# Create twitter table
TweetsTable2 = '''CREATE TABLE Tweets2 (
                 User_id     VARCHAR(20),
                 Id          NUMBER(20),
                 Created_At  DATE,
                 Text        CHAR(140),
                 Source VARCHAR(200) DEFAULT NULL,
                 In_Reply_to_User_ID NUMBER(20),
                 In_Reply_to_Screen_Name VARCHAR(60),
                 In_Reply_to_Status_ID NUMBER(20),
                 Retweet_Count NUMBER(10),
                 Contributors  VARCHAR(200),
                 
                 CONSTRAINT Tweets2_PK  PRIMARY KEY (Id),
                 CONSTRAINT Tweets2_FK  FOREIGN KEY(User_id) REFERENCES User(id)
);'''

# drop tables if they exist
c.execute("DROP TABLE IF EXISTS UserTable;")
c.execute("DROP TABLE IF EXISTS TweetsTable2;")

# make the tables from table strings above
c.execute(UserTable)
c.execute(TweetsTable2)

'''
d.	Write python code that is going to read and load the Assignment5.txt file from the web and populate 
both of your tables (Tweet table from class example and User table from this assignment).
For tweets that could not parse, simply store them in Assignment5_errors.txt file
'''
# read in the file from the web
tweetFile = urllib.request.urlopen('http://rasinsrv07.cstcis.cti.depaul.edu/CSC455/Assignment5.txt')
# create the file for the error tweets
f = open('Assignment5_errors.txt', 'w')

count = 0;
badTweets = 0;
for i in range(10000):

    # read the tweets
    tweets = tweetFile.readline().decode("utf8")

    try:
        tDict = json.loads(tweets)

        if 'retweeted_status' in tDict.keys():
            retweetcount = tDict['retweeted_status']['retweet_count']
        else:
            retweetcount = tDict['retweet_count']

        uservalues = (tDict['user']['id'], tDict['user']['name'], tDict['user']['screen_name'],
                      tDict['user']['description'], tDict['user']['friends_count'])
        tweetvalues = ( tDict['user']['id'],tDict['id'],tDict['created_at'], tDict['text'], tDict['source'], tDict['in_reply_to_user_id'], tDict['in_reply_to_screen_name'],
                       tDict['in_reply_to_status_id'], retweetcount, tDict['contributors'])
        c.execute("INSERT OR IGNORE INTO USER VALUES(?,?,?,?,?);", uservalues)
        c.execute("INSERT INTO TWEET VALUES(?,?,?,?,?,?,?,?,?,?);", tweetvalues)  # print(tweetvalues)

    except ValueError:
        # Handle the problematic tweet, which in your case would require writing it to another file
        f.write("%s;\n" % str(tweets.encode('utf8')))
        # This code imply prints the first 50 characters
        print(tweets[:50])

    except Exception:  # for unique id constraint errors
        count = count + 1;

print(count)  # number of unique id constraint errors
f.close()
conn.commit()
conn.close()