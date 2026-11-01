SET SERVEROUTPUT ON;

-- Test 1: GPA Calculation
DECLARE
    v_gpa NUMBER;
BEGIN
    v_gpa := get_student_gpa(101);
    DBMS_OUTPUT.PUT_LINE('Alice GPA: ' || v_gpa);
END;
/

-- Test 2: Explicit Cursor Listing
BEGIN
    list_students_by_course(10);
END;
/

-- Test 3: Bulk Enrollment Success
BEGIN
    enroll_students_bulk(p_course_id => 12, p_limit => 3);
END;
/
