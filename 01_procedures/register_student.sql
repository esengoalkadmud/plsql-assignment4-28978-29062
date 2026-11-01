CREATE OR REPLACE PROCEDURE register_student (
    p_student_id IN NUMBER,
    p_course_id  IN NUMBER
) 
IS
    v_student_rec students%ROWTYPE;
    v_course_rec  courses%ROWTYPE;
    v_current_seats NUMBER;
BEGIN
    BEGIN
        SELECT * INTO v_student_rec FROM students WHERE student_id = p_student_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'Student ID ' || p_student_id || ' not found.');
    END;

    BEGIN
        SELECT * INTO v_course_rec FROM courses WHERE course_id = p_course_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20003, 'Course ID ' || p_course_id || ' not found.');
    END;

    SELECT COUNT(*) INTO v_current_seats FROM enrollments WHERE course_id = p_course_id;
    IF v_current_seats >= v_course_rec.max_seats THEN
        RAISE_APPLICATION_ERROR(-20004, 'Registration failed: ' || v_course_rec.course_name || ' is FULL.');
    END IF;

    INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date)
    VALUES (seq_enrollment_id.NEXTVAL, p_student_id, p_course_id, SYSDATE);

    IF SQL%ROWCOUNT = 1 THEN
        DBMS_OUTPUT.PUT_LINE('SUCCESS: ' || v_student_rec.first_name || ' ' || v_student_rec.last_name || ' registered for ' || v_course_rec.course_name);
    ELSE
        DBMS_OUTPUT.PUT_LINE('WARNING: Registration did not complete.');
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
        ROLLBACK;
END;
/
