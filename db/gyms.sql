DROP TABLE bookings;
DROP TABLE sessions;
DROP TABLE members;

CREATE TABLE members(
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE sessions(
  id SERIAL8 PRIMARY KEY,
  session_name VARCHAR(255),
  session_time VARCHAR(255)
);

CREATE TABLE bookings(
  id SERIAL8 PRIMARY KEY,
  members_id INT8 REFERENCES members(id) ON DELETE CASCADE,
  sessions_id INT8 REFERENCES sessions(id) ON DELETE CASCADE
);
