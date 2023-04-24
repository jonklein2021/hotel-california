DROP TABLE has;        /** ammenities -- hotels */          -- filled
DROP TABLE contains;   /** hotels <- rooms */
DROP TABLE costs;      /** rates -> hotels */
DROP TABLE represents; /** reservations <- transactions */
DROP TABLE uses;       /** rates <-> reservations */
DROP TABLE res_type;   /** reservations -> room_types */
DROP TABLE reserves;   /** reservations -> guests */
DROP TABLE spends;     /** transations -> guests */
DROP TABLE ammenities;   -- filled
DROP TABLE hotels;       -- filled
DROP TABLE rooms;
DROP TABLE room_types;   -- filled
DROP TABLE rates;        -- 
DROP TABLE reservations; -- filled
DROP TABLE transactions; -- filled
DROP TABLE guests;       -- filled

CREATE TABLE ammenities (
    a_id VARCHAR(3),
    a_name VARCHAR(20),
    PRIMARY KEY(a_id)
);

CREATE TABLE hotels (
    h_id VARCHAR(3),
    address VARCHAR(60),
    PRIMARY KEY(h_id)
);

CREATE TABLE rooms (
    r_number NUMERIC(3, 0),
    is_vacant NUMERIC(1, 0),
    is_clean NUMERIC(1, 0),
    PRIMARY KEY(r_number)
);

CREATE TABLE room_types (
    r_type VARCHAR(20), /** single | deluxe | suite | presidential suite */
    r_capacity NUMERIC(1, 0),
    PRIMARY KEY(r_type, r_capacity) /** Necessary because capacity of each type is not standardized */
);

CREATE TABLE rates (
    rate_usd NUMERIC(5, 2),
    rate_points NUMERIC(7, 0),
    PRIMARY KEY(rate_usd) /* Works fine because $1 = 100 points across all hotels **/
);

CREATE TABLE reservations (
    res_id VARCHAR(5),
    in_time TIMESTAMP,
    out_time TIMESTAMP,
    usd NUMERIC(7, 2),
    points NUMERIC(9, 0),
    cancellation_fee NUMERIC(4, 0),
    PRIMARY KEY(res_id)
);

CREATE TABLE transactions (
    t_id VARCHAR(5),
    t_time TIMESTAMP,
    usd NUMERIC(6, 2),
    points NUMERIC(8, 0),
    PRIMARY KEY(t_id)
);

CREATE TABLE guests (
    g_id VARCHAR(5),
    fname VARCHAR(20),
    lname VARCHAR(20),
    address VARCHAR(60),
    email VARCHAR(320), /* Section 3 says: (from erratum 1003) In addition to restrictions on syntax, there is a length limit on email addresses. That limit is a maximum of 64 characters (octets) in the "local part" (before the "@") and a maximum of 255 characters (octets) in the domain part (after the "@") for a total length of 320 characters. */
    phone_number VARCHAR(14), /* (xxx) xxx-xxxx */
    cc_number VARCHAR(19), /* xxxx xxxx xxxx xxxx */
    points NUMERIC(6, 0),
    PRIMARY KEY(g_id)
);

CREATE TABLE has (
    h_id VARCHAR(3),
    a_id VARCHAR(3),
    PRIMARY KEY(h_id, a_id),
    FOREIGN KEY(h_id) REFERENCES hotels,
    FOREIGN KEY(a_id) REFERENCES ammenities
);


CREATE TABLE contains (
    h_id VARCHAR(3),
    r_number NUMERIC(3, 0),
    r_type VARCHAR(20),
    r_capacity NUMERIC(1, 0),
    PRIMARY KEY(h_id, r_number),
    FOREIGN KEY(h_id) REFERENCES hotels,
    FOREIGN KEY(r_number) REFERENCES rooms,
    FOREIGN KEY(r_type, r_capacity) REFERENCES room_types
);

CREATE TABLE costs (
    h_id VARCHAR(3),
    rate_usd NUMERIC(4, 2),
    r_type VARCHAR(20),
    r_capacity NUMERIC(1, 0),
    PRIMARY KEY(h_id, rate_usd, r_type, r_capacity),
    FOREIGN KEY(h_id) REFERENCES hotels,
    FOREIGN KEY(rate_usd) REFERENCES rates,
    FOREIGN KEY(r_type, r_capacity) REFERENCES room_types
);

CREATE TABLE represents (
    res_id VARCHAR(5),
    t_id VARCHAR(5),
    PRIMARY KEY(res_id, t_id),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(t_id) REFERENCES transactions
);

CREATE TABLE uses (
    res_id VARCHAR(5),
    rate_usd NUMERIC(4, 2),
    PRIMARY KEY(res_id, rate_usd),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(rate_usd) REFERENCES rates
);

CREATE TABLE res_type (
    res_id VARCHAR(5),
    r_type VARCHAR(20),
    r_capacity NUMERIC(1, 0),
    PRIMARY KEY(res_id),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(r_type, r_capacity) REFERENCES room_types
);

CREATE TABLE reserves (
    g_id VARCHAR(5),
    res_id VARCHAR(5),
    PRIMARY KEY(g_id, res_id),
    FOREIGN KEY(g_id) REFERENCES guests,
    FOREIGN KEY(res_id) REFERENCES reservations
);

CREATE TABLE spends (
    g_id VARCHAR(5),
    t_id VARCHAR(5),
    PRIMARY KEY(g_id, t_id),
    FOREIGN KEY(g_id) REFERENCES guests,
    FOREIGN KEY(t_id) REFERENCES transactions
);
