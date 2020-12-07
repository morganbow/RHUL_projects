CREATE TABLE TimeZone (
time_zone varchar(30) PRIMARY KEY,
utc_offset int);

CREATE TABLE Users (
user_id int PRIMARY KEY,
user_name varchar(50),
user_screen_name varchar (50),
user_location varchar(50),
user_follower_count int,
user_friend_count int,
user_lang varchar(5),
user_description varchar (200),
user_status_count varchar(30),
user_created_at timestamp,
user_time_zone varchar(30),
FOREIGN KEY (user_time_zone)
	REFERENCES
	TimeZone(time_zone));

CREATE TABLE Tweet (
tweet_id bigint PRIMARY KEY,
text varchar(300),
created_at timestamp
retweet_count int,
tweet_source varchar(300),
user_id int,
FOREIGN KEY (user_id)
	REFERENCES
	Users(user_id));

CREATE TABLE Reply_Tweet (
tweet_id bigint PRIMARY KEY,
in_reply_to_status_id bigint,
FOREIGN KEY (tweet_id)
	REFERENCES
	Tweet(tweet_id));

CREATE TABLE Retweet (
tweet_id bigint PRIMARY KEY,
retweet_of_tweet_id bigint,
FOREIGN KEY (tweet_id)
	REFERENCES
	Tweet(tweet_id),
FOREIGN KEY (retweet_of_tweet_id)
	REFERENCES
	Tweet(tweet_id));


CREATE TABLE Hashtags (
tweet_id bigint,
hashtag varchar(300),
FOREIGN KEY (tweet_id)
	REFERENCES
	Tweet(tweet_id));
