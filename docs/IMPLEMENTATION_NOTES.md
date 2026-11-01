# Implementation & Performance Notes

## 1. Bulk Processing Performance
In this application, we used `BULK COLLECT` and `FORALL` in the `enroll_students_bulk` procedure. 
- **Row-by-Row vs Bulk:** Traditional row-by-row processing (using a standard `LOOP` and `INSERT`) requires a context switch between the PL/SQL engine and the SQL engine for *every single row*. 
- **Bulk Processing:** Using `BULK COLLECT` fetches multiple rows into memory at once, and `FORALL` sends a batch of DML operations to the SQL engine in one call. This drastically reduces context switching and improves performance, especially with large datasets.
- **Error Handling:** We used the `SAVE EXCEPTIONS` clause with `FORALL`. Without it, if one insert failed (e.g., a unique constraint violation), the entire batch would roll back. With `SAVE EXCEPTIONS`, we can capture the errors using `SQL%BULK_EXCEPTIONS` and handle them gracefully while allowing the successful rows to be processed.

## 2. Cursors Used
- **Implicit Cursors:** Used in the `register_student` procedure to check `SQL%ROWCOUNT` after an INSERT.
- **Explicit Cursors:** Used in `list_students_by_course` to fetch multiple records one by one and store them in a Nested Table collection of user-defined records. 

## 3. Exception Handling Strategy
- **Predefined Exceptions:** `NO_DATA_FOUND` is used when searching for a student or course that does not exist.
- **User-Defined Exceptions & RAISE_APPLICATION_ERROR:** We used custom error codes (e.g., `-20004` for a full course) to provide meaningful error messages to the user instead of raw Oracle errors.
- **Bulk Exceptions:** `PRAGMA EXCEPTION_INIT(bulk_errors, -24381)` was used to catch bulk DML errors during `FORALL`.
