CREATE TABLE
  users (
    id serial PRIMARY KEY,
    NAME VARCHAR(255) NOT NULL,
    age INT NOT NULL DEFAULT 0,
    email VARCHAR(255) UNIQUE NOT NULL
  );


CREATE TABLE
  posts (
    id serial PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT DEFAULT '...',
    creator_id INT REFERENCES users (id) NOT NULL
  );


CREATE TABLE
  COMMENTS (
    id serial PRIMARY KEY,
    body TEXT NOT NULL,
    post_id INT REFERENCES posts (id),
    creator_id INT REFERENCES users (id)
  );


CREATE TABLE
  upvotes (
    user_id INT REFERENCES users (id),
    post_id INT REFERENCES posts (id),
    PRIMARY KEY (user_id, post_id)
  );


CREATE TABLE
  friends (
    user_id1 INT REFERENCES users (id),
    user_id2 INT REFERENCES users (id),
    PRIMARY KEY (user_id1, user_id2)
  );


DROP TABLE users;


DROP TABLE posts;


DROP TABLE COMMENTS;


DROP TABLE upvotes;


DROP TABLE friends;


INSERT INTO
  users (NAME, age, email)
VALUES
  ('Luis', 23, 'luis@gmail.com'),
  ('Fernando', 24, 'fernando@outlook.com'),
  ('Example', DEFAULT, 'example@gmail.com'),
  ('Sergio', 27, 'sacs@hotmail.com'),
  ('Ivan', 21, 'ivan@outlook.com'),
  ('Nello', 65, 'nello@gmail.com'),
  ('Sean', 51, 'sean@hotmail.com'),
  ('Chad', 52, 'chad@hotmail.com');


INSERT INTO
  posts (title, creator_id)
VALUES
  ('My first post', 1),
  ('My life', 2),
  ('My second post', 1),
  ('My trip aroud europe', 4),
  ('The day i almost passed away!', 8),
  ('Third post', 1),
  ('The art of not giving a fuck!', 2),
  ('Last post', 1),
  ('Why i love british columbia', 4);


INSERT INTO
  COMMENTS (body, post_id, creator_id)
VALUES
  ('Hello nice post!', 1, 1),
  ('Nice job bro!', 1, 5);


INSERT INTO
  upvotes (user_id, post_id)
VALUES
  (1, 2),
  (1, 3),
  (1, 4),
  (2, 1),
  (2, 5);


INSERT INTO
  friends (user_id1, user_id2)
VALUES
  (1, 4),
  (1, 6),
  (1, 8),
  (5, 4),
  (2, 1),
  (8, 3);


SELECT
  *
FROM
  users;


SELECT
  *
FROM
  posts;


SELECT
  *
FROM
  upvotes;


SELECT
  *
FROM
  friends;


SELECT
  u1.id,
  u1.name,
  u2.name,
  u2.id
FROM
  friends f
  INNER JOIN users u1 ON u1.id = 1
  INNER JOIN users u2 ON (
    u2.id = f.user_id2
    AND f.user_id1 = 1
  )
  OR (
    u2.id = f.user_id1
    AND f.user_id2 = 1
  );


SELECT
  u1.name,
  u2.name
FROM
  friends f
  INNER JOIN users u1 ON u1.id = f.user_id1
  INNER JOIN users u1 ON u2.id = f.user_id2;


SELECT
  p.title,
  u2.name post_creator,
  u.name post_upvoter
FROM
  upvotes v
  INNER JOIN users u ON u.id = v.user_id
  INNER JOIN posts p ON p.id = v.post_id
  INNER JOIN users u2 ON u2.id = p.creator_id;


SELECT
  u2.name post_creator,
  p.title,
  u.name message_sender,
  c.body
FROM
  COMMENTS c
  INNER JOIN posts p ON c.post_id = p.id
  INNER JOIN users u2 ON p.creator_id = u2.id
  INNER JOIN users u ON c.creator_id = u.id;


SELECT
  u.id,
  p.id post_id,
  NAME nombre,
  title
FROM
  users u
  INNER JOIN posts p ON u.id = p.creator_id
WHERE
  p.title LIKE '% post%';