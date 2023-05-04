CREATE OR REPLACE PROCEDURE handleNewGuest (
    firstName IN VARCHAR,
    lastName IN VARCHAR,
    phoneNumber IN VARCHAR,
    gAddress IN VARCHAR,
    gEmail IN VARCHAR,
    ccNumber IN VARCHAR,
    fPoints IN INTEGER) IS
    gID VARCHAR(5);
BEGIN
    -- generate new gID
    SELECT MAX(g_id) INTO gID
    FROM guests;
    gID := gID + 1;
    
    -- insert new entry
    INSERT INTO guests (g_id, fname, lname, address, email, phone_number, cc_number, points) VALUES (gID, firstName, lastName, gAddress, gEmail, phoneNumber, ccNumber, fPoints);
END;