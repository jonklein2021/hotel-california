DECLARE
    founded TIMESTAMP := TO_TIMESTAMP('12081973', 'MMDDYYYY');
    res_id_i VARCHAR(5);
    in_time_i TIMESTAMP;
    out_time_i TIMESTAMP;
    usd_i INTEGER;
    points_i INTEGER;
    cancel_fee INTEGER;
    rand INTEGER;
BEGIN
    FOR i in 1..80
    LOOP
        res_id_i := lpad(i, 5, '0');
    
        rand := round(DBMS_RANDOM.VALUE(1, 60));
        in_time_i := (founded - rand);
        
        rand := round(DBMS_RANDOM.VALUE(1, 14));
        out_time_i := (in_time_i + rand);
        
        rand := round(DBMS_RANDOM.VALUE(0, 50));
        usd_i := (70*EXTRACT(DAY FROM (out_time_i - in_time_i)) + rand);
        points_i := usd_i*100;
        
        rand := round(DBMS_RANDOM.VALUE(3, 6));
        cancel_fee := rand*10;
        
--        dbms_output.put_line('INSERT INTO reservations (res_id_i, in_time_i, out_time_i, usd_i, points_i, cancellation_fee) VALUES (''' || res_id_i || ''', ''' || in_time_i || ''', ''' || out_time_i || ''', ''' || usd_i || ''', ''' || points_i || ''', ''' || cancel_fee || ''')');
        INSERT INTO reservations (res_id, in_time, out_time, usd, points, cancellation_fee) VALUES (res_id_i, in_time_i, out_time_i, usd_i, points_i, 0);
        
    END LOOP;
END;