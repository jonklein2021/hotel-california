CREATE OR REPLACE FUNCTION handleWalkin (
    gID IN VARCHAR,
    inTime IN TIMESTAMP,
    outTime IN TIMESTAMP,
    roomType IN VARCHAR,
    hID IN VARCHAR) RETURN VARCHAR AS
    roomNumber VARCHAR(5);
    resID VARCHAR(5);
BEGIN
    -- create reservation
    resID := handleReservation(gID, inTime, outTime, roomType, hID);

    -- check guest in
    roomNumber := handleCheckin(gID, resID, hID);
    
    -- return the room given
    RETURN roomNumber;
END;