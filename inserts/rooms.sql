BEGIN
    FOR i in 1..12
    LOOP
        FOR j in 100..199
        LOOP
            INSERT INTO rooms (r_number, is_vacant, is_clean) VALUES (lpad(i*1000+j, 5, '0'), 1, 1);
        END LOOP;
    END LOOP;
END;