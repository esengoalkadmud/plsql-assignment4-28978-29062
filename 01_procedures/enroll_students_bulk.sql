CREATE OR REPLACE PROCEDURE enroll_students_bulk (
    p_course_id IN NUMBER,
    p_limit     IN NUMBER DEFAULT 3
) 
IS
    TYPE id_table_type IS TABLE OF students.student_id%TYPE;
    v_student_ids id_table_type;
    bulk_errors EXCEPTION;
    PRAGMA EXCEPTION_INIT(bulk_errors, -24381); 
BEGIN
    SELECT student_id 
    BULK COLLECT INTO v_student_ids
    FROM students 
    WHERE student_id NOT IN (SELECT student_id FROM enrollments WHERE course_id = p_course_id)
    FETCH FIRST p_limit ROWS ONLY; 

    IF v_student_ids.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No new students to enroll.');
        RETURN;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Attempting to bulk enroll ' || v_student_ids.COUNT || ' students...');

    BEGIN
        FORALL i IN 1 .. v_student_ids.COUNT SAVE EXCEPTIONS
            INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date)
            VALUES (seq_enrollment_id.NEXTVAL, v_student_ids(i), p_course_id, SYSDATE);
            
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Bulk enrollment completed.');
        
    EXCEPTION
        WHEN bulk_errors THEN
            DBMS_OUTPUT.PUT_LINE('WARNING: Some enrollments failed!');
            FOR i IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
                DBMS_OUTPUT.PUT_LINE(' - Error at index ' || SQL%BULK_EXCEPTIONS(i).ERROR_INDEX || 
                                     ' with code ' || SQL%BULK_EXCEPTIONS(i).ERROR_CODE);
            END LOOP;
    END;

    COMMIT;
END;
/
