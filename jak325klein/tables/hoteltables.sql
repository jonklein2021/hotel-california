
Table HAS dropped.


Table CONTAINS dropped.


Error starting at line : 3 in command -
DROP TABLE costs
Error report -
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:

Table REPRESENTS dropped.


Error starting at line : 5 in command -
DROP TABLE uses
Error report -
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:

Table RES_TYPE dropped.


Table RESERVES dropped.


Table SPENDS dropped.


Table AMMENITIES dropped.


Table HOTELS dropped.


Table ROOMS dropped.


Table ROOM_TYPES dropped.


Table RATES dropped.


Table RESERVATIONS dropped.


Table TRANSACTIONS dropped.


Table GUESTS dropped.


Table AMMENITIES created.


Table HOTELS created.


Table ROOMS created.


Table ROOM_TYPES created.


Table RATES created.


Table RESERVATIONS created.


Table TRANSACTIONS created.


Table GUESTS created.


Table HAS created.


Table CONTAINS created.


Error starting at line : 101 in command -
CREATE TABLE costs (
    h_id VARCHAR(3),
    rate_usd NUMERIC(4, 2),
    rate_points NUMERIC(7, 0),
    r_type VARCHAR(20),
    r_capacity NUMERIC(1, 0),
    price_usd NUMERIC(3, 0),
    PRIMARY KEY(h_id, rate_usd, r_type, r_capacity, price_usd),
    FOREIGN KEY(h_id) REFERENCES hotels,
    FOREIGN KEY(rate_usd) REFERENCES rates,
    FOREIGN KEY(r_type, r_capacity, price_usd) REFERENCES room_types (r_type, r_capacity)
)
Error report -
ORA-02256: number of referencing columns must match referenced columns
02256. 00000 -  "number of referencing columns must match referenced columns"
*Cause:    The number of columns in the foreign-key referencing list is not
           equal to the number of columns in the referenced list.
*Action:   Make sure that the referencing columns match the referenced
           columns.

Table REPRESENTS created.


Error starting at line : 122 in command -
CREATE TABLE uses (
    res_id VARCHAR(5),
    rate_usd NUMERIC(4, 2),
    PRIMARY KEY(res_id, rate_usd),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(rate_usd) REFERENCES rates
)
Error report -
ORA-02256: number of referencing columns must match referenced columns
02256. 00000 -  "number of referencing columns must match referenced columns"
*Cause:    The number of columns in the foreign-key referencing list is not
           equal to the number of columns in the referenced list.
*Action:   Make sure that the referencing columns match the referenced
           columns.

Table RES_TYPE created.


Table RESERVES created.


Table SPENDS created.


Table HAS dropped.


Table CONTAINS dropped.


Error starting at line : 3 in command -
DROP TABLE costs
Error report -
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:

Table REPRESENTS dropped.


Error starting at line : 5 in command -
DROP TABLE uses
Error report -
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:

Table RES_TYPE dropped.


Table RESERVES dropped.


Table SPENDS dropped.


Table AMMENITIES dropped.


Table HOTELS dropped.


Table ROOMS dropped.


Table ROOM_TYPES dropped.


Table RATES dropped.


Table RESERVATIONS dropped.


Table TRANSACTIONS dropped.


Table GUESTS dropped.


Table AMMENITIES created.


Table HOTELS created.


Table ROOMS created.


Table ROOM_TYPES created.


Table RATES created.


Table RESERVATIONS created.


Table TRANSACTIONS created.


Table GUESTS created.


Table HAS created.


Table CONTAINS created.


Error starting at line : 101 in command -
CREATE TABLE costs (
    h_id VARCHAR(3),
    rate_usd NUMERIC(4, 2),
    rate_points NUMERIC(7, 0),
    r_type VARCHAR(20),
    r_capacity NUMERIC(1, 0),
    price_usd NUMERIC(3, 0),
    PRIMARY KEY(h_id, rate_usd, r_type, r_capacity, price_usd),
    FOREIGN KEY(h_id) REFERENCES hotels,
    FOREIGN KEY(rate_usd, rate_points) REFERENCES rates,
    FOREIGN KEY(r_type, r_capacity, price_usd) REFERENCES room_types (r_type, r_capacity)
)
Error report -
ORA-02256: number of referencing columns must match referenced columns
02256. 00000 -  "number of referencing columns must match referenced columns"
*Cause:    The number of columns in the foreign-key referencing list is not
           equal to the number of columns in the referenced list.
