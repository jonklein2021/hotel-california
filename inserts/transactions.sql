DECLARE
    CURSOR c is SELECT out_time, usd FROM reservations;
    n NUMBER(4, 2);
    rand NUMBER;
    i INTEGER := 50001;
    t TIMESTAMP;
    u NUMBER;
    p NUMBER;
BEGIN
    OPEN c;
    FETCH c INTO t, u;

    WHILE c%found
    LOOP
        FETCH c INTO t, u;
        p := 0;
        
        rand := round(DBMS_RANDOM.VALUE(1, 10));
        IF rand > 7 THEN
            p := u*100;
            u := 0;
        END IF;
        
        INSERT INTO transactions (t_id, t_time, usd, points) VALUES (lpad(i, 5, '0'), t, u, p);
        i := i + 1;
        
        rand := round(DBMS_RANDOM.VALUE(1, 10));
        IF rand > 5 THEN
            t := t - round(DBMS_RANDOM.VALUE(1, 5));
            rand := round(DBMS_RANDOM.VALUE(1, 10));
            u := DBMS_RANDOM.VALUE(1, 5)*10;
            IF rand > 8 THEN
                p := u*100;
                u := 0;
            END IF;
            INSERT INTO transactions (t_id, t_time, usd, points) VALUES (lpad(i, 5, '0'), t, u, p);
            i := i + 1;
        END IF;
    END LOOP;
END;