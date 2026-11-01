INSERT INTO students VALUES (101, 'Alice', 'Mukamana', 'alice.m@example.com', 2023);
INSERT INTO students VALUES (102, 'Bob', 'Nkurunziza', 'bob.n@example.com', 2022);
INSERT INTO students VALUES (103, 'Charlie', 'Habimana', 'charlie.h@example.com', 2024);
INSERT INTO students VALUES (104, 'Diana', 'Uwase', 'diana.u@example.com', 2023);
INSERT INTO students VALUES (105, 'Ethan', 'Kagabo', 'ethan.k@example.com', 2025);

INSERT INTO courses VALUES (10, 'Database Development with PL/SQL', 4, 30);
INSERT INTO courses VALUES (11, 'Java Programming', 3, 40);
INSERT INTO courses VALUES (12, 'Web Application Design', 4, 35);
INSERT INTO courses VALUES (13, 'Advanced Networking', 3, 2);

INSERT INTO enrollments (enrollment_id, student_id, course_id, grade) VALUES (seq_enrollment_id.NEXTVAL, 101, 10, 85);
INSERT INTO enrollments (enrollment_id, student_id, course_id, grade) VALUES (seq_enrollment_id.NEXTVAL, 101, 11, 92);
INSERT INTO enrollments (enrollment_id, student_id, course_id, grade) VALUES (seq_enrollment_id.NEXTVAL, 102, 10, 78);
INSERT INTO enrollments (enrollment_id, student_id, course_id, grade) VALUES (seq_enrollment_id.NEXTVAL, 103, 12, 88);
INSERT INTO enrollments (enrollment_id, student_id, course_id, grade) VALUES (seq_enrollment_id.NEXTVAL, 103, 10, 91);
INSERT INTO enrollments (enrollment_id, student_id, course_id, grade) VALUES (seq_enrollment_id.NEXTVAL, 104, 11, NULL); 

COMMIT;