*Action:   Make sure that the referencing columns match the referenced
           columns.

Table REPRESENTS created.


Error starting at line : 122 in command -
CREATE TABLE uses (
    res_id VARCHAR(5),
    rate_usd NUMERIC(4, 2),
    PRIMARY KEY(res_id, rate_usd),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(rate_usd) REFERENCES rates
)
Error report -
ORA-02256: number of referencing columns must match referenced columns
02256. 00000 -  "number of referencing columns must match referenced columns"
*Cause:    The number of columns in the foreign-key referencing list is not
           equal to the number of columns in the referenced list.
*Action:   Make sure that the referencing columns match the referenced
           columns.

Table RES_TYPE created.


Table RESERVES created.


Table SPENDS created.


Table HAS dropped.


Table CONTAINS dropped.


Error starting at line : 3 in command -
DROP TABLE costs
Error report -
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:

Table REPRESENTS dropped.


Error starting at line : 5 in command -
DROP TABLE uses
Error report -
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:

Table RES_TYPE dropped.


Table RESERVES dropped.


Table SPENDS dropped.


Table AMMENITIES dropped.


Table HOTELS dropped.


Table ROOMS dropped.


Table ROOM_TYPES dropped.


Table RATES dropped.


Table RESERVATIONS dropped.


Table TRANSACTIONS dropped.


Table GUESTS dropped.


Table AMMENITIES created.


Table HOTELS created.


Table ROOMS created.


Table ROOM_TYPES created.


Table RATES created.


Table RESERVATIONS created.


Table TRANSACTIONS created.


Table GUESTS created.


Table HAS created.


Table CONTAINS created.


Error starting at line : 101 in command -
CREATE TABLE costs (
    h_id VARCHAR(3),
    rate_usd NUMERIC(4, 2),
    rate_points NUMERIC(7, 0),
    r_type VARCHAR(20),
    r_capacity NUMERIC(1, 0),
    price_usd NUMERIC(3, 0),
    PRIMARY KEY(h_id, rate_usd, r_type, r_capacity, price_usd),
    FOREIGN KEY(h_id) REFERENCES hotels,
    FOREIGN KEY(rate_usd, rate_points) REFERENCES rates,
    FOREIGN KEY(r_type, r_capacity, price_usd) REFERENCES room_types (r_type, r_capacity)
)
Error report -
ORA-02256: number of referencing columns must match referenced columns
02256. 00000 -  "number of referencing columns must match referenced columns"
*Cause:    The number of columns in the foreign-key referencing list is not
           equal to the number of columns in the referenced list.
*Action:   Make sure that the referencing columns match the referenced
           columns.

Table REPRESENTS created.


Error starting at line : 122 in command -
CREATE TABLE uses (
    res_id VARCHAR(5),
    rate_usd NUMERIC(4, 2),
    PRIMARY KEY(res_id, rate_usd),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(rate_usd) REFERENCES rates
)
Error report -
ORA-02256: number of referencing columns must match referenced columns
02256. 00000 -  "number of referencing columns must match referenced columns"
*Cause:    The number of columns in the foreign-key referencing list is not
           equal to the number of columns in the referenced list.
*Action:   Make sure that the referencing columns match the referenced
           columns.

Table RES_TYPE created.


Table RESERVES created.


Table SPENDS created.


Table HAS dropped.


Table CONTAINS dropped.


Error starting at line : 3 in command -
DROP TABLE costs
Error report -
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:

Table REPRESENTS dropped.


Error starting at line : 5 in command -
DROP TABLE uses
Error report -
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:

Table RES_TYPE dropped.


Table RESERVES dropped.


Table SPENDS dropped.


Table AMMENITIES dropped.


Table HOTELS dropped.


Table ROOMS dropped.


Table ROOM_TYPES dropped.


Table RATES dropped.


Table RESERVATIONS dropped.


Table TRANSACTIONS dropped.


Table GUESTS dropped.


Table AMMENITIES created.


Table HOTELS created.


Table ROOMS created.


Table ROOM_TYPES created.


Table RATES created.


Table RESERVATIONS created.


Table TRANSACTIONS created.


