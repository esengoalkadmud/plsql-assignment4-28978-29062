CREATE OR REPLACE FUNCTION get_student_gpa (
    p_student_id IN NUMBER
) RETURN NUMBER 
IS
    v_total_points NUMBER := 0;
    v_total_credits NUMBER := 0;
    v_gpa NUMBER := 0;
    v_student_name VARCHAR2(100);
BEGIN
    BEGIN
        SELECT first_name || ' ' || last_name INTO v_student_name
        FROM students WHERE student_id = p_student_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'Student ID ' || p_student_id || ' does not exist.');
    END;

    SELECT NVL(SUM(
               CASE 
                   WHEN e.grade >= 90 THEN 4.0
                   WHEN e.grade >= 80 THEN 3.0
                   WHEN e.grade >= 70 THEN 2.0
                   WHEN e.grade >= 60 THEN 1.0
                   ELSE 0.0
               END * c.credits
           ), 0), 
           NVL(SUM(c.credits), 0)
    INTO v_total_points, v_total_credits
    FROM enrollments e
    JOIN courses c ON e.course_id = c.course_id
    WHERE e.student_id = p_student_id AND e.grade IS NOT NULL;

    IF v_total_credits > 0 THEN
        v_gpa := v_total_points / v_total_credits;
    ELSE
        v_gpa := 0;
    END IF;

    RETURN ROUND(v_gpa, 2);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error calculating GPA: ' || SQLERRM);
        RETURN NULL;
END;
/
