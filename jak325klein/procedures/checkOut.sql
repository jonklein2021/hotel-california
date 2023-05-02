CREATE OR REPLACE PROCEDURE checkOutGuest (
    gID IN VARCHAR,
    rID IN VARCHAR,
    inTime IN TIMESTAMP,
    outTime IN TIMESTAMP,
    usdPaid IN NUMBER) IS
    tID VARCHAR(5);
    roomID VARCHAR(5);
    roomType VARCHAR(20);
    usdMultiplier NUMERIC(3, 2);
    pointsMultiplier NUMERIC(3, 2);
    usdCost NUMERIC(5, 2);
    pointsCost NUMERIC(7, 0);
    in_month INTEGER;
BEGIN
    -- get new t_id
    SELECT MAX(t_id) INTO tID FROM transactions;
    tID := tID + 1;
    
    usdCost := determineCostUsd(rID, inTime);    
    pointsCost := usdCost*100;
    
    usdCost := usdCost*usdMultiplier*EXTRACT(DAY FROM (outTime - inTime));
    pointsCost := pointsMultiplier*EXTRACT(DAY FROM (outTime - inTime));
    
    -- determine payment method
    IF usdPaid = 1 THEN
        pointsCost := 0;
    ELSE
        usdCost := 0;
    END IF;
    
    -- record guest paying his/her stay
    UPDATE reservations
    SET usd = usdCost, points = pointsCost
    WHERE res_id = rID;
    
    -- record in tx table
    INSERT INTO transactions (t_id, t_time, usd, points) VALUES (tID, outTime, usdCost, pointsCost);
    
    -- record in res <- tx set
    INSERT INTO represents (res_id, t_id) VALUES (rID, tID);
    
    -- set room as vacant and unclean
    UPDATE rooms
    SET is_vacant = 1, is_clean = 0
    WHERE r_number = roomID;
    
END;