Table GUESTS created.


Table HAS created.


Table CONTAINS created.


Error starting at line : 101 in command -
CREATE TABLE costs (
    h_id VARCHAR(3),
    rate_usd NUMERIC(4, 2),
    rate_points NUMERIC(7, 0),
    r_type VARCHAR(20),
    r_capacity NUMERIC(1, 0),
    price_usd NUMERIC(3, 0),
    PRIMARY KEY(h_id, rate_usd, r_type, r_capacity, price_usd),
    FOREIGN KEY(h_id) REFERENCES hotels,
    FOREIGN KEY(rate_usd, rate_points) REFERENCES rates,
    FOREIGN KEY(r_type, r_capacity, price_usd) REFERENCES room_types --(r_type, r_capacity)
)
Error report -
ORA-02256: number of referencing columns must match referenced columns
02256. 00000 -  "number of referencing columns must match referenced columns"
*Cause:    The number of columns in the foreign-key referencing list is not
           equal to the number of columns in the referenced list.
*Action:   Make sure that the referencing columns match the referenced
           columns.

Table REPRESENTS created.


Error starting at line : 122 in command -
CREATE TABLE uses (
    res_id VARCHAR(5),
    rate_usd NUMERIC(4, 2),
    PRIMARY KEY(res_id, rate_usd),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(rate_usd) REFERENCES rates
)
Error report -
ORA-02256: number of referencing columns must match referenced columns
02256. 00000 -  "number of referencing columns must match referenced columns"
*Cause:    The number of columns in the foreign-key referencing list is not
           equal to the number of columns in the referenced list.
*Action:   Make sure that the referencing columns match the referenced
           columns.

Table RES_TYPE created.


Table RESERVES created.


Table SPENDS created.


Table HAS dropped.


Table CONTAINS dropped.


Error starting at line : 3 in command -
DROP TABLE costs
Error report -
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:

Table REPRESENTS dropped.


Error starting at line : 5 in command -
DROP TABLE uses
Error report -
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:

Table RES_TYPE dropped.


Table RESERVES dropped.


Table SPENDS dropped.


Table AMMENITIES dropped.


Table HOTELS dropped.


Table ROOMS dropped.


Table ROOM_TYPES dropped.


Table RATES dropped.


Table RESERVATIONS dropped.


Table TRANSACTIONS dropped.


Table GUESTS dropped.


Table AMMENITIES created.


Table HOTELS created.


Table ROOMS created.


Table ROOM_TYPES created.


Table RATES created.


Table RESERVATIONS created.


Table TRANSACTIONS created.


Table GUESTS created.


Table HAS created.


Table CONTAINS created.


Error starting at line : 101 in command -
CREATE TABLE costs (
    h_id VARCHAR(3),
    rate_usd NUMERIC(5, 2),
    rate_points NUMERIC(7, 0),
    r_type VARCHAR(20),
    r_capacity NUMERIC(1, 0),
    price_usd NUMERIC(3, 0),
    PRIMARY KEY(h_id, rate_usd, r_type, r_capacity, price_usd),
    FOREIGN KEY(h_id) REFERENCES hotels,
    FOREIGN KEY(rate_usd, rate_points) REFERENCES rates,
    FOREIGN KEY(r_type, r_capacity, price_usd) REFERENCES room_types --(r_type, r_capacity)
)
Error report -
ORA-02256: number of referencing columns must match referenced columns
02256. 00000 -  "number of referencing columns must match referenced columns"
*Cause:    The number of columns in the foreign-key referencing list is not
           equal to the number of columns in the referenced list.
*Action:   Make sure that the referencing columns match the referenced
           columns.

Table REPRESENTS created.


Error starting at line : 122 in command -
CREATE TABLE uses (
    res_id VARCHAR(5),
    rate_usd NUMERIC(4, 2),
    PRIMARY KEY(res_id, rate_usd),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(rate_usd) REFERENCES rates
)
Error report -
ORA-02256: number of referencing columns must match referenced columns
02256. 00000 -  "number of referencing columns must match referenced columns"
*Cause:    The number of columns in the foreign-key referencing list is not
           equal to the number of columns in the referenced list.
*Action:   Make sure that the referencing columns match the referenced
           columns.

Table RES_TYPE created.


Table RESERVES created.


