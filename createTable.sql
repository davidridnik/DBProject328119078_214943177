CREATE TABLE Tools
(
  Tool_ID INT NOT NULL,
  Tool_Name varchar2(100) NOT NULL,
  Manufacture_Date DATE NOT NULL,
  Status varchar2(100) NOT NULL,
  PRIMARY KEY (Tool_ID)
);

CREATE TABLE Production_Orders
(
  Production_Order_ID INT NOT NULL,
  Tool_ID INT NOT NULL,
  Quantity INT NOT NULL,
  Start_Date DATE NOT NULL,
  Due_Date DATE NOT NULL,
  Status varchar2(100) NOT NULL,
  FOREIGN KEY (Tool_ID)REFERENCES Tools(Tool_Id),
  PRIMARY KEY (Production_Order_ID)
);

CREATE TABLE Warehouses
(
  Warehouse_ID INT NOT NULL,
  Warehouse_Location varchar2(100) NOT NULL,
  Capacity INT NOT NULL,
  Current_Quantity INT NOT NULL,
  PRIMARY KEY (Warehouse_ID)
);

CREATE TABLE Raw_Materials
(
  Material_ID INT NOT NULL,
  Material_Name varchar2(100) NOT NULL,
  Quantity_in_Stock INT NOT NULL,
  Supplier varchar2(100) NOT NULL,
  PRIMARY KEY (Material_ID)
);

CREATE TABLE Machine_Maintenance
(
  Maintenance_ID INT NOT NULL,
  Machine_ID INT NOT NULL,
  Maintenance_Date DATE NOT NULL,
  Maintenance_Type varchar2(100) NOT NULL,
  Status varchar2(100) NOT NULL,
  PRIMARY KEY (Maintenance_ID)
);

CREATE TABLE Machines
(
  Machine_ID INT NOT NULL,
  Machine_Name varchar2(100) NOT NULL,
  Installation_Date DATE NOT NULL,
  Status varchar2(100) NOT NULL,
  Maintenance_ID INT NOT NULL,
  PRIMARY KEY (Machine_ID),
  FOREIGN KEY (Maintenance_ID) REFERENCES Machine_Maintenance(Maintenance_ID)
);
