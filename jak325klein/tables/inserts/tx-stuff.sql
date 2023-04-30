-- inserts into: reservations, transacitons, represents, reserves, res_type, spends, uses
-- note: reservation is inserted AT OUT TIME because of misc transactions during guests' stays
SET SERVEROUTPUT ON;

DECLARE
    founded TIMESTAMP := TO_TIMESTAMP('12-08-1973 16:00', 'MM-DD-YYYY HH24:MI');
    res_id_i VARCHAR(5);
    in_time_i TIMESTAMP;
    out_time_i TIMESTAMP;
    usd_i INTEGER;
    points_i INTEGER;
    cancel_fee INTEGER;
    
    room_rate INTEGER; -- rate per night
    in_month INTEGER;
    
    usd_multiplier NUMERIC(3, 2);
    points_multiplier NUMERIC(3, 2);
    
    usd_total NUMERIC(7, 2);
    points_total NUMERIC(9, 0);
    
    t_i NUMBER := 1; -- transaction index
    t TIMESTAMP; -- transaction time
    u NUMBER; -- transaction usd
    p NUMBER; -- transaction points
    
    g_id_i VARCHAR(5);
    
    rand INTEGER;
BEGIN
    FOR i in 1..80
    LOOP
        usd_total := 0;
        points_total := 0;
        
        -- guest id
        g_id_i := lpad(101-i, 5, '0');
        
        -- generate reservation id
        res_id_i := lpad(i, 5, '0');
        
        -- Determine cost of room type
        rand := round(DBMS_RANDOM.VALUE(1, 10));
        IF rand <= 2 THEN
            -- Single
            room_rate := 70;
            INSERT INTO res_type (res_id, r_type) VALUES (res_id_i, 'Single');
         ELSIF rand <= 6 THEN
             -- Deluxe
            room_rate := 100;
            INSERT INTO res_type (res_id, r_type) VALUES (res_id_i, 'Deluxe');
        ELSIF rand <= 9 THEN
            -- Suite
            room_rate := 135;
            INSERT INTO res_type (res_id, r_type) VALUES (res_id_i, 'Suite');
        ELSE
            -- Presidential Suite
            INSERT INTO res_type (res_id, r_type) VALUES (res_id_i, 'Presidential Suite');
            room_rate := 160;
        END IF;
    
        rand := round(DBMS_RANDOM.VALUE(1, 365));
        in_time_i := (founded + 7 - rand);
        
        rand := round(DBMS_RANDOM.VALUE(1, 14));
        out_time_i := (in_time_i + rand);
        
        -- determine rate multiplier based on month of in_time
        in_month := EXTRACT(MONTH FROM in_time_i);        
        IF (in_month >= 3 AND in_month <= 5) THEN
            usd_multiplier := 1;
            points_multiplier := 1;
            INSERT INTO uses (res_id, rate_usd) VALUES (res_id_i, 1);
        ELSIF (in_month >= 6 AND in_month <= 8) THEN
            usd_multiplier := 1.5;
            points_multiplier := 1.4;
            INSERT INTO uses (res_id, rate_usd) VALUES (res_id_i, 1.5);
        ELSIF ((in_month >= 10 AND in_month <= 12) OR (in_month >= 1 AND in_month <= 2)) THEN
            usd_multiplier := 0.8;
            points_multiplier := 0.75;
            INSERT INTO uses (res_id, rate_usd) VALUES (res_id_i, 0.8);
        ELSE
            usd_multiplier := 1.25;
            points_multiplier := 1.2;
            INSERT INTO uses (res_id, rate_usd) VALUES (res_id_i, 1.25);
        END IF;
        
        rand := round(DBMS_RANDOM.VALUE(1, 5));
        IF rand < 5 THEN
            -- stay was paid with usd
            usd_i := usd_multiplier*room_rate*EXTRACT(DAY FROM (out_time_i - in_time_i));
            points_i := 0;        
        ELSE
            -- stay was paid with points
            points_i := 100*points_multiplier*room_rate*EXTRACT(DAY FROM (out_time_i - in_time_i));
            usd_i := 0;
        END IF;
        
        cancel_fee := 50;
        
        -- add room transaction to table
        INSERT INTO transactions (t_id, t_time, usd, points) VALUES (lpad(t_i, 5, '0'), out_time_i, usd_i, points_i);
        INSERT INTO represents (res_id, t_id) VALUES (res_id_i, lpad(t_i, 5, '0'));
        INSERT INTO spends (g_id, t_id) VALUES (g_id_i, lpad(t_i, 5, '0'));
        t_i := t_i + 1;
        
        -- add room fees to reservaton total
        usd_total := usd_total + usd_i;
        points_total := points_total + points_i;
        
        -- account for other transactions
        rand := round(DBMS_RANDOM.VALUE(0, 5));
        FOR j IN 1..rand
        LOOP
            t := in_time_i + (DBMS_RANDOM.VALUE(0, EXTRACT (DAY FROM (out_time_i - in_time_i)))); -- random timestamp during the guest's stay
            rand := round(DBMS_RANDOM.VALUE(1, 10));
            p := 0;
            u := DBMS_RANDOM.VALUE(1, 5)*10;
            IF rand >= 8 THEN
                p := u*100;
                u := 0;
            END IF;
            INSERT INTO transactions (t_id, t_time, usd, points) VALUES (lpad(t_i, 5, '0'), t, u, p);
            INSERT INTO represents (res_id, t_id) VALUES (res_id_i, lpad(t_i, 5, '0'));
            INSERT INTO spends (g_id, t_id) VALUES (g_id_i, lpad(t_i, 5, '0'));
            t_i := t_i + 1;
            
            -- add misc fees to reservaton total
            usd_total := usd_total + u;
            points_total := points_total + p;
        END LOOP;
        
        /* aggregation of transactions for ith reservation */
        INSERT INTO reservations (res_id, in_time, out_time, usd, points, cancellation_fee) VALUES (res_id_i, in_time_i, out_time_i, usd_total, points_total, cancel_fee);
        INSERT INTO reserves (g_id, res_id) VALUES (g_id_i, res_id_i);
        
    END LOOP;
END;