Table SPENDS created.


Table HAS dropped.


Table CONTAINS dropped.


Error starting at line : 3 in command -
DROP TABLE costs
Error report -
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:

Table REPRESENTS dropped.


Error starting at line : 5 in command -
DROP TABLE uses
Error report -
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:

Table RES_TYPE dropped.


Table RESERVES dropped.


Table SPENDS dropped.


Table AMMENITIES dropped.


Table HOTELS dropped.


Table ROOMS dropped.


Table ROOM_TYPES dropped.


Table RATES dropped.


Table RESERVATIONS dropped.


Table TRANSACTIONS dropped.


Table GUESTS dropped.


Table AMMENITIES created.


Table HOTELS created.


Table ROOMS created.


Table ROOM_TYPES created.


Table RATES created.


Table RESERVATIONS created.


Table TRANSACTIONS created.


Table GUESTS created.


Table HAS created.


Table CONTAINS created.


Table COSTS created.


Table REPRESENTS created.


Error starting at line : 122 in command -
CREATE TABLE uses (
    res_id VARCHAR(5),
    rate_usd NUMERIC(4, 2),
    PRIMARY KEY(res_id, rate_usd),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(rate_usd) REFERENCES rates
)
Error report -
ORA-02256: number of referencing columns must match referenced columns
02256. 00000 -  "number of referencing columns must match referenced columns"
*Cause:    The number of columns in the foreign-key referencing list is not
           equal to the number of columns in the referenced list.
*Action:   Make sure that the referencing columns match the referenced
           columns.

Table RES_TYPE created.


Table RESERVES created.


Table SPENDS created.


Table HAS dropped.


Table CONTAINS dropped.


Table COSTS dropped.


Table REPRESENTS dropped.


Error starting at line : 5 in command -
DROP TABLE uses
Error report -
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:

Table RES_TYPE dropped.


Table RESERVES dropped.


Table SPENDS dropped.


Table AMMENITIES dropped.


Table HOTELS dropped.


Table ROOMS dropped.


Table ROOM_TYPES dropped.


Table RATES dropped.


Table RESERVATIONS dropped.


Table TRANSACTIONS dropped.


Table GUESTS dropped.


Table AMMENITIES created.


Table HOTELS created.


Table ROOMS created.


Table ROOM_TYPES created.


Table RATES created.


Table RESERVATIONS created.


Table TRANSACTIONS created.


Table GUESTS created.


Table HAS created.


Table CONTAINS created.


Table COSTS created.


Table REPRESENTS created.


Table USES created.


Table RES_TYPE created.


Table RESERVES created.


Table SPENDS created.


Table HAS dropped.


Table CONTAINS dropped.


Table COSTS dropped.


Table REPRESENTS dropped.


Table USES dropped.


Table RES_TYPE dropped.


Table RESERVES dropped.


Table SPENDS dropped.


Table AMMENITIES dropped.


Table HOTELS dropped.


Table ROOMS dropped.


Table ROOM_TYPES dropped.


Table RATES dropped.


Table RESERVATIONS dropped.


Table TRANSACTIONS dropped.


Table GUESTS dropped.


Table AMMENITIES created.


Table HOTELS created.


Table ROOMS created.


Table ROOM_TYPES created.


Table RATES created.


Table RESERVATIONS created.


Table TRANSACTIONS created.


Table GUESTS created.


Table HAS created.


Table CONTAINS created.


Table COSTS created.


Table REPRESENTS created.


Table USES created.


Table RES_TYPE created.


Table RESERVES created.


Table SPENDS created.


Table HAS dropped.


Table CONTAINS dropped.


Table COSTS dropped.


Error starting at line : 4 in command -
DROP TABLE represents
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 5 in command -
DROP TABLE uses
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 6 in command -
DROP TABLE res_type
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 7 in command -
DROP TABLE reserves
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 8 in command -
DROP TABLE spends
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Table AMMENITIES dropped.


Table HOTELS dropped.


Table ROOMS dropped.


Error starting at line : 12 in command -
DROP TABLE room_types
Error report -
ORA-02449: unique/primary keys in table referenced by foreign keys
02449. 00000 -  "unique/primary keys in table referenced by foreign keys"
*Cause:    An attempt was made to drop a table with unique or
           primary keys referenced by foreign keys in another table.
