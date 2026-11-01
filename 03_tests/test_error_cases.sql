SET SERVEROUTPUT ON;

-- Test 1: Register for Full Course (ORA-20004)
BEGIN
    register_student(103, 13);
END;
/

-- Test 2: Invalid Student ID (ORA-20002)
BEGIN
    register_student(999, 10);
END;
/

-- Test 3: Bulk Save Exceptions (Error handling)
DECLARE
    TYPE id_table_type IS TABLE OF students.student_id%TYPE;
    v_student_ids id_table_type := id_table_type(101, 102, 103); 
    bulk_errors EXCEPTION;
    PRAGMA EXCEPTION_INIT(bulk_errors, -24381);
BEGIN
    FORALL i IN 1 .. v_student_ids.COUNT SAVE EXCEPTIONS
        INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date)
        VALUES (seq_enrollment_id.NEXTVAL, v_student_ids(i), 13, SYSDATE);
EXCEPTION
    WHEN bulk_errors THEN
        DBMS_OUTPUT.PUT_LINE('WARNING: Some enrollments failed!');
        FOR i IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(' - Error at index ' || SQL%BULK_EXCEPTIONS(i).ERROR_INDEX);
        END LOOP;
END;
/
