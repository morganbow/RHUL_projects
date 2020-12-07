-- Tweets and users

CREATE VIEW tweet_count AS
(select count(tweet_id) as total_tweets
from tweet);
select *
from tweet_count;


CREATE VIEW lang_distribution AS
(select count(tweet_id) as tweet_lang_dist, user_lang
from tweet, users
where tweet.user_id = users.user_id 
group by user_lang);
select *
from lang_distribution;


with user_lang_distribution as (select count(user_id) as tot_tweets, user_lang
from users
group by user_lang)
select lang_distribution.user_lang, (lang_distribution.tweet_lang_dist)::decimal/tweet_count.total_tweets as tweet_lang_fraction,  
(user_lang_distribution.tot_tweets)::decimal/tweet_count.total_tweets as user_lang_fraction
from tweet_count, lang_distribution, user_lang_distribution
where lang_distribution.user_lang = user_lang_distribution.user_lang
order by tweet_lang_fraction DESC;


-- Retweets

with sum_retweets as
(select count(tweet_id) as total_retweets
from retweet)
select sum_retweets.total_retweets::decimal/tweet_count.total_tweets as retweet_fraction
from sum_retweets, tweet_count;


CREATE VIEW average_rts as
(with sum_retweeted as
(select sum(retweet_count) as total_retweeted
from tweet)
select sum_retweeted.total_retweeted::decimal/tweet_count.total_tweets::decimal as average_retweets
from sum_retweeted, tweet_count);
select *
from average_rts;


with not_retweeted as
(select count(tweet_id) as not_retweeted_count
from tweet
where retweet_count=0)
select not_retweeted.not_retweeted_count::decimal/tweet_count.total_tweets::decimal as not_retweeted_fraction
from not_retweeted, tweet_count;


with not_retweeted as
(select count(retweet_count) as not_retweeted_count
from tweet
where retweet_count<(select * from average_rts))
select not_retweeted.not_retweeted_count::decimal/tweet_count.total_tweets::decimal as not_retweeted_fraction
from not_retweeted, tweet_count;


-- Hashtags

select count(distinct hashtag)
from hashtags;


with hash_rank as
(with hash_freq as (select count(hashtag) as freq, hashtag
from hashtags
group by hashtag)
select hashtag, freq, rank() over(order by hash_freq.freq DESC) freq_rank 
from  hash_freq)
select freq_rank, hashtag, freqS
from hash_rank
where freq_rank <= 10;


with hash_lang_rank as
(with hash_lang_freq as (select count(hashtag) as freq, hashtag, user_lang
from hashtags, users, tweet
where (hashtags.tweet_id = tweet.tweet_id AND tweet.user_id = users.user_id)
group by user_lang, hashtags.hashtag)
select user_lang, hashtag, freq, rank() over(partition by user_lang order by freq DESC) freq_rank 
from  hash_lang_freq)
select  user_lang, freq_rank, freq, hashtag
from hash_lang_rank
where freq_rank <= 3;


-- Replies

with total_reply_tweets as
(select count(tweet_id) as tot_reply_tweets
from reply_tweet),
total_replied_to_tweets as
(select count(in_reply_to_status_id) as tot_replied_to_tweets
from reply_tweet, tweet
where in_reply_to_status_id = tweet.tweet_id)
select 1 - ((tot_reply_tweets + tot_replied_to_tweets)::decimal / total_tweets) as non_reply_tweets_fraction
from total_reply_tweets, total_replied_to_tweets, tweet_count;


with same_lang as
(with tweeter_lang as
(select user_lang, reply_tweet.tweet_id
from reply_tweet, tweet, users
where (reply_tweet.tweet_id = tweet.tweet_id and tweet.user_id = users.user_id)),
tweeted_lang as
(select user_lang, reply_tweet.tweet_id
from reply_tweet, tweet, users
where (reply_tweet.in_reply_to_status_id = tweet.tweet_id and tweet.user_id = users.user_id))
select count(tweeter_lang.tweet_id) as same_lang_reply
from tweeter_lang, tweeted_lang
where tweeter_lang. tweet_id = tweeted_lang.tweet_id and tweeter_lang.user_lang = tweeted_lang.user_lang),
total_replied_to_tweets as
(select count(in_reply_to_status_id) as tot_replied_to_tweets
from reply_tweet, tweet
where in_reply_to_status_id = tweet.tweet_id)
select same_lang_reply::decimal/tot_replied_to_tweets as same_lang_probability
from same_lang, total_replied_to_tweets;


with user_lang_distribution as (select count(user_id) as tot_tweets, user_lang
from users
group by user_lang)
select sum(((user_lang_distribution.tot_tweets)::decimal/tweet_count.total_tweets)^2.0) as prob_of_same_lang
from tweet_count, user_lang_distribution;



