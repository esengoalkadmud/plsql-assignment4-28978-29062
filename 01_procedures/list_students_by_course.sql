CREATE OR REPLACE PROCEDURE list_students_by_course (
    p_course_id IN NUMBER
) 
IS
    TYPE student_rec_type IS RECORD (
        s_id    students.student_id%TYPE,
        s_name  VARCHAR2(101),
        s_grade enrollments.grade%TYPE
    );

    TYPE student_list_type IS TABLE OF student_rec_type INDEX BY PLS_INTEGER;
    v_students student_list_type;

    CURSOR c_students IS
        SELECT s.student_id, s.first_name || ' ' || s.last_name, e.grade
        FROM students s
        JOIN enrollments e ON s.student_id = e.student_id
        WHERE e.course_id = p_course_id;
        
    v_idx PLS_INTEGER := 0;
    v_course_name courses.course_name%TYPE;
BEGIN
    BEGIN
        SELECT course_name INTO v_course_name FROM courses WHERE course_id = p_course_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20005, 'Course ID ' || p_course_id || ' not found.');
    END;

    OPEN c_students;
    LOOP
        v_idx := v_idx + 1;
        FETCH c_students INTO v_students(v_idx).s_id, v_students(v_idx).s_name, v_students(v_idx).s_grade;
        EXIT WHEN c_students%NOTFOUND;
    END LOOP;
    
    IF v_idx = 1 AND v_students(1).s_id IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('No students enrolled in ' || v_course_name);
    ELSE
        DBMS_OUTPUT.PUT_LINE('--- Students enrolled in ' || v_course_name || ' ---');
        FOR i IN 1 .. v_idx - 1 LOOP
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_students(i).s_id || ' | Name: ' || v_students(i).s_name || ' | Grade: ' || NVL(TO_CHAR(v_students(i).s_grade), 'Not Graded'));
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Total Students: ' || (v_idx - 1));
    END IF;

    CLOSE c_students;
EXCEPTION
    WHEN OTHERS THEN
        IF c_students%ISOPEN THEN
            CLOSE c_students;
        END IF;
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/
