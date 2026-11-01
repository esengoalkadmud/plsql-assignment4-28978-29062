# PL/SQL Assignment IV: Student Registration & Grading

## Group Members
- **MUDAHINYUKA ESENGO Alkad** (ID: 28978)
- **ISHIMWE Gad** (ID: 29062)

## Application Description
This project is a **Student Registration and Grading System** built with Oracle PL/SQL. It manages students, courses, and their enrollments. It demonstrates advanced PL/SQL concepts including Records (`%ROWTYPE` and User-Defined), Collections (Nested Tables), Implicit and Explicit Cursors, and High-Performance Bulk Processing (`BULK COLLECT` and `FORALL`).

## How to Run
1. Connect to your Oracle PDB as `sys as sysdba`.
2. Run the schema setup: `@00_schema/01_create_tables.sql`
3. Insert sample data: `@00_schema/02_insert_sample_data.sql`
4. Compile the procedures: `@01_procedures/register_student.sql`, `@01_procedures/list_students_by_course.sql`, `@01_procedures/enroll_students_bulk.sql`
5. Compile the function: `@02_functions/get_student_gpa.sql`
6. Run the test files in the `03_tests/` folder to see success and error scenarios.

## Integrity Statement
We declare that this submission is our own work. We understand all the code submitted and can explain it during the presentation.

**AI Usage Disclosure:** An AI assistant was used to help format the initial database schema structure and draft the README/Implementation notes. All PL/SQL code was executed, tested, and verified by both group members.

## Submission Details
- **Repository Link:** (https://github.com/esengoalkadmud/plsql-assignment4-28978-29062)
- **PDB Name Created:** AL_PDB_28978
- **Issues Encountered:** Yes (We encountered unique constraint errors during bulk testing, which we solved using `SAVE EXCEPTIONS` and `SQL%BULK_EXCEPTIONS`).
