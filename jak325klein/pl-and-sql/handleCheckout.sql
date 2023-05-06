CREATE OR REPLACE PROCEDURE handleCheckout (
    resID IN VARCHAR, -- res_id
    inTime IN TIMESTAMP, -- in_time
    outTime IN TIMESTAMP, -- out_time
    usdPaid IN FLOAT,
    pointsPaid IN NUMERIC,
    gID IN VARCHAR) IS
    tID VARCHAR(5);
    roomID VARCHAR(5);
    guestPoints INTEGER;
BEGIN
    -- get new t_id
    SELECT MAX(t_id) INTO tID FROM transactions;
    tID := tID + 1;

     -- get room number
    SELECT r_number INTO roomID
    FROM reservations WHERE res_id = resID;

    -- record guest paying his/her stay
    UPDATE reservations
    SET usd = usdPaid, points = pointsPaid
    WHERE res_id = resID;

    -- record in tx table
    INSERT INTO transactions (t_id, t_time, usd, points) VALUES (lpad(tID, 5, '0'), outTime, usdPaid, pointsPaid);

    -- record in res <- tx set
    INSERT INTO represents (res_id, t_id) VALUES (lpad(resID, 5, '0'), lpad(tID, 5, '0'));
    
    -- record in tx -> guests set
    INSERT INTO spends (g_id, t_id) VALUES (lpad(gID, 5, '0'), lpad(tID, 5, '0'));
    
    -- if guest a frequent member, award them points
    SELECT points INTO guestPoints FROM guests
    WHERE g_id = gID;
    
    IF guestPoints >= 0 THEN
        UPDATE guests
        SET points = points + 500*EXTRACT(DAY FROM (outTime - inTime)) -- 500 points per night stayed
        WHERE g_id = gID;
    END IF;

    -- deduct guest's points
    UPDATE guests
    SET points = points - pointsPaid
    WHERE g_id = gID;

    -- set room as vacant and unclean
    UPDATE rooms
    SET is_vacant = 1, is_clean = 0
    WHERE r_number = roomID;

END;