*Action:   Before performing the above operations the table, drop the
           foreign key constraints in other tables. You can see what
           constraints are referencing a table by issuing the following
           command:
           SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "tabnam";

Error starting at line : 13 in command -
DROP TABLE rates
Error report -
ORA-02449: unique/primary keys in table referenced by foreign keys
02449. 00000 -  "unique/primary keys in table referenced by foreign keys"
*Cause:    An attempt was made to drop a table with unique or
           primary keys referenced by foreign keys in another table.
*Action:   Before performing the above operations the table, drop the
           foreign key constraints in other tables. You can see what
           constraints are referencing a table by issuing the following
           command:
           SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "tabnam";

Error starting at line : 14 in command -
DROP TABLE reservations
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 15 in command -
DROP TABLE transactions
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 16 in command -
DROP TABLE guests
Error report -
ORA-02449: unique/primary keys in table referenced by foreign keys
02449. 00000 -  "unique/primary keys in table referenced by foreign keys"
*Cause:    An attempt was made to drop a table with unique or
           primary keys referenced by foreign keys in another table.
*Action:   Before performing the above operations the table, drop the
           foreign key constraints in other tables. You can see what
           constraints are referencing a table by issuing the following
           command:
           SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "tabnam";

Table AMMENITIES created.


Table HOTELS created.


Table ROOMS created.


Error starting at line : 37 in command -
CREATE TABLE room_types (
    r_type VARCHAR(20), /* single | deluxe | suite | presidential suite */
    r_capacity NUMERIC(1, 0),
    price_usd NUMERIC(3, 0), /* points derived via usd * 100 */
    PRIMARY KEY(r_type, r_capacity) /* Necessary because capacity of each type is not standardized */
)
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

Error starting at line : 44 in command -
CREATE TABLE rates (
    start_month NUMERIC(2, 0),
    end_month NUMERIC(2, 0),
    rate_usd NUMERIC(5, 2),
    rate_points NUMERIC(7, 0),
    PRIMARY KEY(rate_usd) /* Valid because rate_usd -> rate_points */
)
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

Error starting at line : 52 in command -
CREATE TABLE reservations (
    res_id VARCHAR(5),
    in_time TIMESTAMP,
    out_time TIMESTAMP,
    usd NUMERIC(7, 2),
    points NUMERIC(9, 0),
    cancellation_fee NUMERIC(4, 0),
    PRIMARY KEY(res_id)
)
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

Error starting at line : 62 in command -
CREATE TABLE transactions (
    t_id VARCHAR(5),
    t_time TIMESTAMP,
    usd NUMERIC(6, 2),
    points NUMERIC(8, 0),
    PRIMARY KEY(t_id)
)
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

Error starting at line : 70 in command -
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
)
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

Table HAS created.


Table CONTAINS created.


Error starting at line : 103 in command -
CREATE TABLE costs (
    h_id VARCHAR(3),
    rate_usd NUMERIC(5, 2),
    r_type VARCHAR(20),
    r_capacity NUMERIC(1, 0),
    price_usd NUMERIC(3, 0),
    PRIMARY KEY(h_id, rate_usd, r_type, r_capacity, price_usd),
    FOREIGN KEY(h_id) REFERENCES hotels,
    FOREIGN KEY(rate_usd) REFERENCES rates,
    FOREIGN KEY(r_type, r_capacity) REFERENCES room_types
)
Error report -
ORA-02256: number of referencing columns must match referenced columns
02256. 00000 -  "number of referencing columns must match referenced columns"
*Cause:    The number of columns in the foreign-key referencing list is not
           equal to the number of columns in the referenced list.
*Action:   Make sure that the referencing columns match the referenced
           columns.

