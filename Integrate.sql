-- ����� ����� foreign key ����� "MACHINES" ���� ���� "DEPT_MACH"
ALTER TABLE Machines ADD (DepartmentID NUMBER(38));
ALTER TABLE Machines ADD CONSTRAINT fk_MACHINES_Department FOREIGN KEY (DepartmentID) REFERENCES Departments(department_id);

-- ����� ����� foreign key ����� "MACHINE_MAINTENANCE" ���� ���� "ENG_MAINT"
ALTER TABLE Machine_Maintenance ADD (EngineerID NUMBER(38));
ALTER TABLE Machine_Maintenance ADD CONSTRAINT fk_MACHINE_MAINTENANCE_Engineer FOREIGN KEY (EngineerID) REFERENCES Engineers(engineer_id);

-- ����� ����� foreign key ����� "Machines" ���� ���� "ENG_MACH"
ALTER TABLE Machines ADD (EngineerID NUMBER(38));
ALTER TABLE Machines ADD CONSTRAINT fk_MACHINES_Engineer FOREIGN KEY (EngineerID) REFERENCES Engineers(engineer_id);

-- ����� ����� DepartmentID ����� MACHINES
BEGIN
    FOR rec IN (SELECT Machine_ID, department_id
                FROM (SELECT m.Machine_ID, d.department_id,
                             ROW_NUMBER() OVER (PARTITION BY m.Machine_ID ORDER BY DBMS_RANDOM.VALUE) AS rnd
                      FROM Machines m, Departments d)
                WHERE rnd = 1)
    LOOP
        UPDATE Machines
        SET DepartmentID = rec.department_id
        WHERE Machine_ID = rec.Machine_ID;
        COMMIT;
    END LOOP;
END;
/

-- ����� ����� EngineerID ����� MACHINE_MAINTENANCE
BEGIN
    FOR rec IN (SELECT Maintenance_ID, engineer_id
                FROM (SELECT mm.Maintenance_ID, e.engineer_id,
                             ROW_NUMBER() OVER (PARTITION BY mm.Maintenance_ID ORDER BY DBMS_RANDOM.VALUE) AS rnd
                      FROM Machine_Maintenance mm, Engineers e)
                WHERE rnd = 1)
    LOOP
        UPDATE Machine_Maintenance
        SET EngineerID = rec.engineer_id
        WHERE Maintenance_ID = rec.Maintenance_ID;
        COMMIT;
    END LOOP;
END;
/

-- ����� ����� EngineerID ����� MACHINES ���� ���� "ENG_MACH"
BEGIN
    FOR rec IN (SELECT Machine_ID, engineer_id
                FROM (SELECT m.Machine_ID, e.engineer_id,
                             ROW_NUMBER() OVER (PARTITION BY m.Machine_ID ORDER BY DBMS_RANDOM.VALUE) AS rnd
                      FROM Machines m, Engineers e)
                WHERE rnd = 1)
    LOOP
        UPDATE Machines
        SET EngineerID = rec.engineer_id
        WHERE Machine_ID = rec.Machine_ID;
        COMMIT;
    END LOOP;
END;
/
