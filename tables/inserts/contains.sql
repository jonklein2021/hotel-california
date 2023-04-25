/*
Single: 20%
Deluxe: 40%
Suite: 30%
Presidential Suite: 10%
*/

SET SERVEROUTPUT ON;

DECLARE
    rand INTEGER;
    room_size INTEGER;
    suite_size INTEGER;
    room_type VARCHAR(20);
BEGIN
    FOR i in 1..12
    LOOP
        rand := round(DBMS_RANDOM.VALUE(0, 2));
        IF rand <= 1 THEN
            suite_size := 4;
        ELSE
            suite_size := 3;
        END IF;
        
        FOR j in 100..199
        LOOP
        
            rand := round(DBMS_RANDOM.VALUE(1, 10));
            
            IF rand <= 2 THEN
                -- Single
                room_type := 'Single';
                room_size := 1;
            ELSIF rand <= 6 THEN
                -- Double
                room_type := 'Deluxe';
                room_size := 2;
            ELSIF rand <= 9 THEN
                -- Suite
                room_type := 'Suite';
                room_size := suite_size;
            ELSE
                -- Presidential Suite
                room_type := 'Presidential Suite';
                room_size := 6;
            END IF;
        
            INSERT INTO contains (h_id, r_number, r_type, r_capacity) VALUES (lpad(i, 3, '0'), lpad(i*1000+j, 5, '0'), room_type, room_size);
        END LOOP;
    END LOOP;
END;