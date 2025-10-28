-- Project name: Global Student Wellbeing Analysis

--Creating a database
CREATE Database GlobStuWA

--Load Database
USE GlobStuWA

--importing the required dataset(student life.csv)
SELECT * FROM student_life


-- ---------------------------------------------------------------------------------------
-- 1. Overall Average Stress: Find the average stress level across all surveyed students.
-- ---------------------------------------------------------------------------------------
SELECT
    AVG(stress_level) AS overall_average_stress
FROM
    student_life



-- ---------------------------------------------------------------------------------------
-- 2. AI Usage vs. Stress: Calculate the average stress level for students who use AI for study versus those who do not.
-- ---------------------------------------------------------------------------------------
SELECT
    CASE WHEN uses_AI_for_study = 1 THEN 'Yes' ELSE 'No' END AS Used_AI_for_study,
    AVG(stress_level) AS avg_stress

FROM student_life
GROUP BY CASE WHEN uses_AI_for_study = 1 THEN 'Yes' ELSE 'No' END


-- ---------------------------------------------------------------------------------------
-- 3. Sleep Categories & Stress: Analyze the average stress level for three sleep groups.
--    Low (<= 5 hrs), Moderate (> 5 to <= 7 hrs), and High (> 7 hrs).
-- ---------------------------------------------------------------------------------------
SELECT
    CASE
        WHEN avg_sleep_hours <= 5 THEN 'Low Sleep (<= 5 hrs)'
        WHEN avg_sleep_hours > 7 THEN 'High Sleep (> 7 hrs)'
        ELSE 'Moderate Sleep (5 to 7 hrs)'
    END AS sleep_category,
    AVG(stress_level) AS avg_stress_by_sleep

FROM student_life 
GROUP BY CASE
        WHEN avg_sleep_hours <= 5 THEN 'Low Sleep (<= 5 hrs)'
        WHEN avg_sleep_hours > 7 THEN 'High Sleep (> 7 hrs)'
        ELSE 'Moderate Sleep (5 to 7 hrs)'
    END
ORDER BY avg_stress_by_sleep DESC


-- ---------------------------------------------------------------------------------------
-- 4. Highest Stress Countries: Identify the top 3 countries with the highest average stress level.
-- ---------------------------------------------------------------------------------------
SELECT TOP 3
    country,
    AVG(stress_level) AS avg_stress

FROM student_life
GROUP BY
    country
ORDER BY
    avg_stress DESC

-- ---------------------------------------------------------------------------------------
-- 5. Screen Time Correlate: Determine the average daily screen time for students in the 'Falling Behind' exam prep status.
-- ---------------------------------------------------------------------------------------
SELECT
    AVG(daily_screen_time) AS avg_screen_time_falling_behind

FROM student_life
WHERE
    board_exam_prep = 'Falling Behind'


-- ---------------------------------------------------------------------------------------
-- 6. High-Risk Students: Count the number of students who are 'Falling Behind' AND report a high stress level (e.g., > 7).
-- ---------------------------------------------------------------------------------------
SELECT
    COUNT(id) AS high_risk_student_count

FROM student_life
WHERE
    board_exam_prep = 'Falling Behind' AND stress_level > 7


-- ---------------------------------------------------------------------------------------
-- 7. Gender & Screen Time: Calculate the average daily screen time for each gender.
-- ---------------------------------------------------------------------------------------
SELECT
    gender,
    AVG(daily_screen_time) AS avg_screen_time

FROM student_life
GROUP BY
    gender


-- ---------------------------------------------------------------------------------------
-- 8. Prep Status Distribution: Find the count and percentage of students for each board exam preparation status.
-- ---------------------------------------------------------------------------------------
SELECT
    board_exam_prep,
    COUNT(id) AS student_count,
    (COUNT(id) * 100.0 / (SELECT COUNT(id) FROM student_life)) AS percent_of_total

FROM student_life
GROUP BY
    board_exam_prep
ORDER BY
    student_count DESC


-- ---------------------------------------------------------------------------------------
-- 9. Stress & Screen Time Interaction: Find the average stress level for students with High Screen Time (>= 6 hrs) and Low Sleep (<= 5 hrs).
-- ---------------------------------------------------------------------------------------
SELECT
    AVG(stress_level) AS avg_stress_high_screen_low_sleep

FROM student_life
WHERE
    daily_screen_time >= 6 AND avg_sleep_hours <= 5



-- ---------------------------------------------------------------------------------------
-- 10. Student Demographics: Count the number of students in each grade (11 and 12).
-- ---------------------------------------------------------------------------------------
SELECT
    grade,
    COUNT(id) AS student_count

FROM student_life
GROUP BY
    grade
ORDER BY
    grade


-----------------------------------------------------END OF QUARY-----------------------------------------------------------------------