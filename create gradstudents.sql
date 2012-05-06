CREATE TABLE gradstudents
(
  id serial NOT NULL,
  first_name text,
  middle_name text,
  last_name text,
  citizenship text,
  residence text,
  streetnumber text,
  streetname text,
  city text,
  statecode text,
  zipcode text,
  areacode text,
  phonenumber text,
  specialization text,
  CONSTRAINT gradstudents_pkey PRIMARY KEY (id )
)
