DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;




PRAGMA foreign_keys = ON;  -- turn on the foreign key constraints to ensure data integrity


-- USERS

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL
);

INSERT INTO 
    users (fname, lname)
VALUES 
    ("Harry", "Potter"), 
    ("Naruto", "Uzumaki"),
     ("Vince", "Carter");

-- QUESTIONS

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body VARCHAR(255) NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
    questions (title, body, author_id)
SELECT
    "Harry Question", "This is Harry's Question", users.id
FROM
    users 
WHERE 
    users.fname = "Harry" AND users.lname = "Potter";

INSERT INTO
    questions (title, body, author_id)
SELECT
    "Naruto Question", "This is Naruto's Question", users.id
FROM
    users 
WHERE 
    users.fname = "Naruto" AND users.lname = "Uzumaki";

INSERT INTO
    questions (title, body, author_id)
SELECT
    "Vince Question", "This is Vince's Question", users.id
FROM
    users 
WHERE 
    users.fname = "Vince" AND users.lname = "Carter";


-- QUESTION_FOLLOWS

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO 
    question_follows(user_id, question_id)
VALUES
    (1, 2),
    (3, 2);

-- REPLIES

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    author_id INTEGER NOT NULL,
    body VARCHAR(255) NOT NULL,

    FOREIGN KEY(question_id) REFERENCES questions(id),
    FOREIGN KEY(parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY(author_id) REFERENCES users(id)
);

INSERT INTO 
    replies (question_id, parent_reply_id, author_id, body)
VALUES
    (1, NULL, 3, "Is this your question Harry?"),
    (1,1, 2, "I think it is Harry Question!");


-- QUESTION_LIKES

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
    question_likes (user_id, question_id)
VALUES 
    (1, 2),
    (3, 1);



