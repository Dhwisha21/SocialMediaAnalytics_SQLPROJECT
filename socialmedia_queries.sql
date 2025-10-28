-- Show users who joined in 2024
SELECT username
FROM Users
WHERE YEAR(join_date) = 2024;

-- Count posts per user
SELECT user_id, COUNT(post_id) AS total_posts
FROM posts
GROUP BY user_id;

-- Show users ordered by join date
SELECT username, join_date
FROM users
ORDER BY join_date DESC;

-- Show top 5 most recent comments
SELECT comment_text, comment_date
FROM comments
ORDER BY comment_date DESC
LIMIT 5;

-- Count total posts per user
SELECT user_id, COUNT(*) AS total_posts
FROM posts
GROUP BY user_id;

-- Count total likes per post
SELECT post_id, COUNT(*) AS total_likes
FROM likes
GROUP BY post_id;

-- Show posts that got more than 1 likes
SELECT post_id, COUNT(*) AS total_likes
FROM likes
GROUP BY post_id
HAVING total_likes > 1;

-- Show each post with the username of the person who created it
SELECT p.post_id, u.username, p.content, p.post_date
FROM users u 
INNER JOIN posts p  ON p.user_id = u.user_id;


