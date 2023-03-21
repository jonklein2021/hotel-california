DROP TABLE has; /** ammenities -- hotels */
DROP TABLE contains; /** hotels <- rooms */
DROP TABLE costs; /** rates -> hotels */
DROP TABLE represents; /** reservations <- transactions */
DROP TABLE uses; /** rates <-> reservations */
DROP TABLE res_type; /** reservations -> room_types */
DROP TABLE reserves; /** reservations -> guests */
DROP TABLE spends; /** transations -> guests */
DROP TABLE ammenities;
DROP TABLE hotels;
DROP TABLE rooms;
DROP TABLE room_types;
DROP TABLE rates;
DROP TABLE reservations;
DROP TABLE transactions;
DROP TABLE guests;

CREATE TABLE ammenities (
    a_id NUMERIC(3, 0),
    a_name VARCHAR(20),
    PRIMARY KEY(a_id)
);

CREATE TABLE hotels (
    h_id NUMERIC(3, 0),
    address VARCHAR(50),
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
    rate_usd NUMERIC(4, 0),
    rate_points NUMERIC(6, 0),
    PRIMARY KEY(rate_usd) /* Works fine because $1 = 100 points across all hotels **/
);

CREATE TABLE reservations (
    res_id NUMERIC(5, 0),
    in_time TIMESTAMP,
    out_time TIMESTAMP,
    cost_usd NUMERIC(5, 0),
    cost_points NUMERIC(7, 0),
    cancellation_fee NUMERIC(2, 0),
    PRIMARY KEY(res_id)
);

CREATE TABLE transactions (
    t_id NUMERIC(5, 0),
    t_time TIMESTAMP,
    usd NUMERIC(4, 0),
    points NUMERIC(6, 0),
    PRIMARY KEY(t_id)
);

CREATE TABLE guests (
    g_id NUMERIC(6, 0),
    name_first VARCHAR(20),
    name_last VARCHAR(20),
    address VARCHAR(50),
    phone_number NUMERIC(10, 0),
    cc_number NUMERIC(16, 0),
    points NUMERIC(6, 0),
    PRIMARY KEY(g_id)
);

CREATE TABLE has (
    h_id NUMERIC(3, 0),
    a_id NUMERIC(3, 0),
    PRIMARY KEY(h_id, a_id),
    FOREIGN KEY(h_id) REFERENCES hotels,
    FOREIGN KEY(a_id) REFERENCES ammenities
);


CREATE TABLE contains (
    h_id NUMERIC(3, 0),
    r_number NUMERIC(3, 0),
    r_type VARCHAR(20),
    r_capacity NUMERIC(1, 0),
    PRIMARY KEY(h_id, r_number),
    FOREIGN KEY(h_id) REFERENCES hotels,
    FOREIGN KEY(r_number) REFERENCES rooms,
    FOREIGN KEY(r_type, r_capacity) REFERENCES room_types
);

CREATE TABLE costs (
    h_id NUMERIC(3, 0),
    rate_usd NUMERIC(4, 0),
    r_type VARCHAR(20),
    r_capacity NUMERIC(1, 0),
    PRIMARY KEY(h_id, rate_usd, r_type, r_capacity),
    FOREIGN KEY(h_id) REFERENCES hotels,
    FOREIGN KEY(rate_usd) REFERENCES rates,
    FOREIGN KEY(r_type, r_capacity) REFERENCES room_types
);

CREATE TABLE represents (
    res_id NUMERIC(5, 0),
    t_id NUMERIC(5, 0),
    PRIMARY KEY(res_id, t_id),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(t_id) REFERENCES transactions
);

CREATE TABLE uses (
    res_id NUMERIC(5, 0),
    rate_usd NUMERIC(4, 0),
    PRIMARY KEY(res_id, rate_usd),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(rate_usd) REFERENCES rates
);

CREATE TABLE reserves (
    g_id NUMERIC(6, 0),
    res_id NUMERIC(5, 0),
    PRIMARY KEY(g_id, res_id),
    FOREIGN KEY(g_id) REFERENCES guests,
    FOREIGN KEY(res_id) REFERENCES reservations
);

CREATE TABLE spends (
    g_id NUMERIC(6, 0),
    t_id NUMERIC(5, 0),
    PRIMARY KEY(g_id, t_id),
    FOREIGN KEY(g_id) REFERENCES guests,
    FOREIGN KEY(t_id) REFERENCES transactions
);
