CREATE TABLE authorinfo (
  author_id varchar(10) NOT NULL,
  author_name tinytext NOT NULL,
  author_desc mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE bookidv (
  bookidv_id varchar(10) NOT NULL,
  book_id varchar(10) NOT NULL,
  bookidv_status tinytext NOT NULL,
  borrower_id varchar(10) DEFAULT NULL,
  borrow_date date DEFAULT NULL,
  bookidv_onshelf varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE bookinfo (
  book_id varchar(10) NOT NULL,
  book_title tinytext NOT NULL,
  book_category tinytext NOT NULL,
  book_length int(11) NOT NULL,
  number_storage int(11) DEFAULT NULL,
  number_shelf int(11) DEFAULT NULL,
  time_borrowed int(11) NOT NULL,
  publisher_id varchar(10) NOT NULL,
  author_id varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE borrowdetail (
  borrow_id varchar(10) NOT NULL,
  borrower_id varchar(10) NOT NULL,
  borrow_date date NOT NULL,
  return_date date DEFAULT NULL,
  bookidv_id varchar(10) DEFAULT NULL,
  return_deadline date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE membership (
  member_id varchar(10) NOT NULL,
  lastest_arrival date DEFAULT NULL,
  member_firstname tinytext NOT NULL,
  member_lastname tinytext NOT NULL,
  member_phonenumber varchar(12) NOT NULL,
  member_city tinytext DEFAULT NULL,
  member_placeofwork tinytext DEFAULT NULL,
  member_since date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE publisherinfo (
  publisher_id varchar(10) NOT NULL,
  publisher_name tinytext NOT NULL,
  publisher_desc mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE authorinfo
  ADD PRIMARY KEY (author_id);

ALTER TABLE bookidv
  ADD PRIMARY KEY (bookidv_id),
  ADD KEY book_id (book_id);

ALTER TABLE bookinfo
  ADD PRIMARY KEY (book_id),
  ADD KEY publisher_id (publisher_id),
  ADD KEY author_id (author_id);

ALTER TABLE borrowdetail
  ADD PRIMARY KEY (borrow_id),
  ADD KEY bookidv_id (bookidv_id),
  ADD KEY borrower_id (borrower_id);

ALTER TABLE membership
  ADD PRIMARY KEY (member_id);

ALTER TABLE publisherinfo
  ADD PRIMARY KEY (publisher_id);


ALTER TABLE bookidv
  ADD CONSTRAINT bookidv_ibfk_1 FOREIGN KEY (book_id) REFERENCES bookinfo (book_id) ON UPDATE CASCADE;

ALTER TABLE bookinfo
  ADD CONSTRAINT bookinfo_ibfk_1 FOREIGN KEY (publisher_id) REFERENCES publisherinfo (publisher_id) ON UPDATE CASCADE,
  ADD CONSTRAINT bookinfo_ibfk_2 FOREIGN KEY (author_id) REFERENCES authorinfo (author_id) ON UPDATE CASCADE;

ALTER TABLE borrowdetail
  ADD CONSTRAINT borrowdetail_ibfk_1 FOREIGN KEY (bookidv_id) REFERENCES bookidv (bookidv_id) ON UPDATE CASCADE,
  ADD CONSTRAINT borrowdetail_ibfk_2 FOREIGN KEY (borrower_id) REFERENCES membership (member_id) ON UPDATE CASCADE;