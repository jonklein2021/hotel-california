DECLARE
    rand1 INTEGER;
    rand2 INTEGER;
BEGIN
    FOR i in 1..12
    LOOP
        FOR j in 100..199
        LOOP        
            rand1 := round(DBMS_RANDOM.VALUE(0, 1));
            rand2 := round(DBMS_RANDOM.VALUE(0, 1));
            INSERT INTO rooms (r_number, is_vacant, is_clean) VALUES (lpad(i*1000+j, 5, '0'), rand1, rand2);
        END LOOP;
    END LOOP;
END;