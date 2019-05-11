createdb contactbook --encoding=UNICODE
psql contactbook
CREATE TABLE contact (
    name VARCHAR (50),
    email VARCHAR (50) UNIQUE,
    phone VARCHAR (50),
    urlsafe VARCHAR(100)
);