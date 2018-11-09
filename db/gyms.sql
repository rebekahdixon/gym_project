DROP TABLE bookings;
DROP TABLE classes;
DROP TABLE members;

CREATE TABLE members(
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE classes(
  id SERIAL8 PRIMARY KEY,
  class_name VARCHAR(255),
  class_time VARCHAR(255),
);

CREATE TABLE bookings(
  id SERIAL8 PRIMARY KEY,
  members_id INT8 REFERENCES members(id),
  classes_id INT8 REFERENCES classes(id)
);
