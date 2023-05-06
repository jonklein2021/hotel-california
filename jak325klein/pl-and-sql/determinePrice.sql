CREATE OR REPLACE FUNCTION determinePrice (
    resID IN VARCHAR,
    resDuration IN INTEGER) RETURN FLOAT AS
    roomID VARCHAR(5);
    roomType VARCHAR(20);
    usdMultiplier NUMERIC(3, 2);
    usdCost NUMERIC(5, 2);
BEGIN
     -- get room number
    SELECT r_number INTO roomID
    FROM reservations WHERE res_id = resID;

    -- get room type
    SELECT r_type, price_usd INTO roomType, usdCost
    FROM contains NATURAL JOIN room_types
    WHERE r_number = roomID;

    -- determine price
    SELECT rate_usd INTO usdMultiplier
    FROM uses INNER JOIN rates USING(rate_usd)
    WHERE res_id = resID;

    usdCost := usdCost*usdMultiplier*resDuration;

    RETURN usdCost;

END;