Error starting at line : 115 in command -
CREATE TABLE represents (
    res_id VARCHAR(5),
    t_id VARCHAR(5),
    PRIMARY KEY(res_id), -- each reservation uniquely identifies a transaction
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(t_id) REFERENCES transactions
)
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 123 in command -
CREATE TABLE uses (
    res_id VARCHAR(5),
    rate_usd NUMERIC(4, 2),
    PRIMARY KEY(res_id, rate_usd),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(rate_usd) REFERENCES rates
)
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 131 in command -
CREATE TABLE res_type (
    res_id VARCHAR(5),
    r_type VARCHAR(20),
    r_capacity NUMERIC(1, 0),
    PRIMARY KEY(res_id),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(r_type, r_capacity) REFERENCES room_types
)
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 140 in command -
CREATE TABLE reserves (
    g_id VARCHAR(5),
    res_id VARCHAR(5),
    PRIMARY KEY(g_id, res_id),
    FOREIGN KEY(g_id) REFERENCES guests,
    FOREIGN KEY(res_id) REFERENCES reservations
)
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 148 in command -
CREATE TABLE spends (
    g_id VARCHAR(5),
    t_id VARCHAR(5),
    PRIMARY KEY(g_id, t_id),
    FOREIGN KEY(g_id) REFERENCES guests,
    FOREIGN KEY(t_id) REFERENCES transactions
)
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Table HAS dropped.


Table CONTAINS dropped.


Error starting at line : 3 in command -
DROP TABLE costs
Error report -
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:

Error starting at line : 4 in command -
DROP TABLE represents
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 5 in command -
DROP TABLE uses
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 6 in command -
DROP TABLE res_type
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 7 in command -
DROP TABLE reserves
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 8 in command -
DROP TABLE spends
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Table AMMENITIES dropped.


Table HOTELS dropped.


Table ROOMS dropped.


Error starting at line : 12 in command -
DROP TABLE room_types
Error report -
ORA-02449: unique/primary keys in table referenced by foreign keys
02449. 00000 -  "unique/primary keys in table referenced by foreign keys"
*Cause:    An attempt was made to drop a table with unique or
           primary keys referenced by foreign keys in another table.
*Action:   Before performing the above operations the table, drop the
           foreign key constraints in other tables. You can see what
           constraints are referencing a table by issuing the following
           command:
           SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "tabnam";

Error starting at line : 13 in command -
DROP TABLE rates
Error report -
ORA-02449: unique/primary keys in table referenced by foreign keys
02449. 00000 -  "unique/primary keys in table referenced by foreign keys"
*Cause:    An attempt was made to drop a table with unique or
           primary keys referenced by foreign keys in another table.
*Action:   Before performing the above operations the table, drop the
           foreign key constraints in other tables. You can see what
           constraints are referencing a table by issuing the following
           command:
           SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "tabnam";

Error starting at line : 14 in command -
DROP TABLE reservations
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 15 in command -
DROP TABLE transactions
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 16 in command -
DROP TABLE guests
Error report -
ORA-02449: unique/primary keys in table referenced by foreign keys
02449. 00000 -  "unique/primary keys in table referenced by foreign keys"
*Cause:    An attempt was made to drop a table with unique or
           primary keys referenced by foreign keys in another table.
*Action:   Before performing the above operations the table, drop the
           foreign key constraints in other tables. You can see what
           constraints are referencing a table by issuing the following
           command:
           SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "tabnam";

Table AMMENITIES created.


Table HOTELS created.


Table ROOMS created.


Error starting at line : 37 in command -
CREATE TABLE room_types (
    r_type VARCHAR(20), /* single | deluxe | suite | presidential suite */
    r_capacity NUMERIC(1, 0),
    price_usd NUMERIC(3, 0), /* points derived via usd * 100 */
    PRIMARY KEY(r_type, r_capacity) /* Necessary because capacity of each type is not standardized */
)
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

Error starting at line : 44 in command -
CREATE TABLE rates (
    start_month NUMERIC(2, 0),
    end_month NUMERIC(2, 0),
    rate_usd NUMERIC(5, 2),
    rate_points NUMERIC(7, 0),
    PRIMARY KEY(rate_usd) /* Valid because rate_usd -> rate_points */
)
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

Error starting at line : 52 in command -
CREATE TABLE reservations (
    res_id VARCHAR(5),
    in_time TIMESTAMP,
    out_time TIMESTAMP,
    usd NUMERIC(7, 2),
    points NUMERIC(9, 0),
    cancellation_fee NUMERIC(4, 0),
    PRIMARY KEY(res_id)
)
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

Error starting at line : 62 in command -
CREATE TABLE transactions (
    t_id VARCHAR(5),
    t_time TIMESTAMP,
    usd NUMERIC(6, 2),
    points NUMERIC(8, 0),
    PRIMARY KEY(t_id)
)
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

