-- Create the database
CREATE DATABASE IF NOT EXISTS social_media_analytics;
USE social_media_analytics;

-- Users table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    join_date DATE NOT NULL,
    total_posts INT DEFAULT 0
);

-- Posts table
CREATE TABLE Posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    post_date DATETIME NOT NULL,
    likes_count INT DEFAULT 0,
    comments_count INT DEFAULT 0,
    shares_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Likes table (many-to-many: users like posts)
CREATE TABLE Likes (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    like_date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id) ON DELETE CASCADE,
    UNIQUE KEY unique_like (user_id, post_id)  -- Prevent duplicate likes
);

-- Comments table
CREATE TABLE Comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    comment_date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id) ON DELETE CASCADE
);

-- Shares table
CREATE TABLE Shares (
    share_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    share_date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id) ON DELETE CASCADE,
    UNIQUE KEY unique_share (user_id, post_id)  -- Prevent duplicate shares
);

-- Insert users
INSERT INTO Users (username, email, join_date, total_posts) VALUES
('alice_wonder', 'alice@email.com', '2024-01-15', 0),
('bob_builder', 'bob@email.com', '2024-02-20', 0),
('charlie_tech', 'charlie@email.com', '2024-03-10', 0),
('dana_artist', 'dana@email.com', '2024-04-05', 0),
('eve_gamer', 'eve@email.com', '2024-05-12', 0);

-- Insert posts
INSERT INTO Posts (user_id, content, post_date) VALUES
(1, 'Just finished a marathon read of sci-fi classics! #Books', '2024-09-01 10:00:00'),
(1, 'Weekend vibes: coffee and coding. ☕💻', '2024-09-02 14:30:00'),
(2, 'Building a new app today! Check it out soon.', '2024-09-03 09:15:00'),
(2, 'Team lunch was epic. #WorkLife', '2024-09-04 12:45:00'),
(3, 'Latest gadget review: Worth the hype? #Tech', '2024-09-05 16:20:00'),
(3, 'AI is changing everything—thoughts?', '2024-09-06 11:10:00'),
(4, 'New painting inspired by autumn leaves. 🎨', '2024-09-07 08:50:00'),
(4, 'Street art tour in the city! #Art', '2024-09-08 13:25:00'),
(5, 'Just hit level 50 in my fave RPG. 🎮', '2024-09-09 19:40:00'),
(5, 'Gaming stream tonight—who’s joining?', '2024-09-10 20:15:00');

-- Update total_posts for users
UPDATE Users SET total_posts = (
    SELECT COUNT(*) FROM Posts WHERE user_id = Users.user_id
) WHERE user_id IN (1,2,3,4,5);

-- Insert likes (e.g., user 2 likes post 1, etc.)
INSERT INTO Likes (user_id, post_id, like_date) VALUES
(2, 1, '2024-09-01 10:05:00'),
(3, 1, '2024-09-01 10:10:00'),
(4, 1, '2024-09-01 10:15:00'),
(2, 3, '2024-09-03 09:20:00'),
(1, 3, '2024-09-03 09:25:00'),
(4, 6, '2024-09-06 11:15:00'),
(5, 6, '2024-09-06 11:20:00'),
(1, 9, '2024-09-09 19:45:00'),
(3, 9, '2024-09-09 19:50:00'),
(2, 10, '2024-09-10 20:20:00');

-- Insert comments
INSERT INTO Comments (user_id, post_id, comment_text, comment_date) VALUES
(2, 1, 'Sounds fun! What was your favorite?', '2024-09-01 10:08:00'),
(3, 2, 'Same here—productivity boost!', '2024-09-02 14:35:00'),
(4, 3, 'Excited to try it!', '2024-09-03 09:18:00'),
(5, 4, 'Jealous! Where?', '2024-09-04 12:50:00'),
(1, 5, 'Totally agree—overhyped.', '2024-09-05 16:25:00'),
(2, 7, 'Beautiful colors!', '2024-09-07 08:55:00'),
(3, 8, 'Love the energy in these shots.', '2024-09-08 13:30:00'),
(4, 9, 'Congrats! What’s next?', '2024-09-09 19:48:00'),
(5, 10, 'Count me in!', '2024-09-10 20:22:00'),
(1, 6, 'Excited but cautious.', '2024-09-06 11:12:00');

-- Insert shares
INSERT INTO Shares (user_id, post_id, share_date) VALUES
(3, 1, '2024-09-01 10:12:00'),
(4, 2, '2024-09-02 14:40:00'),
(5, 3, '2024-09-03 09:30:00'),
(1, 4, '2024-09-04 12:55:00'),
(2, 5, '2024-09-05 16:30:00'),
(3, 7, '2024-09-07 09:00:00'),
(5, 8, '2024-09-08 13:35:00'),
(4, 9, '2024-09-09 19:55:00'),
(2, 6, '2024-09-06 11:25:00'),
(1, 10, '2024-09-10 20:25:00');





