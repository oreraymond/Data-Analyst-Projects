# Have A broad view of the salries table
SELECT 
    *
FROM
    salaries;
    
    
# To Have a broad View of the employees table
    SELECT 
    *
FROM
    employees;
    
    
# Find the average salary of the male and female employees in each department and round to 2 decimal places.
 SELECT 
    ROUND(AVG(salary), 2), gender
FROM
    salaries s
        JOIN
    employees e ON s.emp_no = e.emp_no
GROUP BY gender;


# To Find the lowest department number encountered in the 'dept_emp' table. 
  SELECT 
    min(dept_no)
FROM
    dept_emp;

# Then, finding the highest department number.
 SELECT 
    max(dept_no)
FROM
    dept_emp;
    

# To Obtain a table containing the following three fields for all individuals whose employee number is not greater than 10040: - employee number - the lowest department number among the departments where the employee has worked in - assigning '110022' as 'manager' to all individuals whose employee number is lower than or equal to 10020, and '110039' to those whose number is between 10021 and 10040 inclusive. Using a CASE statement to create the third field.


    SELECT 
    emp_no,
    (SELECT 
            MIN(dept_no)
        FROM
            dept_emp de
        WHERE
            e.emp_no = de.emp_no) dept_no,
    CASE
        WHEN emp_no <= 10020 THEN '110022'
        ELSE '110039'
    END AS manager
FROM
    employees e
WHERE
    emp_no <= 10040;
    

# Retrieve a list of all employees that have been hired in 2000.
SELECT 
    *
FROM
    employees
WHERE
    hire_date = 2000;
    
# Retrieve a list of all employees from the ‘titles’ table who are engineers.
SELECT 
    *
FROM
    titles
WHERE
    title LIKE '%Engineer%';

# Retrieve a list of all employees from the ‘titles’ table who are senior engineers.
SELECT 
    *
FROM
    titles
WHERE
    title LIKE '%Senior Engineer%';
    

# Create a procedure that asks you to insert an employee number and that will obtain an output containing the same number, as well as the number  and name of the last department the employee has worked in.


DELIMITER $$
CREATE PROCEDURE last_dept (in p_emp_no integer)
BEGIN

SELECT e.emp_no, d.dept_no, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no 
JOIN departments d ON de.dept_no = d.dept_no
WHERE e.emp_no = p_emp_no
AND de.from_date =
(
SELECT MAX(from_date) 
FROM dept_emp
WHERE emp_no = p_emp_no) ;

END $$
DELIMITER ;  

# call the procedure for employee number 10010.
call employees.last_dept(10010);

# How many contracts have been registered in the ‘salaries’ table with duration of more than one year and of value higher than or equal to $100,000?

SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 100000
        AND DATEDIFF(to_date, from_date) > 365;



