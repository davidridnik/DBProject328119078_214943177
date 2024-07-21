--מבט ושאילתות על הבסיס נתונים הישן
--המבט
CREATE OR REPLACE VIEW detailed_production_overview AS
SELECT 
    m.Machine_ID,
    m.Machine_Name,
    m.Status AS Machine_Status,
    po.Production_Order_ID,
    po.Quantity,
    po.Start_Date,
    po.Due_Date,
    po.Status AS Order_Status,
    po.Tool_ID,
    SYSDATE AS Current_Date,
    po.Due_Date - SYSDATE AS Days_Left
FROM 
    Machines m
LEFT JOIN 
    Production_Orders po ON m.Machine_ID = po.Tool_ID;

--שאילתא 1
SELECT
    Machine_ID,
    Machine_Name,
    Machine_Status,
    COUNT(Production_Order_ID) AS Total_Orders,
    SUM(Quantity) AS Total_Quantity,
    MIN(Days_Left) AS Min_Days_Left,
    MAX(Days_Left) AS Max_Days_Left,
    AVG(Days_Left) AS Avg_Days_Left
FROM
    detailed_production_overview
WHERE
    Days_Left IS NOT NULL
GROUP BY
    Machine_ID,
    Machine_Name,
    Machine_Status
HAVING
    SUM(Quantity) > 100  -- רק מכונות עם כמות הזמנות גבוהה
ORDER BY
    Avg_Days_Left;

-- שאילתא 2
SELECT 
    TO_CHAR(Due_Date, 'YYYY-MM') AS Month,
    COUNT(Production_Order_ID) AS Upcoming_Orders,
    SUM(Quantity) AS Total_Quantity,
    COUNT(DISTINCT Machine_ID) AS Machines_Involved,
    ROUND(SUM(Quantity) / COUNT(DISTINCT Machine_ID), 2) AS Avg_Quantity_Per_Machine
FROM 
    detailed_production_overview
WHERE 
    Due_Date > SYSDATE AND Order_Status != 'Completed'
GROUP BY 
    TO_CHAR(Due_Date, 'YYYY-MM')
ORDER BY 
    Month;


--מבט ושאילתות על הבסיס נתונים שקבלנו
--המבט
CREATE OR REPLACE VIEW department_projects_overview AS
SELECT 
    d.department_id,
    d.department_name,
    p.project_id,
    p.project_name,
    e.engineer_id,
    e.first_name AS engineer_first_name,
    e.last_name AS engineer_last_name,
    e.specialty,
    s.officer_id,
    s.first_name AS safety_officer_first_name,
    s.last_name AS safety_officer_last_name,
    s.certification
FROM 
    Departments d
LEFT JOIN 
    Projects p ON d.department_id IN (SELECT department_id FROM ProjectManagers WHERE project_id = p.project_id)
LEFT JOIN 
    Engineers e ON e.project_id = p.project_id
LEFT JOIN 
    SafetyOfficers s ON d.department_id = s.department_id;

--שאילתא 1
SELECT 
    department_name,
    project_name,
    engineer_first_name,
    engineer_last_name,
    specialty
FROM 
    department_projects_overview
WHERE 
    specialty IS NOT NULL
ORDER BY 
    department_name, project_name;

--שאילתא 2
WITH ProjectEngineerCounts AS (
    SELECT 
        project_id,
        project_name,
        COUNT(DISTINCT engineer_id) AS num_engineers
    FROM 
        department_projects_overview
    GROUP BY 
        project_id, project_name
),
ProjectSafetyCounts AS (
    SELECT 
        project_id,
        COUNT(DISTINCT officer_id) AS num_safety_officers
    FROM 
        department_projects_overview
    GROUP BY 
        project_id
)
SELECT 
    p.project_name,
    COALESCE(e.num_engineers, 0) AS num_engineers,
    COALESCE(s.num_safety_officers, 0) AS num_safety_officers
FROM 
    Projects p
LEFT JOIN 
    ProjectEngineerCounts e ON e.project_id = p.project_id
LEFT JOIN 
    ProjectSafetyCounts s ON s.project_id = p.project_id
WHERE 
    COALESCE(e.num_engineers, 0) = 0 
    OR COALESCE(s.num_safety_officers, 0) = 0
ORDER BY 
    p.project_name;