Error starting at line : 70 in command -
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
)
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

Table HAS created.


Table CONTAINS created.


Error starting at line : 103 in command -
CREATE TABLE costs (
    h_id VARCHAR(3),
    rate_usd NUMERIC(5, 2),
    r_type VARCHAR(20),
    r_capacity NUMERIC(1, 0),
    price_usd NUMERIC(3, 0),
    PRIMARY KEY(h_id, rate_usd, r_type, r_capacity, price_usd),
    FOREIGN KEY(h_id) REFERENCES hotels,
    FOREIGN KEY(rate_usd) REFERENCES rates,
    FOREIGN KEY(r_type, r_capacity) REFERENCES room_types
)
Error report -
ORA-02256: number of referencing columns must match referenced columns
02256. 00000 -  "number of referencing columns must match referenced columns"
*Cause:    The number of columns in the foreign-key referencing list is not
           equal to the number of columns in the referenced list.
*Action:   Make sure that the referencing columns match the referenced
           columns.

Error starting at line : 115 in command -
CREATE TABLE represents (
    res_id VARCHAR(5),
    t_id VARCHAR(5),
    PRIMARY KEY(res_id), -- each reservation uniquely identifies a transaction
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(t_id) REFERENCES transactions
)
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 123 in command -
CREATE TABLE uses (
    res_id VARCHAR(5),
    rate_usd NUMERIC(4, 2),
    PRIMARY KEY(res_id, rate_usd),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(rate_usd) REFERENCES rates
)
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 131 in command -
CREATE TABLE res_type (
    res_id VARCHAR(5),
    r_type VARCHAR(20),
    r_capacity NUMERIC(1, 0),
    PRIMARY KEY(res_id),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(r_type, r_capacity) REFERENCES room_types
)
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 140 in command -
CREATE TABLE reserves (
    g_id VARCHAR(5),
    res_id VARCHAR(5),
    PRIMARY KEY(g_id, res_id),
    FOREIGN KEY(g_id) REFERENCES guests,
    FOREIGN KEY(res_id) REFERENCES reservations
)
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 148 in command -
CREATE TABLE spends (
    g_id VARCHAR(5),
    t_id VARCHAR(5),
    PRIMARY KEY(g_id, t_id),
    FOREIGN KEY(g_id) REFERENCES guests,
    FOREIGN KEY(t_id) REFERENCES transactions
)
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Table HAS dropped.


Table CONTAINS dropped.


Error starting at line : 3 in command -
DROP TABLE costs
Error report -
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:

Error starting at line : 4 in command -
DROP TABLE represents
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 5 in command -
DROP TABLE uses
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 6 in command -
DROP TABLE res_type
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 7 in command -
DROP TABLE reserves
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 8 in command -
DROP TABLE spends
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Table AMMENITIES dropped.


Table HOTELS dropped.


Table ROOMS dropped.


Error starting at line : 12 in command -
DROP TABLE room_types
Error report -
ORA-02449: unique/primary keys in table referenced by foreign keys
02449. 00000 -  "unique/primary keys in table referenced by foreign keys"
*Cause:    An attempt was made to drop a table with unique or
           primary keys referenced by foreign keys in another table.
*Action:   Before performing the above operations the table, drop the
           foreign key constraints in other tables. You can see what
           constraints are referencing a table by issuing the following
           command:
           SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "tabnam";

Error starting at line : 13 in command -
DROP TABLE rates
Error report -
ORA-02449: unique/primary keys in table referenced by foreign keys
02449. 00000 -  "unique/primary keys in table referenced by foreign keys"
*Cause:    An attempt was made to drop a table with unique or
           primary keys referenced by foreign keys in another table.
*Action:   Before performing the above operations the table, drop the
           foreign key constraints in other tables. You can see what
           constraints are referencing a table by issuing the following
           command:
           SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "tabnam";

Error starting at line : 14 in command -
DROP TABLE reservations
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 15 in command -
DROP TABLE transactions
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 16 in command -
DROP TABLE guests
Error report -
ORA-02449: unique/primary keys in table referenced by foreign keys
02449. 00000 -  "unique/primary keys in table referenced by foreign keys"
*Cause:    An attempt was made to drop a table with unique or
           primary keys referenced by foreign keys in another table.
