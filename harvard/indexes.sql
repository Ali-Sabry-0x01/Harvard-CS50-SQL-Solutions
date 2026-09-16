CREATE INDEX "idx_enrollments_student_id" ON "enrollments"("student_id");
CREATE INDEX "idx_enrollments_course_id" ON "enrollments"("course_id");
CREATE INDEX "idx_satisfies_course_id" ON "satisfies"("course_id");
CREATE INDEX "idx_courses_semester_title" ON "courses"("semester", "title");
CREATE INDEX "idx_courses_semester_dept_num" ON "courses"("semester", "department", "number");
