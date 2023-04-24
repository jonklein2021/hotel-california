BEGIN
    FOR i in 101..200
    LOOP
        INSERT INTO rooms (r_number, is_vacant, is_clean) VALUES (i, 1, 1);
    END LOOP;
END;