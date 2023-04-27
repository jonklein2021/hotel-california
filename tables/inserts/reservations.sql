-- note: reservation is inserted AT OUT TIME because of misc transactions during guests' stays

DECLARE
    founded TIMESTAMP := TO_TIMESTAMP('12-08-1973 16:00', 'MM-DD-YYYY HH24:MI');
    res_id_i VARCHAR(5);
    in_time_i TIMESTAMP;
    out_time_i TIMESTAMP;
    usd_i INTEGER;
    points_i INTEGER;
    cancel_fee INTEGER;
    
    room_rate INTEGER;
    rate_multiplier NUMERIC(1, 2);
    
    rand INTEGER;
BEGIN
    FOR i in 1..80
    LOOP   
        
        -- Determine cost of room type
        rand := round(DBMS_RANDOM.VALUE(1, 10));
        IF rand <= 2 THEN
            -- Single
            room_rate := 70;
         ELSIF rand <= 6 THEN
             -- Deluxe
            room_rate := 100;
        ELSIF rand <= 9 THEN
            -- Suite
            room_rate := 135;
        ELSE
            -- Presidential Suite
            room_rate := 160;
        END IF;
    
    
        -- generate reservation columns
        res_id_i := lpad(i, 5, '0');
    
        rand := round(DBMS_RANDOM.VALUE(1, 60));
        in_time_i := (founded + 7 - rand);
        
        rand := round(DBMS_RANDOM.VALUE(1, 14));
        out_time_i := (in_time_i + rand);
        
        rand := round(DBMS_RANDOM.VALUE(1, 5));
        IF rand < 5 THEN
            -- stay was paid with usd
            -- need to determine which rate is used
            usd_i := rate_multiplier*room_rate*EXTRACT(DAY FROM (out_time_i - in_time_i));
            points_i := 0;        
        ELSE
            -- stay was paid with points
            -- need to determine which rate is used
            points_i := 100*rate_multiplier*room_rate*EXTRACT(DAY FROM (out_time_i - in_time_i)) + rand;
            usd_i := 0;
        END IF;
        
        rand := round(DBMS_RANDOM.VALUE(3, 6));
        cancel_fee := rand*10;
        
        /* aggregation of transactions for ith reservation */
        INSERT INTO reservations (res_id, in_time, out_time, usd, points, cancellation_fee) VALUES (res_id_i, in_time_i, out_time_i, usd_i, points_i, 0);
        
    END LOOP;
END;