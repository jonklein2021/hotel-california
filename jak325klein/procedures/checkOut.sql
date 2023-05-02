CREATE OR REPLACE PROCEDURE checkOutGuest (
    rID IN VARCHAR, -- res_id
    inTime IN TIMESTAMP, -- in_time
    outTime IN TIMESTAMP, -- out_time
    usdPaid IN FLOAT,
    pointsPaid IN NUMERIC) IS -- amount that guest paid
    tID VARCHAR(5);
    roomID VARCHAR(5);
BEGIN
    -- get new t_id
    SELECT MAX(t_id) INTO tID FROM transactions;
    tID := tID + 1;
    
     -- get room number
    SELECT r_number INTO roomID
    FROM reservations WHERE res_id = rID;
    
    -- record guest paying his/her stay
    UPDATE reservations
    SET usd = usdPaid, points = pointsPaid
    WHERE res_id = rID;
    
    -- record in tx table
    INSERT INTO transactions (t_id, t_time, usd, points) VALUES (tID, outTime, usdPaid, pointsPaid);
    
    -- record in res <- tx set
    INSERT INTO represents (res_id, t_id) VALUES (rID, tID);
    
    -- set room as vacant and unclean
    UPDATE rooms
    SET is_vacant = 1, is_clean = 0
    WHERE r_number = roomID;
    
END;