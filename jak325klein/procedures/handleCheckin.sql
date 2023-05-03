CREATE OR REPLACE FUNCTION handleCheckin (
    gID IN VARCHAR,
    resID IN VARCHAR,
    roomType IN VARCHAR,
    hID IN VARCHAR) RETURN VARCHAR AS
    roomNumber VARCHAR(5);
BEGIN
    -- find room satisfying room type, vacancy and cleanliness
    SELECT MIN(r_number) INTO roomNumber
    FROM contains NATURAL JOIN rooms
    WHERE h_id = hID AND r_type = roomType AND is_vacant = 1 AND is_clean = 1;
    
    -- set this room to occupied and unclean
    UPDATE rooms
    SET is_vacant = 0, is_clean = 0
    WHERE r_number = roomNumber;
    
    -- show this in reservation
    UPDATE reservations
    SET r_number = roomNumber
    WHERE res_id = resID;
    
    -- return the room given
    RETURN roomNumber;
END;