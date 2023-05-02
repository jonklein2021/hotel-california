CREATE OR REPLACE FUNCTION determineCostUsd (
    rID IN VARCHAR,
    inTime IN TIMESTAMP) RETURN INTEGER AS
    roomID VARCHAR(5);
    roomType VARCHAR(20);
    usdMultiplier NUMERIC(3, 2);
    pointsMultiplier NUMERIC(3, 2);
    usdCost NUMERIC(5, 2);
    in_month INTEGER;
BEGIN
     -- get room number
    SELECT r_number INTO roomID
    FROM reservations WHERE res_id = rID;
    
    -- get room type
    SELECT r_type, price_usd INTO roomType, usdCost
    FROM contains NATURAL JOIN room_types
    WHERE r_number = roomID;
    
    -- determine price
    in_month := EXTRACT(MONTH FROM inTime);
    SELECT rate_usd, rate_points INTO usdMultiplier, pointsMultiplier FROM rates
    WHERE (start_month <= end_month AND in_month >= start_month AND in_month <= end_month) OR
        (start_month < end_month AND (in_month >= start_month AND in_month <= 12) OR (in_month >= 1 AND in_month <= end_month));
        
    RETURN usdCost;

END;