*Action:   Before performing the above operations the table, drop the
           foreign key constraints in other tables. You can see what
           constraints are referencing a table by issuing the following
           command:
           SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "tabnam";

Table AMMENITIES created.


Table HOTELS created.


Table ROOMS created.


Error starting at line : 37 in command -
CREATE TABLE room_types (
    r_type VARCHAR(20), /* single | deluxe | suite | presidential suite */
    r_capacity NUMERIC(1, 0),
    price_usd NUMERIC(3, 0), /* points derived via usd * 100 */
    PRIMARY KEY(r_type, r_capacity) /* Necessary because capacity of each type is not standardized */
)
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

Error starting at line : 44 in command -
CREATE TABLE rates (
    start_month NUMERIC(2, 0),
    end_month NUMERIC(2, 0),
    rate_usd NUMERIC(5, 2),
    rate_points NUMERIC(7, 0),
    PRIMARY KEY(rate_usd) /* Valid because rate_usd -> rate_points */
)
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

Error starting at line : 52 in command -
CREATE TABLE reservations (
    res_id VARCHAR(5),
    in_time TIMESTAMP,
    out_time TIMESTAMP,
    usd NUMERIC(7, 2),
    points NUMERIC(9, 0),
    cancellation_fee NUMERIC(4, 0),
    PRIMARY KEY(res_id)
)
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

Error starting at line : 62 in command -
CREATE TABLE transactions (
    t_id VARCHAR(5),
    t_time TIMESTAMP,
    usd NUMERIC(6, 2),
    points NUMERIC(8, 0),
    PRIMARY KEY(t_id)
)
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

Error starting at line : 70 in command -
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
)
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

Table HAS created.


Table CONTAINS created.


Error starting at line : 103 in command -
CREATE TABLE costs (
    h_id VARCHAR(3),
    rate_usd NUMERIC(5, 2),
    r_type VARCHAR(20),
    r_capacity NUMERIC(1, 0),
    price_usd NUMERIC(3, 0),
    PRIMARY KEY(h_id, rate_usd, r_type, r_capacity, price_usd),
    FOREIGN KEY(h_id) REFERENCES hotels,
    FOREIGN KEY(rate_usd) REFERENCES rates,
    FOREIGN KEY(r_type, r_capacity) REFERENCES room_types
)
Error report -
ORA-02256: number of referencing columns must match referenced columns
02256. 00000 -  "number of referencing columns must match referenced columns"
*Cause:    The number of columns in the foreign-key referencing list is not
           equal to the number of columns in the referenced list.
*Action:   Make sure that the referencing columns match the referenced
           columns.

Error starting at line : 115 in command -
CREATE TABLE represents (
    res_id VARCHAR(5),
    t_id VARCHAR(5),
    PRIMARY KEY(res_id), -- each reservation uniquely identifies a transaction
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(t_id) REFERENCES transactions
)
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 123 in command -
CREATE TABLE uses (
    res_id VARCHAR(5),
    rate_usd NUMERIC(4, 2),
    PRIMARY KEY(res_id, rate_usd),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(rate_usd) REFERENCES rates
)
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 131 in command -
CREATE TABLE res_type (
    res_id VARCHAR(5),
    r_type VARCHAR(20),
    r_capacity NUMERIC(1, 0),
    PRIMARY KEY(res_id),
    FOREIGN KEY(res_id) REFERENCES reservations,
    FOREIGN KEY(r_type, r_capacity) REFERENCES room_types
)
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 140 in command -
CREATE TABLE reserves (
    g_id VARCHAR(5),
    res_id VARCHAR(5),
    PRIMARY KEY(g_id, res_id),
    FOREIGN KEY(g_id) REFERENCES guests,
    FOREIGN KEY(res_id) REFERENCES reservations
)
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.

Error starting at line : 148 in command -
CREATE TABLE spends (
    g_id VARCHAR(5),
    t_id VARCHAR(5),
    PRIMARY KEY(g_id, t_id),
    FOREIGN KEY(g_id) REFERENCES guests,
    FOREIGN KEY(t_id) REFERENCES transactions
)
Error report -
ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired
00054. 00000 -  "resource busy and acquire with NOWAIT specified or timeout expired"
*Cause:    Interested resource is busy.
*Action:   Retry if necessary or increase timeout.
