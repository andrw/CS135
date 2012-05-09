DROP TABLE IF EXISTS degrees;
DROP TABLE IF EXISTS majors;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS universities;
DROP TABLE IF EXISTS specializations;
DROP TABLE IF EXISTS countries;

CREATE TABLE countries (
    c_id          SERIAL PRIMARY KEY,
    country  TEXT NOT NULL UNIQUE
);

CREATE TABLE majors (
    m_id          SERIAL PRIMARY KEY,
    major  TEXT NOT NULL UNIQUE
);

CREATE TABLE specializations (
    s_id          SERIAL PRIMARY KEY,
    specialization  TEXT NOT NULL UNIQUE
);

CREATE TABLE universities (
    u_id          SERIAL PRIMARY KEY,
    country_state TEXT NOT NULL,
    university  TEXT NOT NULL,
    UNIQUE (country_state, university)
);

CREATE TABLE students (
  s_id          SERIAL PRIMARY KEY,
  first_name    TEXT NOT NULL,
  middle_initial TEXT NOT NULL,
  last_name     TEXT NOT NULL,
  citizenship   INTEGER REFERENCES countries (c_id) NOT NULL,
  residence     INTEGER REFERENCES countries (c_id) NOT NULL,
  street        TEXT NOT NULL,
  city          TEXT NOT NULL,
  statecode     TEXT,
  zipcode       TEXT,
  areacode      TEXT,
  phonenumber   TEXT,
  specialization INTEGER REFERENCES specializations (s_id) NOT NULL
);

CREATE TABLE degrees (
    d_id        SERIAL PRIMARY KEY,
    student     INTEGER REFERENCES students (s_id) NOT NULL,
    uni         INTEGER REFERENCES universities (u_id) NOT NULL,
    major       INTEGER REFERENCES majors (m_id) NOT NULL,
    month       TEXT,
    year        TEXT,
    gpa         TEXT
);
