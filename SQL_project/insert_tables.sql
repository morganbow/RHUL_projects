INSERT INTO TimeZone(time_zone,utc_offset) select distinct(user_time_zone), user_utc_offset
from bad_giant_table
where user_time_zone is not null;


INSERT INTO Users(user_id, user_created_at, user_name, user_screen_name, user_location, user_follower_count, user_friend_count, user_lang, user_description, user_status_count, user_time_zone)
select distinct(user_id), user_created_at::timestamp, user_name, user_screen_name, user_location, user_followers_count, user_friends_count, user_lang, user_description, user_status_count, user_time_zone
from bad_giant_table;


INSERT INTO Tweet(tweet_id, created_at, text, retweet_count, tweet_source, user_id)
select distinct(tweet_id), created_at::timestamp, text, retweet_count, tweet_source, user_id
from bad_giant_table;

INSERT INTO Reply_Tweet
select tweet_id, in_reply_to_status_id
from bad_giant_table
where in_reply_to_status_id is not null;

INSERT INTO Retweet 
select tweet_id, retweet_of_tweet_id
from bad_giant_table
where in_reply_to_status_id is not null;

INSERT INTO Hashtags
select tweet_id, hashtag1
from bad_giant_table 
where hashtag1 is not null;

INSERT INTO Hashtags
select tweet_id, hashtag2
from bad_giant_table 
where hashtag2 is not null;

INSERT INTO Hashtags
select tweet_id, hashtag3
from bad_giant_table 
where hashtag3 is not null;

INSERT INTO Hashtags
select tweet_id, hashtag4
from bad_giant_table 
where hashtag4 is not null;

INSERT INTO Hashtags
select tweet_id, hashtag5
from bad_giant_table 
where hashtag5 is not null;

INSERT INTO Hashtags
select tweet_id, hashtag6
from bad_giant_table 
where hashtag6 is not null;

