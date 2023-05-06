CREATE OR REPLACE FUNCTION determinePricePoints (
    resID IN VARCHAR,
    resDuration IN INTEGER) RETURN INTEGER AS
    roomID VARCHAR(5);
    roomType VARCHAR(20);
    pointsMultiplier NUMERIC(3, 2);
    pointsCost NUMERIC(7, 0);
BEGIN
     -- get room number
    SELECT r_number INTO roomID
    FROM reservations WHERE res_id = resID;

    -- get room type
    SELECT r_type, price_usd INTO roomType, pointsCost
    FROM contains NATURAL JOIN room_types
    WHERE r_number = roomID;

    -- determine price
    SELECT rate_points INTO pointsMultiplier
    FROM uses INNER JOIN rates USING(rate_usd)
    WHERE res_id = resID;

    pointsCost := 100*pointsCost*pointsMultiplier*resDuration;

    RETURN pointsCost;

END;