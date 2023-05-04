CREATE OR REPLACE PROCEDURE handleReservation (
    gID IN VARCHAR,
    inTime IN TIMESTAMP,
    outTime IN TIMESTAMP,
    roomType IN VARCHAR,
    hID IN VARCHAR) AS
    roomNumber VARCHAR(5);
    resID VARCHAR(5);
    rateUsd NUMERIC(3, 2);
    in_month INTEGER;
BEGIN
    -- get res_id
    SELECT MAX(res_id) INTO resID
    FROM reservations;
    resID := resID + 1;
    
    -- get rate
    in_month := EXTRACT(MONTH FROM inTime);
    SELECT rate_usd INTO rateUsd FROM rates
    WHERE (start_month <= end_month AND in_month >= start_month AND in_month <= end_month) OR
        (start_month > end_month AND ((in_month >= start_month AND in_month <= 12) OR (in_month >= 1 AND in_month <= end_month)));

    -- create reservation
    INSERT INTO reservations (res_id, in_time, out_time, usd, points, cancellation_fee, r_number) VALUES (lpad(resID, 5, '0'), inTime, outTime, 0, 0, 50, '00000');
    
    -- insert into relationship sets
    INSERT INTO reserves (g_id, res_id) VALUES (lpad(gID, 5, '0'), lpad(resID, 5, '0'));
    INSERT INTO res_type (res_id, r_type) VALUES (lpad(resID, 5, '0'), roomType);
    INSERT INTO uses (res_id, rate_usd) VALUES (lpad(resID, 5, '0'), rateUsd);
END;