CREATE OR REPLACE FUNCTION handleWalkin (
    gID IN VARCHAR,
    inTime IN TIMESTAMP,
    outTime IN TIMESTAMP,
    roomType IN VARCHAR,
    hID IN VARCHAR) RETURN VARCHAR AS
    roomNumber VARCHAR(5);
    resID VARCHAR(5);
BEGIN
    -- get res_id
    SELECT MAX(res_id) INTO resID
    FROM reservations;
    resID := resID + 1;

    -- create reservation
    INSERT INTO reservations (res_id, in_time, out_time, usd, points, cancellation_fee, r_number) VALUES (resID, inTime, outTime, 0, 0, 50, '00000');
    
    -- insert into relationship set
    INSERT INTO reserves (g_id, res_id) VALUES (gID, resID);

    -- check guest in
    roomNumber := handleCheckin(gID, resID, roomType, hID);
    
    -- return the room given
    RETURN roomNumber;
END;