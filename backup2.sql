﻿prompt PL/SQL Developer Export Tables for user SYS@XE
prompt Created by David on יום ראשון 02 יוני 2024
set feedback off
set define off

prompt Creating MACHINE_MAINTENANCE...
create table MACHINE_MAINTENANCE
(
  maintenance_id   INTEGER not null,
  machine_id       INTEGER not null,
  maintenance_date DATE not null,
  maintenance_type VARCHAR2(100) not null,
  status           VARCHAR2(100) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MACHINE_MAINTENANCE
  add primary key (MAINTENANCE_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating MACHINES...
create table MACHINES
(
  machine_id        INTEGER not null,
  machine_name      VARCHAR2(100) not null,
  installation_date DATE not null,
  status            VARCHAR2(100) default 'Active' not null,
  maintenance_id    INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MACHINES
  add primary key (MACHINE_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MACHINES
  add foreign key (MAINTENANCE_ID)
  references MACHINE_MAINTENANCE (MAINTENANCE_ID);

prompt Creating TOOLS...
create table TOOLS
(
  tool_id          INTEGER not null,
  tool_name        VARCHAR2(100) not null,
  manufacture_date DATE not null,
  status           VARCHAR2(100) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TOOLS
  add primary key (TOOL_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TOOLS
  add constraint CHK_MANUFACTURE_DATE
  check (Manufacture_Date > TO_DATE('2000-01-01', 'YYYY-MM-DD'));

prompt Creating PRODUCTION_ORDERS...
create table PRODUCTION_ORDERS
(
  production_order_id INTEGER not null,
  tool_id             INTEGER not null,
  quantity            INTEGER not null,
  start_date          DATE not null,
  due_date            DATE not null,
  status              VARCHAR2(100) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PRODUCTION_ORDERS
  add primary key (PRODUCTION_ORDER_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PRODUCTION_ORDERS
  add foreign key (TOOL_ID)
  references TOOLS (TOOL_ID);
alter table PRODUCTION_ORDERS
  add constraint CHK_START_DATE
  check (Start_Date <= Due_Date);

prompt Creating RAW_MARETIALS...
create table RAW_MARETIALS
(
  material_id       INTEGER not null,
  material_name     VARCHAR2(100) not null,
  quantity_in_stock INTEGER not null,
  supplier          VARCHAR2(100) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table RAW_MARETIALS
  add primary key (MATERIAL_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating WAREHOUSES...
create table WAREHOUSES
(
  warehouse_id       INTEGER not null,
  warehouse_location VARCHAR2(100) not null,
  capacity           INTEGER not null,
  current_quantity   INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table WAREHOUSES
  add primary key (WAREHOUSE_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Disabling triggers for MACHINE_MAINTENANCE...
alter table MACHINE_MAINTENANCE disable all triggers;
prompt Disabling triggers for MACHINES...
alter table MACHINES disable all triggers;
prompt Disabling triggers for TOOLS...
alter table TOOLS disable all triggers;
prompt Disabling triggers for PRODUCTION_ORDERS...
alter table PRODUCTION_ORDERS disable all triggers;
prompt Disabling triggers for RAW_MARETIALS...
alter table RAW_MARETIALS disable all triggers;
prompt Disabling triggers for WAREHOUSES...
alter table WAREHOUSES disable all triggers;
prompt Disabling foreign key constraints for MACHINES...
alter table MACHINES disable constraint SYS_C009191;
prompt Disabling foreign key constraints for PRODUCTION_ORDERS...
alter table PRODUCTION_ORDERS disable constraint SYS_C009168;
prompt Deleting WAREHOUSES...
delete from WAREHOUSES;
commit;
prompt Deleting RAW_MARETIALS...
delete from RAW_MARETIALS;
commit;
prompt Deleting PRODUCTION_ORDERS...
delete from PRODUCTION_ORDERS;
commit;
prompt Deleting TOOLS...
delete from TOOLS;
commit;
prompt Deleting MACHINES...
delete from MACHINES;
commit;
prompt Deleting MACHINE_MAINTENANCE...
delete from MACHINE_MAINTENANCE;
commit;
prompt Loading MACHINE_MAINTENANCE...
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (99970, 46338, to_date('06-07-2007', 'dd-mm-yyyy'), 'Preventive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (2415, 82546, to_date('23-05-2000', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50304, 81374, to_date('02-07-2016', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (36484, 27881, to_date('06-01-2003', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (7001, 41078, to_date('30-03-2010', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (67057, 24065, to_date('02-10-2001', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (47493, 25910, to_date('27-06-2007', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (27470, 67179, to_date('04-06-2002', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (92681, 23122, to_date('23-06-2004', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (88944, 23993, to_date('14-03-2007', 'dd-mm-yyyy'), 'Corrective Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (82831, 24327, to_date('03-10-2017', 'dd-mm-yyyy'), 'Preventive Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (59730, 46252, to_date('07-01-2006', 'dd-mm-yyyy'), 'Inspection Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (90084, 71472, to_date('23-05-2023', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (12428, 27397, to_date('15-10-2020', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (61769, 39589, to_date('25-09-2015', 'dd-mm-yyyy'), 'Safety Checks', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (30877, 46193, to_date('04-10-2000', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (38388, 13249, to_date('30-12-2010', 'dd-mm-yyyy'), 'Preventive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (2482, 14106, to_date('06-04-2006', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (17212, 48892, to_date('04-04-2007', 'dd-mm-yyyy'), 'Preventive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (15536, 11702, to_date('27-02-2000', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (18079, 43439, to_date('08-05-2018', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (60250, 95186, to_date('26-04-2001', 'dd-mm-yyyy'), 'Predictive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (83439, 7011, to_date('08-02-2008', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (33097, 58543, to_date('19-09-2015', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (91325, 70519, to_date('11-10-2022', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (12909, 81009, to_date('13-10-2005', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (8796, 3497, to_date('18-02-2009', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (70238, 54944, to_date('11-02-2021', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (45967, 80145, to_date('25-10-2008', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (95033, 6821, to_date('22-10-2010', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (18087, 68404, to_date('24-08-2023', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (37925, 75339, to_date('15-03-2003', 'dd-mm-yyyy'), 'Replacement Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (66553, 34096, to_date('13-06-2019', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (63651, 26785, to_date('18-03-2014', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (60618, 6252, to_date('21-08-2000', 'dd-mm-yyyy'), 'Corrective Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (67574, 49936, to_date('20-12-2007', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (80866, 46659, to_date('04-04-2012', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (14184, 12416, to_date('05-02-2017', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (4823, 62879, to_date('19-07-2017', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (76062, 58495, to_date('04-08-2023', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (55380, 5646, to_date('25-02-2009', 'dd-mm-yyyy'), 'Alignment Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (89445, 16338, to_date('19-11-2002', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (65396, 54914, to_date('03-02-2020', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (54266, 41808, to_date('13-09-2004', 'dd-mm-yyyy'), 'Emergency Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (38075, 30221, to_date('04-04-2002', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (98902, 87319, to_date('25-10-2001', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (73902, 16516, to_date('16-11-2014', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (58833, 29277, to_date('26-12-2011', 'dd-mm-yyyy'), 'Safety Checks', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (72049, 82738, to_date('13-08-2020', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (90370, 47513, to_date('04-03-2014', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (28764, 43095, to_date('06-05-2018', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (11856, 6045, to_date('24-03-2015', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (28382, 76768, to_date('30-04-2000', 'dd-mm-yyyy'), 'Routine Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (41337, 67841, to_date('26-03-2003', 'dd-mm-yyyy'), 'Routine Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (85591, 36697, to_date('02-10-2007', 'dd-mm-yyyy'), 'Safety Checks', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (38144, 68118, to_date('23-12-2017', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (31660, 48499, to_date('24-09-2018', 'dd-mm-yyyy'), 'Preventive Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (62113, 2463, to_date('10-02-2007', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (73773, 82723, to_date('22-09-2005', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (94790, 38912, to_date('21-11-2015', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (76622, 83712, to_date('05-04-2019', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (27973, 68256, to_date('04-09-2016', 'dd-mm-yyyy'), 'Calibration Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50284, 12699, to_date('29-01-2004', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (72694, 45663, to_date('03-12-2002', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (59355, 17504, to_date('17-08-2007', 'dd-mm-yyyy'), 'Safety Checks', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (82497, 80266, to_date('19-07-2016', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (26628, 32754, to_date('01-07-2014', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (74762, 79137, to_date('27-06-2005', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (71477, 48956, to_date('01-12-2001', 'dd-mm-yyyy'), 'Safety Checks', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (79288, 79039, to_date('05-06-2016', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (29870, 22522, to_date('19-09-2011', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (439, 85079, to_date('12-09-2010', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (30746, 37929, to_date('02-04-2009', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (54255, 10795, to_date('13-10-2001', 'dd-mm-yyyy'), 'Routine Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (83682, 34132, to_date('22-10-2020', 'dd-mm-yyyy'), 'Inspection Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (91289, 60840, to_date('19-10-2020', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (46533, 76172, to_date('10-08-2019', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (45651, 46360, to_date('02-02-2003', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (20351, 45983, to_date('20-03-2006', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (17295, 55611, to_date('23-12-2015', 'dd-mm-yyyy'), 'Replacement Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (43594, 49946, to_date('17-06-2013', 'dd-mm-yyyy'), 'Calibration Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (4051, 49825, to_date('12-09-2008', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (59678, 51001, to_date('24-02-2018', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (8558, 97713, to_date('31-07-2021', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (92583, 36324, to_date('13-11-2009', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (59464, 32825, to_date('29-06-2004', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (15709, 84044, to_date('29-12-2001', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (62109, 97379, to_date('24-12-2001', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (20740, 379, to_date('30-07-2019', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (37753, 55417, to_date('03-06-2021', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (17240, 18166, to_date('20-04-2002', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (78499, 98449, to_date('01-02-2005', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (1187, 85437, to_date('29-10-2013', 'dd-mm-yyyy'), 'Routine Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (43567, 59470, to_date('31-01-2006', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (53022, 84404, to_date('20-01-2011', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (7862, 77443, to_date('04-10-2003', 'dd-mm-yyyy'), 'Safety Checks', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (44283, 13590, to_date('23-06-2001', 'dd-mm-yyyy'), 'Routine Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (51960, 45519, to_date('11-06-2007', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (77618, 94802, to_date('14-10-2011', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (10134, 13422, to_date('06-02-2014', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Completed');
commit;
prompt 100 records committed...
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (39466, 38631, to_date('06-01-2001', 'dd-mm-yyyy'), 'Predictive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (75886, 29002, to_date('25-10-2002', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (38834, 73331, to_date('09-03-2009', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (59132, 77098, to_date('10-12-2020', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (21012, 18641, to_date('05-03-2012', 'dd-mm-yyyy'), 'Preventive Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (1771, 36842, to_date('08-04-2012', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (12678, 24418, to_date('31-10-2007', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (45155, 12614, to_date('06-06-2014', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56169, 380, to_date('11-09-2001', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (10326, 30290, to_date('13-07-2004', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56769, 93750, to_date('30-08-2005', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (55811, 10437, to_date('09-01-2016', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (79084, 32683, to_date('25-11-2019', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (24812, 64976, to_date('25-07-2015', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (18144, 1064, to_date('25-10-2001', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (39762, 94801, to_date('05-12-2001', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (18971, 51048, to_date('11-09-2018', 'dd-mm-yyyy'), 'Emergency Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (53925, 24111, to_date('14-11-2018', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56398, 49579, to_date('15-06-2000', 'dd-mm-yyyy'), 'Routine Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (83055, 74148, to_date('08-02-2022', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (95954, 607, to_date('26-08-2003', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (21508, 85757, to_date('10-10-2004', 'dd-mm-yyyy'), 'Safety Checks', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (68090, 41796, to_date('22-03-2022', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (52749, 27979, to_date('08-01-2003', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (83026, 89655, to_date('22-09-2006', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (252, 10137, to_date('22-08-2011', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (23361, 56313, to_date('02-12-2020', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (87504, 28578, to_date('08-03-2000', 'dd-mm-yyyy'), 'Safety Checks', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (57554, 90944, to_date('24-04-2020', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (91605, 57880, to_date('19-04-2002', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50686, 65383, to_date('31-01-2017', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (39841, 21039, to_date('15-09-2016', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (3452, 41139, to_date('14-02-2022', 'dd-mm-yyyy'), 'Corrective Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (98534, 3888, to_date('29-06-2004', 'dd-mm-yyyy'), 'Safety Checks', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (90777, 32906, to_date('23-03-2015', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (19051, 75181, to_date('19-09-2012', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (30727, 97863, to_date('07-01-2022', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (99738, 10026, to_date('23-11-2021', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (48725, 48014, to_date('17-03-2003', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (26949, 6774, to_date('05-02-2022', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (85184, 77274, to_date('18-12-2003', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (54277, 26707, to_date('31-01-2018', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (3008, 70457, to_date('01-09-2014', 'dd-mm-yyyy'), 'Routine Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (2144, 22690, to_date('12-06-2007', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (71619, 89639, to_date('03-01-2010', 'dd-mm-yyyy'), 'Routine Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (62992, 74308, to_date('17-10-2009', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (74894, 320, to_date('06-03-2012', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (60500, 69712, to_date('09-11-2003', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (20166, 60801, to_date('14-05-2011', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (53649, 75714, to_date('11-05-2023', 'dd-mm-yyyy'), 'Replacement Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (61145, 76446, to_date('01-06-2006', 'dd-mm-yyyy'), 'Routine Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (65578, 83481, to_date('04-07-2021', 'dd-mm-yyyy'), 'Routine Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (73075, 47889, to_date('24-08-2005', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (68110, 71557, to_date('13-02-2019', 'dd-mm-yyyy'), 'Emergency Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (15006, 25199, to_date('05-03-2023', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (71615, 22182, to_date('10-08-2012', 'dd-mm-yyyy'), 'Predictive Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (13031, 74644, to_date('24-09-2003', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (12987, 42232, to_date('12-05-2000', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (80821, 77262, to_date('10-01-2008', 'dd-mm-yyyy'), 'Routine Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (8024, 7743, to_date('30-04-2015', 'dd-mm-yyyy'), 'Routine Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (91167, 65279, to_date('27-11-2014', 'dd-mm-yyyy'), 'Safety Checks', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (94765, 52277, to_date('21-01-2005', 'dd-mm-yyyy'), 'Emergency Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (5701, 69722, to_date('26-04-2001', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (47566, 85503, to_date('24-11-2007', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (90741, 56546, to_date('09-11-2005', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (44094, 40551, to_date('29-07-2008', 'dd-mm-yyyy'), 'Safety Checks', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (76668, 75570, to_date('30-01-2010', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (25422, 38268, to_date('20-12-2019', 'dd-mm-yyyy'), 'Safety Checks', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (87371, 92737, to_date('28-02-2007', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (58915, 4652, to_date('03-07-2011', 'dd-mm-yyyy'), 'Routine Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56744, 27843, to_date('29-06-2017', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (1313, 15695, to_date('23-05-2022', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (91813, 33265, to_date('17-11-2018', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (21133, 53008, to_date('18-08-2016', 'dd-mm-yyyy'), 'Safety Checks', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (18382, 30583, to_date('13-07-2000', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (81884, 64953, to_date('02-07-2010', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (86179, 27535, to_date('26-11-2020', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (66510, 23092, to_date('29-04-2013', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (97711, 73792, to_date('03-06-2000', 'dd-mm-yyyy'), 'Routine Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (45530, 73589, to_date('18-01-2006', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (89559, 36792, to_date('10-09-2015', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (12463, 89169, to_date('01-05-2021', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (18021, 94587, to_date('07-07-2008', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (36842, 60536, to_date('01-12-2020', 'dd-mm-yyyy'), 'Corrective Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (13971, 7623, to_date('10-12-2012', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (73462, 8050, to_date('25-02-2012', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (55910, 51729, to_date('25-03-2012', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (22880, 76203, to_date('27-09-2007', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (96580, 26809, to_date('09-12-2015', 'dd-mm-yyyy'), 'Routine Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (18723, 76257, to_date('05-03-2012', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (48563, 5717, to_date('04-09-2023', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (28442, 97589, to_date('05-07-2020', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (19129, 12216, to_date('07-02-2003', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (51850, 97065, to_date('08-08-2001', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (65564, 21640, to_date('20-07-2015', 'dd-mm-yyyy'), 'Calibration Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (92532, 29353, to_date('25-05-2022', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50506, 19401, to_date('07-06-2000', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (17170, 80832, to_date('12-05-2021', 'dd-mm-yyyy'), 'Corrective Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (93709, 36971, to_date('04-01-2007', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (13199, 46767, to_date('06-10-2007', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
commit;
prompt 200 records committed...
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (73404, 68634, to_date('06-06-2010', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (62381, 27076, to_date('31-01-2018', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (8241, 61484, to_date('25-01-2020', 'dd-mm-yyyy'), 'Alignment Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (72943, 41522, to_date('27-08-2007', 'dd-mm-yyyy'), 'Routine Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (80991, 22017, to_date('16-02-2001', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (12265, 61721, to_date('25-04-2019', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (28942, 1496, to_date('06-03-2017', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (61887, 56287, to_date('29-09-2009', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (54539, 65383, to_date('23-11-2020', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (33103, 27968, to_date('13-01-2013', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (84535, 25598, to_date('16-08-2008', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (40873, 18980, to_date('26-12-2021', 'dd-mm-yyyy'), 'Safety Checks', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (57954, 74678, to_date('27-07-2006', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (92508, 54198, to_date('08-09-2015', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (33823, 14101, to_date('06-05-2020', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (11699, 12683, to_date('29-12-2010', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (10128, 71492, to_date('09-08-2010', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (44364, 47384, to_date('17-09-2002', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (16995, 59336, to_date('17-10-2002', 'dd-mm-yyyy'), 'Inspection Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (86664, 42144, to_date('08-05-2004', 'dd-mm-yyyy'), 'Alignment Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (21070, 97444, to_date('03-11-2018', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (93526, 85412, to_date('19-11-2005', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (35555, 9039, to_date('04-07-2007', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (74631, 82790, to_date('03-12-2003', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (2738, 62102, to_date('27-06-2000', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (20025, 6777, to_date('05-06-2015', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (84300, 69974, to_date('11-12-2003', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (25762, 23205, to_date('30-04-2011', 'dd-mm-yyyy'), 'Emergency Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (90514, 44121, to_date('08-01-2022', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (67404, 21070, to_date('01-02-2003', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (83782, 14021, to_date('20-04-2011', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (2146, 36993, to_date('08-09-2016', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (36274, 50297, to_date('07-07-2022', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (24921, 88712, to_date('04-05-2004', 'dd-mm-yyyy'), 'Routine Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (86698, 53858, to_date('30-10-2001', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (66488, 44986, to_date('04-10-2023', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (58954, 62217, to_date('21-02-2006', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (58275, 43361, to_date('02-10-2011', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56647, 80497, to_date('14-05-2022', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (6058, 53710, to_date('07-08-2022', 'dd-mm-yyyy'), 'Replacement Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (63600, 25193, to_date('22-05-2021', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (68567, 55427, to_date('18-09-2013', 'dd-mm-yyyy'), 'Calibration Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (42678, 79798, to_date('31-08-2002', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (34068, 81065, to_date('21-11-2018', 'dd-mm-yyyy'), 'Safety Checks', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (64789, 59165, to_date('21-08-2022', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (84156, 60144, to_date('19-08-2014', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (98090, 70180, to_date('21-02-2021', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (35692, 5145, to_date('02-01-2019', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (75400, 96274, to_date('04-10-2003', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (15128, 98629, to_date('06-09-2022', 'dd-mm-yyyy'), 'Preventive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (16900, 28721, to_date('13-09-2004', 'dd-mm-yyyy'), 'Inspection Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50897, 97141, to_date('05-01-2020', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (46645, 74773, to_date('17-04-2007', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (25034, 45369, to_date('19-04-2021', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (86415, 97811, to_date('18-03-2005', 'dd-mm-yyyy'), 'Preventive Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (11275, 24270, to_date('03-09-2011', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (70303, 43979, to_date('29-11-2002', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (99619, 20560, to_date('02-07-2018', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (79379, 89569, to_date('24-04-2017', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (73071, 33649, to_date('08-08-2003', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (79115, 59941, to_date('14-09-2018', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (17198, 10763, to_date('25-02-2010', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (34083, 30193, to_date('16-02-2012', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (13588, 53074, to_date('10-09-2000', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (6242, 76532, to_date('26-12-2002', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50378, 46288, to_date('04-05-2011', 'dd-mm-yyyy'), 'Routine Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (95914, 11446, to_date('24-07-2003', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (83155, 69628, to_date('16-12-2023', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (89754, 61619, to_date('22-03-2004', 'dd-mm-yyyy'), 'Emergency Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (53829, 8756, to_date('08-12-2003', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (18770, 41454, to_date('26-09-2017', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (29862, 72055, to_date('13-11-2015', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (33076, 93036, to_date('02-09-2014', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (17765, 67274, to_date('11-07-2014', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (49763, 12014, to_date('13-04-2010', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (39212, 67843, to_date('09-05-2003', 'dd-mm-yyyy'), 'Calibration Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (57319, 14020, to_date('03-06-2005', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (91836, 66662, to_date('04-10-2014', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (45675, 24580, to_date('03-01-2022', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (55930, 10957, to_date('03-08-2009', 'dd-mm-yyyy'), 'Corrective Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (6457, 52806, to_date('29-05-2014', 'dd-mm-yyyy'), 'Corrective Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (9131, 16170, to_date('27-04-2014', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (94577, 42147, to_date('01-09-2005', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (80067, 1144, to_date('28-08-2003', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (91260, 36078, to_date('15-01-2011', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (64941, 52111, to_date('06-08-2002', 'dd-mm-yyyy'), 'Calibration Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (41073, 59183, to_date('16-05-2010', 'dd-mm-yyyy'), 'Calibration Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (54621, 40766, to_date('31-03-2015', 'dd-mm-yyyy'), 'Calibration Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (82946, 50949, to_date('03-02-2011', 'dd-mm-yyyy'), 'Preventive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (30026, 72875, to_date('07-03-2001', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (38581, 6828, to_date('02-05-2000', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (86840, 60087, to_date('30-06-2019', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (92466, 35162, to_date('09-06-2009', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (3013, 69724, to_date('01-05-2015', 'dd-mm-yyyy'), 'Safety Checks', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (77117, 35525, to_date('13-07-2006', 'dd-mm-yyyy'), 'Safety Checks', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (70413, 46953, to_date('09-02-2019', 'dd-mm-yyyy'), 'Predictive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (96381, 209, to_date('14-04-2000', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (31661, 1841, to_date('12-07-2014', 'dd-mm-yyyy'), 'Predictive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (59996, 42291, to_date('29-11-2019', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (717, 41805, to_date('16-11-2012', 'dd-mm-yyyy'), 'Safety Checks', 'Completed');
commit;
prompt 300 records committed...
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (95253, 17037, to_date('17-07-2000', 'dd-mm-yyyy'), 'Emergency Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (57655, 89044, to_date('28-03-2006', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (27897, 34792, to_date('18-10-2000', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (328, 83964, to_date('18-09-2001', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (15494, 19049, to_date('26-11-2021', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (64618, 20626, to_date('02-01-2009', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (53729, 49430, to_date('06-02-2001', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (96967, 20120, to_date('05-05-2021', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (90609, 2072, to_date('26-04-2015', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (34043, 3722, to_date('09-01-2001', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56739, 65619, to_date('05-12-2017', 'dd-mm-yyyy'), 'Preventive Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (21081, 10965, to_date('05-10-2004', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (82776, 25986, to_date('08-06-2009', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (38812, 99698, to_date('06-04-2022', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (9294, 83439, to_date('14-04-2019', 'dd-mm-yyyy'), 'Routine Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (15228, 96911, to_date('08-08-2003', 'dd-mm-yyyy'), 'Safety Checks', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (30686, 47702, to_date('12-09-2022', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (29009, 21936, to_date('03-05-2014', 'dd-mm-yyyy'), 'Inspection Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (34769, 56860, to_date('08-06-2012', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (72480, 8828, to_date('04-07-2007', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (34599, 40177, to_date('20-08-2006', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (89698, 93494, to_date('11-03-2020', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (19998, 99714, to_date('30-07-2007', 'dd-mm-yyyy'), 'Corrective Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (46014, 34733, to_date('02-09-2022', 'dd-mm-yyyy'), 'Preventive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (14541, 77143, to_date('22-01-2012', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (75374, 88077, to_date('09-10-2003', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (90705, 6616, to_date('07-06-2023', 'dd-mm-yyyy'), 'Routine Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (97073, 78381, to_date('21-08-2020', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (2579, 88258, to_date('24-09-2007', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50741, 2722, to_date('23-09-2019', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (23366, 56002, to_date('30-05-2023', 'dd-mm-yyyy'), 'Safety Checks', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (73505, 70683, to_date('09-07-2022', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (55126, 14346, to_date('27-02-2011', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (92543, 35681, to_date('25-05-2005', 'dd-mm-yyyy'), 'Predictive Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (91924, 87501, to_date('10-12-2012', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (36048, 19896, to_date('10-09-2013', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (96193, 17426, to_date('14-02-2021', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (32115, 67910, to_date('28-01-2009', 'dd-mm-yyyy'), 'Replacement Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (72823, 70795, to_date('15-08-2006', 'dd-mm-yyyy'), 'Routine Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (74559, 11518, to_date('17-03-2014', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (27539, 25213, to_date('04-08-2015', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (43332, 71603, to_date('08-10-2018', 'dd-mm-yyyy'), 'Corrective Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56760, 8177, to_date('04-10-2011', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (81377, 93829, to_date('02-12-2011', 'dd-mm-yyyy'), 'Routine Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (66651, 14777, to_date('05-08-2020', 'dd-mm-yyyy'), 'Overhaul Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (5673, 94222, to_date('08-07-2001', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (40626, 37986, to_date('07-01-2013', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (73992, 10019, to_date('14-07-2023', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (98503, 65055, to_date('01-10-2021', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (97056, 91450, to_date('12-06-2001', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (98057, 31115, to_date('22-09-2020', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (84224, 62820, to_date('07-09-2002', 'dd-mm-yyyy'), 'Routine Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (52008, 32892, to_date('04-01-2000', 'dd-mm-yyyy'), 'Safety Checks', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (96155, 7505, to_date('23-08-2006', 'dd-mm-yyyy'), 'Calibration Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (52036, 97760, to_date('20-06-2011', 'dd-mm-yyyy'), 'Preventive Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56096, 22615, to_date('27-02-2016', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (37123, 32308, to_date('10-04-2019', 'dd-mm-yyyy'), 'Alignment Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (98869, 26260, to_date('30-12-2020', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (97980, 46626, to_date('15-08-2003', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (19581, 14926, to_date('13-05-2011', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (3534, 21673, to_date('06-07-2011', 'dd-mm-yyyy'), 'Safety Checks', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (78649, 41594, to_date('18-02-2015', 'dd-mm-yyyy'), 'Condition-Based Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50757, 63747, to_date('17-06-2012', 'dd-mm-yyyy'), 'Calibration Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (32416, 48242, to_date('03-04-2016', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (6862, 28485, to_date('28-12-2014', 'dd-mm-yyyy'), 'Routine Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (45347, 20430, to_date('13-07-2012', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (14065, 3135, to_date('07-06-2019', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (7175, 68117, to_date('22-09-2010', 'dd-mm-yyyy'), 'Safety Checks', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (93326, 66427, to_date('29-03-2019', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (82301, 56870, to_date('09-01-2021', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (95610, 6420, to_date('18-03-2000', 'dd-mm-yyyy'), 'Safety Checks', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (65774, 48468, to_date('01-09-2010', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (38798, 24398, to_date('23-05-2016', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (66321, 40899, to_date('14-09-2005', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (16526, 93696, to_date('23-03-2014', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (88614, 56023, to_date('29-10-2023', 'dd-mm-yyyy'), 'Preventive Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (3188, 32205, to_date('07-07-2000', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (278, 90062, to_date('20-06-2009', 'dd-mm-yyyy'), 'Calibration Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (88463, 92738, to_date('17-03-2004', 'dd-mm-yyyy'), 'Replacement Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (50539, 48853, to_date('07-07-2022', 'dd-mm-yyyy'), 'Safety Checks', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (86107, 32607, to_date('26-07-2022', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (12970, 17577, to_date('26-03-2005', 'dd-mm-yyyy'), 'Routine Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (56805, 98779, to_date('12-06-2016', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (60788, 94917, to_date('24-05-2012', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'On Hold');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (94731, 14385, to_date('25-07-2006', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (5975, 35304, to_date('02-01-2006', 'dd-mm-yyyy'), 'Inspection Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (33415, 82055, to_date('26-04-2022', 'dd-mm-yyyy'), 'Scheduled Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (49154, 21571, to_date('12-05-2018', 'dd-mm-yyyy'), 'Predictive Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (59810, 86141, to_date('31-08-2022', 'dd-mm-yyyy'), 'Safety Checks', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (52149, 15021, to_date('29-11-2004', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (67386, 85281, to_date('08-10-2015', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Cancelled');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (65511, 31964, to_date('26-09-2006', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (60755, 95510, to_date('13-09-2014', 'dd-mm-yyyy'), 'Predictive Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (75481, 56435, to_date('27-04-2019', 'dd-mm-yyyy'), 'Safety Checks', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (27217, 78259, to_date('07-05-2011', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (84908, 49275, to_date('04-11-2008', 'dd-mm-yyyy'), 'Corrective Maintenance', 'Pending');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (45760, 23457, to_date('05-11-2001', 'dd-mm-yyyy'), 'Unscheduled Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (66982, 35368, to_date('20-02-2015', 'dd-mm-yyyy'), 'Lubrication Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (92840, 61805, to_date('27-05-2005', 'dd-mm-yyyy'), 'Routine Maintenance', 'Failed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (35426, 74711, to_date('09-02-2021', 'dd-mm-yyyy'), 'Alignment Maintenance', 'On Hold');
commit;
prompt 400 records loaded
prompt Loading MACHINES...
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (34970, 'Leak Testing Machine', to_date('01-12-2001', 'dd-mm-yyyy'), 'Operational', 65774);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (61740, 'Welding and Cutting Machine', to_date('15-07-2020', 'dd-mm-yyyy'), 'Testing', 37925);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (82030, 'Wire Drawing Machine', to_date('20-03-2015', 'dd-mm-yyyy'), 'Standby', 14184);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (18319, 'Laser Welding Machine', to_date('27-04-2015', 'dd-mm-yyyy'), 'In Production', 64789);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (59674, 'Hardness Testing Machine', to_date('26-12-2007', 'dd-mm-yyyy'), 'In Production', 88944);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (28600, 'Horizontal Boring Mill', to_date('27-02-2017', 'dd-mm-yyyy'), 'Calibration', 44283);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (44229, 'Grit Blasting Machine', to_date('06-04-2023', 'dd-mm-yyyy'), 'In Production', 31660);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (45423, 'Assembly Machine', to_date('03-04-2012', 'dd-mm-yyyy'), 'Testing', 9131);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (35983, 'Acoustic Testing Machine', to_date('12-08-2012', 'dd-mm-yyyy'), 'Idle', 62992);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (75094, 'Punch Press', to_date('27-02-2007', 'dd-mm-yyyy'), 'In Production', 27470);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (8710, 'Rheo-Microscopy Machine', to_date('15-05-2018', 'dd-mm-yyyy'), 'Standby', 46533);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (64064, 'Metallurgical Testing Machine', to_date('08-02-2002', 'dd-mm-yyyy'), 'In Production', 99970);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (17418, 'Thread Rolling Machine', to_date('17-11-2011', 'dd-mm-yyyy'), 'Under Maintenance', 79288);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (41040, 'Alignment Machine', to_date('23-04-2018', 'dd-mm-yyyy'), 'Idle', 16995);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (80521, 'Chemical Testing Machine', to_date('15-05-2013', 'dd-mm-yyyy'), 'Operational', 73404);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (25015, 'Wire Bender', to_date('06-12-2012', 'dd-mm-yyyy'), 'Idle', 2415);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (84342, 'Plate Bender', to_date('05-08-2020', 'dd-mm-yyyy'), 'Shutdown', 83439);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (91899, 'Rebar Bender', to_date('24-01-2009', 'dd-mm-yyyy'), 'Under Maintenance', 12463);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (25766, 'Metallurgical Testing Machine', to_date('07-08-2006', 'dd-mm-yyyy'), 'Testing', 78499);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (75269, 'Pipe Rolling Machine', to_date('19-03-2022', 'dd-mm-yyyy'), 'Idle', 76622);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (13090, 'Water Jet Cutter', to_date('18-11-2017', 'dd-mm-yyyy'), 'Decommissioned', 95954);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (43016, 'Thermogravimetric Analysis Machine', to_date('25-09-2009', 'dd-mm-yyyy'), 'Shutdown', 67404);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (36489, 'Rheo-Raman', to_date('10-05-2014', 'dd-mm-yyyy'), 'Idle', 65774);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (46170, 'Mechanical Press', to_date('01-02-2017', 'dd-mm-yyyy'), 'Standby', 52008);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (970, 'Scratch Testing Machine', to_date('12-12-2018', 'dd-mm-yyyy'), 'Idle', 72049);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (66839, 'Drilling and Tapping Machine', to_date('11-06-2004', 'dd-mm-yyyy'), 'Idle', 95610);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (49669, 'Physical Testing Machine', to_date('27-01-2018', 'dd-mm-yyyy'), 'Idle', 59132);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (42284, 'Stamping Machine', to_date('23-12-2001', 'dd-mm-yyyy'), 'Testing', 91813);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (60553, 'Subtractive Manufacturing Machine', to_date('29-03-2009', 'dd-mm-yyyy'), 'Testing', 17170);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (66512, 'Quenching Machine', to_date('01-12-2019', 'dd-mm-yyyy'), 'Testing', 98090);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (88329, 'Pipe Making Machine', to_date('26-08-2020', 'dd-mm-yyyy'), 'Malfunctioning', 71477);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (75504, 'Thermogravimetric Analysis Machine', to_date('12-03-2008', 'dd-mm-yyyy'), 'Standby', 91325);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (76989, 'Wear Testing Machine', to_date('21-05-2009', 'dd-mm-yyyy'), 'Testing', 15128);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (63732, 'Rod Drawing Machine', to_date('14-08-2001', 'dd-mm-yyyy'), 'Malfunctioning', 58954);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (68128, 'Tube Drawing Machine', to_date('21-12-2022', 'dd-mm-yyyy'), 'Under Maintenance', 96967);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (64087, 'Rheo-Microscopy Machine', to_date('07-03-2013', 'dd-mm-yyyy'), 'Calibration', 38581);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (7219, 'Stress Rupture Testing Machine', to_date('09-06-2007', 'dd-mm-yyyy'), 'Under Maintenance', 89698);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (7014, 'Transfer Molding Machine', to_date('26-05-2004', 'dd-mm-yyyy'), 'Malfunctioning', 75400);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (85675, 'Calibration Machine', to_date('01-11-2010', 'dd-mm-yyyy'), 'In Production', 252);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (63829, 'Non-Destructive Testing Machine', to_date('15-07-2004', 'dd-mm-yyyy'), 'Under Maintenance', 79288);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (82018, 'Burst Testing Machine', to_date('24-02-2004', 'dd-mm-yyyy'), 'Idle', 56769);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (30066, 'Pipe Drawing Machine', to_date('05-09-2011', 'dd-mm-yyyy'), 'Operational', 28382);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (62041, 'Vertical Boring Mill', to_date('17-12-2008', 'dd-mm-yyyy'), 'Under Maintenance', 64789);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (23548, 'Engraving Machine', to_date('13-12-2021', 'dd-mm-yyyy'), 'Standby', 66553);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (96814, 'Rheo-Spectroscopy Machine', to_date('14-11-2014', 'dd-mm-yyyy'), 'Decommissioned', 76622);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (14940, 'Dynamic Mechanical Analysis Machine', to_date('15-05-2023', 'dd-mm-yyyy'), 'Standby', 18021);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (39860, 'Router Table', to_date('05-09-2000', 'dd-mm-yyyy'), 'Idle', 64618);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (82080, 'Assembly Machine', to_date('18-02-2016', 'dd-mm-yyyy'), 'Standby', 64789);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (2207, 'Rotational Molding Machine', to_date('01-09-2021', 'dd-mm-yyyy'), 'Under Maintenance', 89445);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (39653, 'Thermal Shock Testing Machine', to_date('23-08-2002', 'dd-mm-yyyy'), 'In Production', 12463);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (57501, 'Subtractive Manufacturing Machine', to_date('20-11-2021', 'dd-mm-yyyy'), 'Standby', 98534);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (48955, 'Flow Testing Machine', to_date('01-12-2017', 'dd-mm-yyyy'), 'Under Maintenance', 37925);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (30130, 'Pipe Rolling Machine', to_date('26-04-2019', 'dd-mm-yyyy'), 'Decommissioned', 43567);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (14983, 'Leveling Machine', to_date('21-08-2021', 'dd-mm-yyyy'), 'Shutdown', 1187);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (48718, 'Dynamic Mechanical Analysis Machine', to_date('29-12-2023', 'dd-mm-yyyy'), 'Standby', 54255);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (35965, 'Boring Mill', to_date('18-08-2012', 'dd-mm-yyyy'), 'Malfunctioning', 59355);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (16607, 'Surface Treatment Machine', to_date('15-10-2016', 'dd-mm-yyyy'), 'Shutdown', 94790);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (40091, 'Extensional Rheometer', to_date('04-04-2016', 'dd-mm-yyyy'), 'Under Maintenance', 59464);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (41228, 'Testing Machine', to_date('09-05-2018', 'dd-mm-yyyy'), 'Idle', 64618);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (31786, 'Bar Bender', to_date('07-11-2000', 'dd-mm-yyyy'), 'Testing', 27539);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (7010, 'Gear Shaping Machine', to_date('13-11-2005', 'dd-mm-yyyy'), 'Testing', 78499);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (31698, 'Heat Capacity Testing Machine', to_date('09-03-2006', 'dd-mm-yyyy'), 'In Production', 33097);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (52650, 'Electroplating Machine', to_date('09-12-2012', 'dd-mm-yyyy'), 'Shutdown', 86179);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (36862, 'Machining and Assembly Machine', to_date('14-09-2012', 'dd-mm-yyyy'), 'Under Maintenance', 43332);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (54790, 'Radial Arm Saw', to_date('23-06-2010', 'dd-mm-yyyy'), 'Under Maintenance', 64941);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (6474, 'Foam Cutting Machine', to_date('28-03-2010', 'dd-mm-yyyy'), 'Decommissioned', 23366);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (7250, 'Tube Drawing Machine', to_date('15-10-2001', 'dd-mm-yyyy'), 'Testing', 3534);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (729, 'Thread Rolling Machine', to_date('19-10-2016', 'dd-mm-yyyy'), 'Operational', 98902);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (49594, 'Spline Cutting Machine', to_date('26-05-2000', 'dd-mm-yyyy'), 'Operational', 34769);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (21335, 'Rheo-WAXS', to_date('01-03-2021', 'dd-mm-yyyy'), 'Calibration', 53925);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (21917, 'Cylindrical Grinder', to_date('16-11-2009', 'dd-mm-yyyy'), 'Idle', 73505);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (28966, 'Drilling Machine', to_date('09-12-2006', 'dd-mm-yyyy'), 'Decommissioned', 27217);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (35715, 'Spline Rolling Machine', to_date('31-12-2010', 'dd-mm-yyyy'), 'Malfunctioning', 71615);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (1351, 'Thermal Shock Testing Machine', to_date('18-01-2002', 'dd-mm-yyyy'), 'Shutdown', 55930);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (34825, 'Thermal Cycling Testing Machine', to_date('19-01-2010', 'dd-mm-yyyy'), 'Decommissioned', 73505);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (51962, 'Machining Center', to_date('24-09-2003', 'dd-mm-yyyy'), 'Operational', 19051);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (6812, 'Compression Molding Machine', to_date('08-07-2000', 'dd-mm-yyyy'), 'Shutdown', 34769);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (9922, 'Engraving Machine', to_date('30-05-2016', 'dd-mm-yyyy'), 'Malfunctioning', 41073);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (75199, 'Pressure Testing Machine', to_date('01-09-2014', 'dd-mm-yyyy'), 'Standby', 12678);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (72691, 'Residual Stress Testing Machine', to_date('20-03-2002', 'dd-mm-yyyy'), 'Shutdown', 92532);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (87840, 'Wire Rolling Machine', to_date('28-08-2014', 'dd-mm-yyyy'), 'Shutdown', 54277);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (40941, 'Machining and Assembly Machine', to_date('27-02-2010', 'dd-mm-yyyy'), 'Under Maintenance', 58833);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (97633, 'Transfer Molding Machine', to_date('26-06-2002', 'dd-mm-yyyy'), 'Shutdown', 49154);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (35672, 'Heat Treating Machine', to_date('31-08-2022', 'dd-mm-yyyy'), 'Decommissioned', 38144);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (40122, 'Bar Drawing Machine', to_date('02-01-2010', 'dd-mm-yyyy'), 'Operational', 55910);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (37608, 'Thermoforming Machine', to_date('22-06-2017', 'dd-mm-yyyy'), 'Standby', 28442);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (29403, 'Thermogravimetric Analysis Machine', to_date('12-07-2019', 'dd-mm-yyyy'), 'Shutdown', 15228);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (84315, 'Extensional Rheometer', to_date('13-08-2019', 'dd-mm-yyyy'), 'Under Maintenance', 56096);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (50498, 'Swiss Machine', to_date('18-12-2013', 'dd-mm-yyyy'), 'Standby', 72480);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (67595, 'Laser Cutter', to_date('24-10-2008', 'dd-mm-yyyy'), 'Operational', 1313);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (4195, 'Label Making Machine', to_date('30-06-2006', 'dd-mm-yyyy'), 'Testing', 11699);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (98828, 'Machining Center', to_date('02-05-2010', 'dd-mm-yyyy'), 'Calibration', 10128);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (90506, 'Lathe', to_date('13-10-2008', 'dd-mm-yyyy'), 'Operational', 95610);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (9246, 'Calibration Machine', to_date('09-02-2021', 'dd-mm-yyyy'), 'Under Maintenance', 8241);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (80710, 'Tube Rolling Machine', to_date('03-05-2015', 'dd-mm-yyyy'), 'Shutdown', 68110);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (31881, 'Spline Rolling Machine', to_date('18-10-2021', 'dd-mm-yyyy'), 'Decommissioned', 6058);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (56507, 'Bar Drawing Machine', to_date('11-05-2013', 'dd-mm-yyyy'), 'In Production', 39212);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (28499, 'Shearing Machine', to_date('20-04-2016', 'dd-mm-yyyy'), 'Idle', 4051);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (69557, 'Annealing Machine', to_date('24-08-2019', 'dd-mm-yyyy'), 'In Production', 56744);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (84208, 'Plate Bender', to_date('22-04-2013', 'dd-mm-yyyy'), 'Shutdown', 5975);
commit;
prompt 100 records committed...
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (26712, 'Optical Testing Machine', to_date('14-05-2002', 'dd-mm-yyyy'), 'Standby', 44364);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (51224, 'Grinding Machine', to_date('29-04-2000', 'dd-mm-yyyy'), 'Standby', 64618);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (16890, 'Tenoner', to_date('24-06-2017', 'dd-mm-yyyy'), 'In Production', 18770);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (87344, 'Panel Folding Machine', to_date('24-11-2009', 'dd-mm-yyyy'), 'Operational', 15536);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (96039, 'Wire EDM', to_date('01-06-2004', 'dd-mm-yyyy'), 'Testing', 44364);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (60644, 'Hardening Machine', to_date('17-09-2004', 'dd-mm-yyyy'), 'Under Maintenance', 35555);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (18220, 'Turning Center', to_date('23-03-2003', 'dd-mm-yyyy'), 'Operational', 99619);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (85670, 'Testing Machine', to_date('19-08-2015', 'dd-mm-yyyy'), 'Under Maintenance', 45347);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (74742, 'Stress Relieving Machine', to_date('23-10-2006', 'dd-mm-yyyy'), 'Decommissioned', 86698);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (74559, 'Honing Machine', to_date('14-11-2018', 'dd-mm-yyyy'), 'Calibration', 90370);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (60844, 'Table Saw', to_date('01-03-2015', 'dd-mm-yyyy'), 'Calibration', 8241);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (89132, 'Brazing Machine', to_date('22-10-2022', 'dd-mm-yyyy'), 'Idle', 43567);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (47052, 'Drilling and Tapping Machine', to_date('29-05-2003', 'dd-mm-yyyy'), 'Operational', 55910);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (93058, 'Thread Rolling Machine', to_date('19-04-2010', 'dd-mm-yyyy'), 'Calibration', 17765);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (42281, 'Dovetailer', to_date('01-06-2007', 'dd-mm-yyyy'), 'Malfunctioning', 50757);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (54756, 'Thermal Cycling Testing Machine', to_date('21-04-2008', 'dd-mm-yyyy'), 'Standby', 30877);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (19470, 'Reaming Machine', to_date('09-08-2015', 'dd-mm-yyyy'), 'Testing', 19129);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (49466, 'Slitter Rewinder', to_date('21-11-2010', 'dd-mm-yyyy'), 'In Production', 2415);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (94041, 'Grinding and Polishing Machine', to_date('14-06-2011', 'dd-mm-yyyy'), 'Operational', 28442);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (60608, 'Peening Machine', to_date('06-08-2006', 'dd-mm-yyyy'), 'Calibration', 98902);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (87362, 'Painting Machine', to_date('31-05-2000', 'dd-mm-yyyy'), 'Testing', 92508);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (27063, 'Pipe Rolling Machine', to_date('01-12-2023', 'dd-mm-yyyy'), 'Testing', 45530);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (3013, 'Thermal Conductivity Testing Machine', to_date('24-12-2009', 'dd-mm-yyyy'), 'Calibration', 38075);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (12050, 'Tenoner', to_date('04-02-2004', 'dd-mm-yyyy'), 'Under Maintenance', 66651);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (85131, 'Shot Peening Machine', to_date('15-11-2018', 'dd-mm-yyyy'), 'Testing', 83155);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (9509, 'Gear Grinding Machine', to_date('05-09-2022', 'dd-mm-yyyy'), 'In Production', 87504);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (1847, 'Thermal Fatigue Testing Machine', to_date('13-07-2019', 'dd-mm-yyyy'), 'Standby', 6862);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (67261, 'Tumbling Machine', to_date('21-07-2009', 'dd-mm-yyyy'), 'Calibration', 92466);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (55864, 'Tube Making Machine', to_date('26-04-2004', 'dd-mm-yyyy'), 'Testing', 73462);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (37600, 'Injection Molding Machine', to_date('22-03-2009', 'dd-mm-yyyy'), 'Standby', 60788);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (85748, 'Corrosion Testing Machine', to_date('10-08-2010', 'dd-mm-yyyy'), 'Operational', 94577);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (21486, 'Creep Testing Machine', to_date('19-07-2004', 'dd-mm-yyyy'), 'Under Maintenance', 9294);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (66412, 'Leak Testing Machine', to_date('12-11-2005', 'dd-mm-yyyy'), 'Malfunctioning', 13588);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (58603, 'Flexural Testing Machine', to_date('09-05-2019', 'dd-mm-yyyy'), 'Under Maintenance', 87504);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (77214, 'Rheo-Dielectric Machine', to_date('27-02-2017', 'dd-mm-yyyy'), 'Operational', 7862);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (88249, 'Additive Manufacturing Machine', to_date('16-10-2019', 'dd-mm-yyyy'), 'Malfunctioning', 65578);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (62026, 'Bead Blasting Machine', to_date('16-03-2021', 'dd-mm-yyyy'), 'Idle', 47493);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (71780, 'Additive Manufacturing Machine', to_date('13-10-2008', 'dd-mm-yyyy'), 'Standby', 96381);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (88912, 'Reaming Machine', to_date('11-11-2018', 'dd-mm-yyyy'), 'Under Maintenance', 97980);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (82244, 'Panel Folding Machine', to_date('29-05-2005', 'dd-mm-yyyy'), 'Malfunctioning', 87504);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (8976, 'Resistance Welding Machine', to_date('06-05-2021', 'dd-mm-yyyy'), 'In Production', 3188);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (37295, 'Foam Cutting Machine', to_date('03-08-2023', 'dd-mm-yyyy'), 'Idle', 90514);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (45656, 'Peeling Machine', to_date('09-12-2009', 'dd-mm-yyyy'), 'Shutdown', 55126);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (33549, 'Leveling Machine', to_date('23-04-2009', 'dd-mm-yyyy'), 'Decommissioned', 55910);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (98597, 'Coating Machine', to_date('11-11-2007', 'dd-mm-yyyy'), 'Decommissioned', 38812);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (40685, 'Dynamic Mechanical Analysis Machine', to_date('01-01-2008', 'dd-mm-yyyy'), 'Standby', 84224);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (51384, 'Tapping Machine', to_date('24-01-2002', 'dd-mm-yyyy'), 'Calibration', 43567);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (87897, 'Compression Testing Machine', to_date('06-10-2007', 'dd-mm-yyyy'), 'Under Maintenance', 39466);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (11203, 'Cut-off Saw', to_date('20-05-2021', 'dd-mm-yyyy'), 'Shutdown', 13199);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (30084, 'Impact Testing Machine', to_date('13-10-2000', 'dd-mm-yyyy'), 'Shutdown', 73404);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (12110, 'Residual Stress Testing Machine', to_date('12-01-2003', 'dd-mm-yyyy'), 'Standby', 29862);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (72661, 'Leak Testing Machine', to_date('16-04-2010', 'dd-mm-yyyy'), 'In Production', 18770);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (63291, 'Slitter Rewinder', to_date('03-11-2001', 'dd-mm-yyyy'), 'Under Maintenance', 4051);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (68390, 'Surface Treatment Machine', to_date('24-03-2013', 'dd-mm-yyyy'), 'Testing', 95914);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (50750, 'Swiss Machine', to_date('05-10-2018', 'dd-mm-yyyy'), 'Standby', 27539);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (33245, 'Wire EDM', to_date('22-01-2011', 'dd-mm-yyyy'), 'Calibration', 3188);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (86495, 'Compression Testing Machine', to_date('03-03-2007', 'dd-mm-yyyy'), 'Standby', 12463);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (67565, 'Destructive Testing Machine', to_date('05-12-2015', 'dd-mm-yyyy'), 'Shutdown', 55380);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (74805, 'Shearing Machine', to_date('05-05-2012', 'dd-mm-yyyy'), 'Malfunctioning', 59355);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (69579, 'Stamping Press', to_date('30-10-2012', 'dd-mm-yyyy'), 'Idle', 10128);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (11712, 'Label Making Machine', to_date('19-01-2007', 'dd-mm-yyyy'), 'Shutdown', 8024);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (97240, 'Cutting Machine', to_date('10-06-2011', 'dd-mm-yyyy'), 'Standby', 57655);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (82789, 'Coating Machine', to_date('27-08-2023', 'dd-mm-yyyy'), 'Malfunctioning', 59464);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (27398, 'Pipe Rolling Machine', to_date('17-08-2019', 'dd-mm-yyyy'), 'Under Maintenance', 91289);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (56831, 'Thermal Shock Testing Machine', to_date('07-05-2010', 'dd-mm-yyyy'), 'Under Maintenance', 58833);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (84836, 'Leveling Machine', to_date('01-01-2008', 'dd-mm-yyyy'), 'Testing', 86179);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (20382, 'Reaming Machine', to_date('30-03-2011', 'dd-mm-yyyy'), 'Testing', 45347);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (23992, 'Spline Cutting Machine', to_date('27-03-2020', 'dd-mm-yyyy'), 'Shutdown', 2146);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (41535, 'Rheology Testing Machine', to_date('30-10-2018', 'dd-mm-yyyy'), 'Decommissioned', 28442);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (49370, 'Reaming Machine', to_date('08-05-2003', 'dd-mm-yyyy'), 'Testing', 82831);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (22217, 'Cutting Machine', to_date('26-01-2016', 'dd-mm-yyyy'), 'Testing', 97711);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (13117, 'Laser Welding Machine', to_date('06-09-2014', 'dd-mm-yyyy'), 'Testing', 57655);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (77566, 'Optical Testing Machine', to_date('03-11-2001', 'dd-mm-yyyy'), 'Under Maintenance', 93526);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (36139, 'Rheo-Dielectric Machine', to_date('11-11-2021', 'dd-mm-yyyy'), 'Under Maintenance', 11275);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (256, 'Router Table', to_date('02-10-2004', 'dd-mm-yyyy'), 'Calibration', 93709);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (18752, 'Destructive Testing Machine', to_date('08-10-2021', 'dd-mm-yyyy'), 'In Production', 83055);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (7938, 'Scratch Testing Machine', to_date('07-07-2020', 'dd-mm-yyyy'), 'Idle', 7862);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (44478, 'Tube Bender', to_date('23-01-2014', 'dd-mm-yyyy'), 'In Production', 86107);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (64679, 'Rheology Testing Machine', to_date('29-11-2003', 'dd-mm-yyyy'), 'Decommissioned', 12987);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (92396, 'EDM Machine', to_date('07-11-2011', 'dd-mm-yyyy'), 'Standby', 12987);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (93493, 'Environmental Testing Machine', to_date('07-03-2012', 'dd-mm-yyyy'), 'Shutdown', 89445);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (65761, 'Panel Bender', to_date('26-08-2009', 'dd-mm-yyyy'), 'Under Maintenance', 82497);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (88236, 'Thermal Cycling Testing Machine', to_date('08-04-2015', 'dd-mm-yyyy'), 'Standby', 48725);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (73581, 'Rotational Molding Machine', to_date('02-12-2002', 'dd-mm-yyyy'), 'Idle', 94731);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (70279, 'Mechanical Press', to_date('19-07-2023', 'dd-mm-yyyy'), 'Idle', 33097);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (73853, 'Cutting Machine', to_date('18-03-2009', 'dd-mm-yyyy'), 'In Production', 56096);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (49991, 'Wire EDM', to_date('08-02-2023', 'dd-mm-yyyy'), 'In Production', 2579);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (58302, 'Cut-off Saw', to_date('06-03-2012', 'dd-mm-yyyy'), 'Standby', 12463);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (26145, 'Fracture Testing Machine', to_date('06-05-2007', 'dd-mm-yyyy'), 'Decommissioned', 91289);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (35184, 'Boring and Milling Machine', to_date('27-08-2017', 'dd-mm-yyyy'), 'Shutdown', 10326);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (19394, 'Fatigue Crack Growth Testing Machine', to_date('27-09-2003', 'dd-mm-yyyy'), 'Standby', 46533);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (5036, 'Vibratory Finishing Machine', to_date('05-03-2017', 'dd-mm-yyyy'), 'In Production', 39841);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (70026, 'Threading Machine', to_date('04-01-2007', 'dd-mm-yyyy'), 'Shutdown', 25034);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (30644, 'Thread Rolling Machine', to_date('06-08-2004', 'dd-mm-yyyy'), 'Decommissioned', 63600);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (66632, 'Rheo-IR', to_date('24-07-2020', 'dd-mm-yyyy'), 'Malfunctioning', 9131);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (33056, 'Non-Destructive Testing Machine', to_date('29-08-2014', 'dd-mm-yyyy'), 'Shutdown', 56096);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (92343, 'Milling and Drilling Machine', to_date('23-01-2000', 'dd-mm-yyyy'), 'Standby', 43567);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (6481, 'Die Cutting Machine', to_date('21-09-2014', 'dd-mm-yyyy'), 'In Production', 16526);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (10178, 'Slitter Rewinder', to_date('22-05-2014', 'dd-mm-yyyy'), 'Idle', 20740);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (92711, 'Thermomechanical Analysis Machine', to_date('13-04-2007', 'dd-mm-yyyy'), 'Standby', 39212);
commit;
prompt 200 records committed...
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (39940, 'Thermoforming Machine', to_date('28-09-2020', 'dd-mm-yyyy'), 'In Production', 95954);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (96386, 'Tensile Testing Machine', to_date('02-05-2009', 'dd-mm-yyyy'), 'Calibration', 53925);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (37488, 'Bending Machine', to_date('13-08-2008', 'dd-mm-yyyy'), 'Idle', 97980);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (12372, 'Knurling Machine', to_date('27-03-2018', 'dd-mm-yyyy'), 'Calibration', 96193);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (54017, 'Compression Testing Machine', to_date('28-08-2012', 'dd-mm-yyyy'), 'Malfunctioning', 90514);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (81965, 'Laser Cutter', to_date('22-02-2010', 'dd-mm-yyyy'), 'Malfunctioning', 89445);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (59781, 'Carton Making Machine', to_date('01-12-2014', 'dd-mm-yyyy'), 'Operational', 56398);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (51713, 'Stamping Machine', to_date('02-01-2000', 'dd-mm-yyyy'), 'Calibration', 31660);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (44497, 'Bar Drawing Machine', to_date('25-11-2019', 'dd-mm-yyyy'), 'Under Maintenance', 1771);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (83771, 'Rod Rolling Machine', to_date('27-06-2018', 'dd-mm-yyyy'), 'Decommissioned', 57655);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (86840, 'Tempering Machine', to_date('02-01-2011', 'dd-mm-yyyy'), 'Decommissioned', 37925);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (16044, 'Annealing Machine', to_date('24-04-2013', 'dd-mm-yyyy'), 'Testing', 73902);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (99241, 'Cylindrical Grinder', to_date('23-05-2011', 'dd-mm-yyyy'), 'Shutdown', 54266);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (91, 'Laser Cutter', to_date('14-01-2005', 'dd-mm-yyyy'), 'Calibration', 20740);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (32762, 'Roll Forming Machine', to_date('11-03-2008', 'dd-mm-yyyy'), 'Calibration', 91260);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (11356, 'Vibratory Finishing Machine', to_date('28-05-2002', 'dd-mm-yyyy'), 'Standby', 63600);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (51577, 'Bead Blasting Machine', to_date('12-01-2007', 'dd-mm-yyyy'), 'Idle', 54539);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (35675, 'Cryogenic Treatment Machine', to_date('17-03-2007', 'dd-mm-yyyy'), 'Under Maintenance', 6242);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (88612, 'Assembly Machine', to_date('13-04-2016', 'dd-mm-yyyy'), 'Operational', 43332);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (44777, 'Stress Rupture Testing Machine', to_date('18-10-2010', 'dd-mm-yyyy'), 'Shutdown', 11275);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (54554, 'Thermal Conductivity Testing Machine', to_date('03-04-2004', 'dd-mm-yyyy'), 'Decommissioned', 12970);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (87596, 'Hydrogen Embrittlement Testing Machine', to_date('04-04-2017', 'dd-mm-yyyy'), 'Testing', 29862);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (22906, 'Coating Machine', to_date('20-06-2007', 'dd-mm-yyyy'), 'Shutdown', 73992);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (133, 'Vibratory Finishing Machine', to_date('08-08-2007', 'dd-mm-yyyy'), 'Decommissioned', 92681);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (35387, 'Coating Machine', to_date('31-08-2001', 'dd-mm-yyyy'), 'In Production', 34068);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (80426, 'Flexural Testing Machine', to_date('19-05-2022', 'dd-mm-yyyy'), 'Shutdown', 64789);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (95858, 'Pouch Making Machine', to_date('26-10-2010', 'dd-mm-yyyy'), 'In Production', 10128);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (43281, 'Rheo-IR', to_date('31-07-2012', 'dd-mm-yyyy'), 'Standby', 65564);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (28504, 'Optical Testing Machine', to_date('01-05-2014', 'dd-mm-yyyy'), 'In Production', 36842);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (67909, 'Flexural Testing Machine', to_date('04-10-2011', 'dd-mm-yyyy'), 'Operational', 66488);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (98346, 'Boring Mill', to_date('26-01-2019', 'dd-mm-yyyy'), 'Shutdown', 39841);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (36926, 'Horizontal Boring Mill', to_date('10-01-2014', 'dd-mm-yyyy'), 'Under Maintenance', 94765);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (10646, 'Stamping Press', to_date('22-05-2005', 'dd-mm-yyyy'), 'Operational', 80067);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (43335, 'Pouch Making Machine', to_date('09-10-2011', 'dd-mm-yyyy'), 'Shutdown', 24921);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (51508, 'Honing Machine', to_date('19-03-2019', 'dd-mm-yyyy'), 'Decommissioned', 40626);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (69597, 'Rod Drawing Machine', to_date('04-08-2019', 'dd-mm-yyyy'), 'Operational', 50741);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (86457, 'Boring and Milling Machine', to_date('06-08-2000', 'dd-mm-yyyy'), 'Testing', 19581);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (25788, 'Electron Beam Welding Machine', to_date('04-07-2000', 'dd-mm-yyyy'), 'Malfunctioning', 52749);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (27931, 'Hardness Testing Machine', to_date('14-08-2008', 'dd-mm-yyyy'), 'Decommissioned', 95954);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (28463, 'Bar Rolling Machine', to_date('19-03-2010', 'dd-mm-yyyy'), 'Calibration', 73902);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (98006, 'Differential Scanning Calorimetry Machine', to_date('31-05-2010', 'dd-mm-yyyy'), 'Decommissioned', 56398);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (14462, 'Wire Bender', to_date('25-08-2014', 'dd-mm-yyyy'), 'Decommissioned', 86698);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (80355, 'Thermal Expansion Testing Machine', to_date('07-04-2008', 'dd-mm-yyyy'), 'Under Maintenance', 15709);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (70692, 'Milling and Drilling Machine', to_date('08-04-2005', 'dd-mm-yyyy'), 'Under Maintenance', 76668);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (56655, 'Honing and Lapping Machine', to_date('10-04-2014', 'dd-mm-yyyy'), 'Malfunctioning', 91289);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (28226, 'Spline Rolling Machine', to_date('15-11-2023', 'dd-mm-yyyy'), 'Testing', 19051);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (88838, 'Tapping Machine', to_date('19-09-2018', 'dd-mm-yyyy'), 'Testing', 83682);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (73030, 'Thermal Fatigue Testing Machine', to_date('12-01-2021', 'dd-mm-yyyy'), 'In Production', 83055);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (20746, 'Tenoner', to_date('31-08-2003', 'dd-mm-yyyy'), 'Decommissioned', 92532);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (72642, 'Wire EDM', to_date('08-12-2017', 'dd-mm-yyyy'), 'Testing', 50506);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (62306, 'Press Brake', to_date('10-06-2014', 'dd-mm-yyyy'), 'Malfunctioning', 95253);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (64289, 'Bead Blasting Machine', to_date('13-08-2022', 'dd-mm-yyyy'), 'Shutdown', 12909);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (67513, 'Spline Rolling Machine', to_date('21-08-2014', 'dd-mm-yyyy'), 'Testing', 97073);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (1598, 'Bar Rolling Machine', to_date('01-07-2013', 'dd-mm-yyyy'), 'Shutdown', 56647);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (55446, 'Fatigue Crack Growth Testing Machine', to_date('27-02-2006', 'dd-mm-yyyy'), 'Decommissioned', 10134);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (70435, 'Turning and Milling Machine', to_date('27-06-2023', 'dd-mm-yyyy'), 'Decommissioned', 50741);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (32683, 'Bead Blasting Machine', to_date('11-05-2014', 'dd-mm-yyyy'), 'Malfunctioning', 39762);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (65764, 'Thermoforming Machine', to_date('09-11-2005', 'dd-mm-yyyy'), 'Operational', 94765);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (86863, 'Vibration Testing Machine', to_date('16-10-2014', 'dd-mm-yyyy'), 'Operational', 57655);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (26957, 'Router', to_date('10-09-2012', 'dd-mm-yyyy'), 'Operational', 24812);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (16178, 'Bar Drawing Machine', to_date('10-05-2016', 'dd-mm-yyyy'), 'Testing', 85591);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (65056, 'Edge Banding Machine', to_date('17-09-2016', 'dd-mm-yyyy'), 'Standby', 42678);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (69446, 'Peeling Machine', to_date('20-08-2022', 'dd-mm-yyyy'), 'Under Maintenance', 92466);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (38215, 'Boring Mill', to_date('14-12-2019', 'dd-mm-yyyy'), 'Idle', 7175);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (77370, 'Honing Machine', to_date('26-01-2013', 'dd-mm-yyyy'), 'Operational', 50539);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (47284, 'Lapping Machine', to_date('25-01-2011', 'dd-mm-yyyy'), 'In Production', 18723);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (88875, 'Assembly Machine', to_date('08-06-2021', 'dd-mm-yyyy'), 'Standby', 47566);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (88441, 'Facing Machine', to_date('24-08-2010', 'dd-mm-yyyy'), 'In Production', 43594);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (68335, 'Thermal Cycling Testing Machine', to_date('27-04-2016', 'dd-mm-yyyy'), 'Decommissioned', 50284);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (20182, 'Wire Drawing Machine', to_date('30-05-2014', 'dd-mm-yyyy'), 'Operational', 9131);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (91215, 'Cold Saw', to_date('06-12-2018', 'dd-mm-yyyy'), 'Decommissioned', 38812);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (34098, 'Microhardness Testing Machine', to_date('18-12-2004', 'dd-mm-yyyy'), 'Idle', 44364);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (78514, 'Resistance Welding Machine', to_date('03-05-2022', 'dd-mm-yyyy'), 'Standby', 92583);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (69006, 'Spline Cutting Machine', to_date('19-04-2023', 'dd-mm-yyyy'), 'Malfunctioning', 5701);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (65526, 'Plate Bender', to_date('05-07-2015', 'dd-mm-yyyy'), 'In Production', 91289);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (32258, 'Laser Welding Machine', to_date('17-03-2005', 'dd-mm-yyyy'), 'Decommissioned', 18144);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (89259, 'Milling and Drilling Machine', to_date('19-12-2011', 'dd-mm-yyyy'), 'Operational', 55930);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (96883, 'Rheo-IR', to_date('12-06-2004', 'dd-mm-yyyy'), 'Operational', 20351);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (32430, 'Finishing Machine', to_date('17-08-2016', 'dd-mm-yyyy'), 'Operational', 52036);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (84717, 'Tapping Machine', to_date('20-06-2017', 'dd-mm-yyyy'), 'Operational', 17295);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (61660, 'Rheo-SAXS', to_date('11-09-2006', 'dd-mm-yyyy'), 'Testing', 21508);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (30105, 'Thermal Shock Testing Machine', to_date('30-06-2019', 'dd-mm-yyyy'), 'Decommissioned', 67386);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (74575, 'Thermogravimetric Analysis Machine', to_date('06-08-2008', 'dd-mm-yyyy'), 'In Production', 5975);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (2520, 'Quenching Machine', to_date('24-09-2003', 'dd-mm-yyyy'), 'In Production', 17295);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (6123, 'Capillary Rheometer', to_date('03-02-2015', 'dd-mm-yyyy'), 'Standby', 85591);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (55544, 'Roll Forming Machine', to_date('09-07-2014', 'dd-mm-yyyy'), 'Testing', 10326);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (69931, 'Swiss Machine', to_date('29-04-2023', 'dd-mm-yyyy'), 'Standby', 82301);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (20568, 'Wire EDM', to_date('04-08-2014', 'dd-mm-yyyy'), 'In Production', 49763);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (7118, 'Rotational Molding Machine', to_date('20-04-2022', 'dd-mm-yyyy'), 'Under Maintenance', 46014);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (82396, 'Tensile Testing Machine', to_date('19-06-2019', 'dd-mm-yyyy'), 'Shutdown', 45675);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (13853, 'Horizontal Boring Mill', to_date('19-09-2015', 'dd-mm-yyyy'), 'Malfunctioning', 80067);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (17031, 'Thermogravimetric Analysis Machine', to_date('06-09-2014', 'dd-mm-yyyy'), 'In Production', 78499);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (1546, 'Powder Coating Machine', to_date('20-03-2013', 'dd-mm-yyyy'), 'Standby', 96193);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (45419, 'Punching Machine', to_date('29-07-2020', 'dd-mm-yyyy'), 'Standby', 79288);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (40848, 'Friction Stir Welding Machine', to_date('23-04-2003', 'dd-mm-yyyy'), 'Calibration', 88463);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (17219, 'Deburring Machine', to_date('28-11-2022', 'dd-mm-yyyy'), 'Operational', 30877);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (34146, 'Router Table', to_date('24-12-2001', 'dd-mm-yyyy'), 'In Production', 21081);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (91862, 'Router', to_date('03-01-2023', 'dd-mm-yyyy'), 'Idle', 56647);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (82000, 'Melt Flow Indexer', to_date('01-10-2011', 'dd-mm-yyyy'), 'Decommissioned', 19051);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (86618, 'Surface Grinder', to_date('06-09-2019', 'dd-mm-yyyy'), 'Operational', 96967);
commit;
prompt 300 records committed...
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (38405, 'Wire Saw', to_date('18-05-2022', 'dd-mm-yyyy'), 'Decommissioned', 36842);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (19286, '3D Printer', to_date('06-09-2010', 'dd-mm-yyyy'), 'Malfunctioning', 54621);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (18960, 'Electrical Testing Machine', to_date('16-10-2023', 'dd-mm-yyyy'), 'Shutdown', 58954);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (42776, 'Thermal Fatigue Testing Machine', to_date('17-03-2015', 'dd-mm-yyyy'), 'Idle', 37925);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (16379, 'Stress Rupture Testing Machine', to_date('27-10-2015', 'dd-mm-yyyy'), 'Standby', 44094);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (56427, 'Anodizing Machine', to_date('24-07-2020', 'dd-mm-yyyy'), 'Testing', 7001);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (20464, 'Thermal Expansion Testing Machine', to_date('26-05-2015', 'dd-mm-yyyy'), 'Idle', 28442);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (40718, 'Anodizing Machine', to_date('02-01-2007', 'dd-mm-yyyy'), 'Decommissioned', 41073);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (15888, 'Impact Testing Machine', to_date('24-06-2015', 'dd-mm-yyyy'), 'In Production', 65511);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (4343, 'Induction Hardening Machine', to_date('08-06-2002', 'dd-mm-yyyy'), 'Shutdown', 328);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (72312, 'Tensile Testing Machine', to_date('03-08-2000', 'dd-mm-yyyy'), 'Standby', 27973);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (11591, 'Friction Stir Welding Machine', to_date('01-10-2016', 'dd-mm-yyyy'), 'Calibration', 59132);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (28507, 'Punch Press', to_date('30-03-2023', 'dd-mm-yyyy'), 'Idle', 64789);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (79974, 'High Cycle Fatigue Testing Machine', to_date('09-05-2005', 'dd-mm-yyyy'), 'Idle', 62113);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (36735, 'Lathe', to_date('25-08-2012', 'dd-mm-yyyy'), 'Under Maintenance', 96967);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (59211, 'Leveling Machine', to_date('06-08-2018', 'dd-mm-yyyy'), 'Operational', 17212);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (56796, 'Surface Grinder', to_date('07-02-2014', 'dd-mm-yyyy'), 'Calibration', 29009);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (29355, 'Stress Rupture Testing Machine', to_date('03-11-2013', 'dd-mm-yyyy'), 'Shutdown', 96193);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (2093, 'Hydraulic Press', to_date('04-05-2003', 'dd-mm-yyyy'), 'Under Maintenance', 62113);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (44221, 'Tube Bender', to_date('19-01-2009', 'dd-mm-yyyy'), 'In Production', 93326);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (24206, 'Finishing Machine', to_date('01-08-2004', 'dd-mm-yyyy'), 'In Production', 48563);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (2627, 'Acoustic Testing Machine', to_date('05-01-2011', 'dd-mm-yyyy'), 'Malfunctioning', 51850);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (8845, 'Buffing Machine', to_date('17-09-2007', 'dd-mm-yyyy'), 'Malfunctioning', 38075);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (10513, 'Dynamic Mechanical Analysis Machine', to_date('06-08-2018', 'dd-mm-yyyy'), 'Operational', 99970);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (26098, 'Rotational Rheometer', to_date('09-11-2007', 'dd-mm-yyyy'), 'Shutdown', 57954);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (8058, 'Resistance Welding Machine', to_date('15-09-2011', 'dd-mm-yyyy'), 'Operational', 39841);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (62735, 'Viscometer', to_date('10-03-2016', 'dd-mm-yyyy'), 'Operational', 38144);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (33644, 'Threading Machine', to_date('15-02-2015', 'dd-mm-yyyy'), 'Testing', 27897);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (45315, 'Knurling Machine', to_date('02-03-2016', 'dd-mm-yyyy'), 'Shutdown', 72823);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (87265, 'Subtractive Manufacturing Machine', to_date('29-09-2006', 'dd-mm-yyyy'), 'Standby', 52149);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (71103, 'Friction Stir Welding Machine', to_date('25-06-2009', 'dd-mm-yyyy'), 'Under Maintenance', 56805);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (95901, 'Flow Testing Machine', to_date('05-05-2015', 'dd-mm-yyyy'), 'Testing', 25034);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (80738, 'High Cycle Fatigue Testing Machine', to_date('08-03-2013', 'dd-mm-yyyy'), 'Shutdown', 86107);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (78799, 'Subtractive Manufacturing Machine', to_date('11-07-2005', 'dd-mm-yyyy'), 'Decommissioned', 43567);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (63298, 'Brazing Machine', to_date('08-01-2018', 'dd-mm-yyyy'), 'Standby', 91813);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (17717, 'Hardening Machine', to_date('06-04-2006', 'dd-mm-yyyy'), 'In Production', 18087);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (62272, 'Edge Rounding Machine', to_date('23-11-2000', 'dd-mm-yyyy'), 'Testing', 19581);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (62307, 'Corrosion Testing Machine', to_date('11-12-2009', 'dd-mm-yyyy'), 'Operational', 30727);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (81094, 'Leak Testing Machine', to_date('29-06-2001', 'dd-mm-yyyy'), 'Standby', 34769);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (114, 'Pipe Drawing Machine', to_date('23-11-2004', 'dd-mm-yyyy'), 'Malfunctioning', 12987);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (50690, 'Strain Testing Machine', to_date('14-09-2007', 'dd-mm-yyyy'), 'Decommissioned', 15006);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (443, 'Turning and Milling Machine', to_date('21-11-2022', 'dd-mm-yyyy'), 'Calibration', 59464);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (50077, 'Alignment Machine', to_date('18-02-2022', 'dd-mm-yyyy'), 'Malfunctioning', 60500);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (57885, 'Roll Forming Machine', to_date('19-04-2014', 'dd-mm-yyyy'), 'Operational', 96967);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (45787, 'Foam Cutting Machine', to_date('22-04-2002', 'dd-mm-yyyy'), 'Malfunctioning', 75374);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (20724, 'Anodizing Machine', to_date('09-05-2008', 'dd-mm-yyyy'), 'Under Maintenance', 28442);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (67915, 'Welding Machine', to_date('14-05-2015', 'dd-mm-yyyy'), 'Operational', 73773);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (48171, 'Mechanical Press', to_date('21-01-2000', 'dd-mm-yyyy'), 'Testing', 91260);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (51259, 'Spindle Moulder', to_date('11-01-2004', 'dd-mm-yyyy'), 'Calibration', 12428);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (4513, 'Circular Saw', to_date('08-05-2014', 'dd-mm-yyyy'), 'In Production', 90514);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (70471, 'Cylindrical Grinder', to_date('16-06-2003', 'dd-mm-yyyy'), 'Under Maintenance', 96381);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (24145, 'Panel Bender', to_date('17-05-2017', 'dd-mm-yyyy'), 'Standby', 59730);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (69774, 'Grit Blasting Machine', to_date('05-03-2014', 'dd-mm-yyyy'), 'Under Maintenance', 36048);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (75318, 'Hardness Testing Machine', to_date('11-09-2003', 'dd-mm-yyyy'), 'Calibration', 252);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (61673, 'Thermoforming Machine', to_date('06-10-2019', 'dd-mm-yyyy'), 'Decommissioned', 27539);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (68473, 'Cut-off Saw', to_date('13-11-2000', 'dd-mm-yyyy'), 'Under Maintenance', 16526);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (26640, 'Extrusion Machine', to_date('08-02-2023', 'dd-mm-yyyy'), 'Shutdown', 16900);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (3596, 'Knurling Machine', to_date('01-11-2023', 'dd-mm-yyyy'), 'Calibration', 14541);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (18102, 'Pipe Making Machine', to_date('01-04-2001', 'dd-mm-yyyy'), 'Testing', 67386);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (86257, 'Microhardness Testing Machine', to_date('14-03-2007', 'dd-mm-yyyy'), 'Testing', 79379);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (45533, 'Edge Rounding Machine', to_date('29-07-2017', 'dd-mm-yyyy'), 'Operational', 98869);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (70246, 'Hardness Testing Machine', to_date('24-10-2008', 'dd-mm-yyyy'), 'Calibration', 27470);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (4221, 'Tumbling Machine', to_date('04-11-2008', 'dd-mm-yyyy'), 'Idle', 20025);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (62130, 'Punch Press', to_date('27-08-2002', 'dd-mm-yyyy'), 'Idle', 21508);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (24717, 'Lapping Machine', to_date('13-01-2015', 'dd-mm-yyyy'), 'Operational', 3188);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (55987, 'Abrasion Testing Machine', to_date('08-07-2000', 'dd-mm-yyyy'), 'Shutdown', 15006);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (59181, 'Sheet Metal Bender', to_date('23-04-2013', 'dd-mm-yyyy'), 'Decommissioned', 30686);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (11204, 'Blow Molding Machine', to_date('28-10-2021', 'dd-mm-yyyy'), 'Standby', 16900);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (87176, 'Thermomechanical Analysis Machine', to_date('18-06-2013', 'dd-mm-yyyy'), 'Calibration', 50284);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (48793, 'Thermal Shock Testing Machine', to_date('26-04-2022', 'dd-mm-yyyy'), 'Idle', 64789);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (41155, 'Fatigue Testing Machine', to_date('21-03-2002', 'dd-mm-yyyy'), 'Testing', 45967);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (78548, 'Burst Testing Machine', to_date('03-07-2017', 'dd-mm-yyyy'), 'Standby', 55126);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (3126, 'Electrical Testing Machine', to_date('26-05-2015', 'dd-mm-yyyy'), 'Decommissioned', 68567);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (86589, 'Heat Treating Machine', to_date('23-03-2020', 'dd-mm-yyyy'), 'Idle', 19998);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (40124, 'Tenoner', to_date('02-09-2017', 'dd-mm-yyyy'), 'Standby', 97073);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (66899, 'Rheo-Spectroscopy Machine', to_date('25-11-2023', 'dd-mm-yyyy'), 'Shutdown', 50757);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (8311, 'Carton Making Machine', to_date('04-10-2002', 'dd-mm-yyyy'), 'Standby', 63600);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (77391, 'Hardness Testing Machine', to_date('19-09-2004', 'dd-mm-yyyy'), 'Decommissioned', 63651);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (95056, 'Thermal Testing Machine', to_date('24-05-2004', 'dd-mm-yyyy'), 'Calibration', 18971);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (97267, 'Table Saw', to_date('26-04-2013', 'dd-mm-yyyy'), 'Testing', 1187);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (66551, 'Non-Destructive Testing Machine', to_date('04-02-2009', 'dd-mm-yyyy'), 'Malfunctioning', 33097);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (64062, 'Leak Testing Machine', to_date('25-04-2004', 'dd-mm-yyyy'), 'Calibration', 39841);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (76423, 'Counterboring Machine', to_date('22-10-2001', 'dd-mm-yyyy'), 'Calibration', 82946);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (32155, 'Rheo-Spectroscopy Machine', to_date('11-06-2008', 'dd-mm-yyyy'), 'Calibration', 78649);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (49964, 'Creep Testing Machine', to_date('01-12-2009', 'dd-mm-yyyy'), 'Testing', 278);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (25900, 'Reaming Machine', to_date('27-01-2000', 'dd-mm-yyyy'), 'Shutdown', 45155);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (19980, 'Plate Bender', to_date('27-09-2019', 'dd-mm-yyyy'), 'Malfunctioning', 78499);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (16048, 'Punching Machine', to_date('23-04-2010', 'dd-mm-yyyy'), 'In Production', 85184);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (35287, 'Tenoner', to_date('30-08-2005', 'dd-mm-yyyy'), 'Under Maintenance', 98902);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (34218, 'Hardness Testing Machine', to_date('29-01-2016', 'dd-mm-yyyy'), 'Operational', 18144);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (22758, 'Vacuum Testing Machine', to_date('04-05-2023', 'dd-mm-yyyy'), 'Under Maintenance', 4823);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (12888, 'Noise Testing Machine', to_date('12-02-2004', 'dd-mm-yyyy'), 'Standby', 76622);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (39769, 'Pipe Making Machine', to_date('04-01-2006', 'dd-mm-yyyy'), 'Malfunctioning', 65511);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (4125, 'Panel Bender', to_date('14-02-2019', 'dd-mm-yyyy'), 'Idle', 10128);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (37199, 'Creep Testing Machine', to_date('02-12-2002', 'dd-mm-yyyy'), 'In Production', 73902);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (45202, 'Bar Rolling Machine', to_date('06-01-2023', 'dd-mm-yyyy'), 'Malfunctioning', 82497);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (45036, 'Sheet Metal Bender', to_date('05-02-2014', 'dd-mm-yyyy'), 'Shutdown', 33103);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (9674, 'Cut-off Saw', to_date('14-08-2006', 'dd-mm-yyyy'), 'Testing', 91605);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (24369, 'Heat Treating Machine', to_date('24-03-2014', 'dd-mm-yyyy'), 'Decommissioned', 25034);
insert into MACHINES (machine_id, machine_name, installation_date, status, maintenance_id)
values (64580, 'Physical Testing Machine', to_date('19-12-2015', 'dd-mm-yyyy'), 'Operational', 18723);
commit;
prompt 400 records loaded
prompt Loading TOOLS...
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (99420, 'Out of Service', to_date('02-08-2003', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (78747, 'In Use', to_date('17-06-2014', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (76762, 'Available', to_date('24-07-2011', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (81538, 'Available', to_date('09-02-2011', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (26882, 'Available', to_date('30-08-2001', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (676, 'In Repair', to_date('11-03-2003', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (34574, 'Under Maintenance', to_date('15-03-2014', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (35973, 'Reserved', to_date('14-08-2020', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (48215, 'Discarded', to_date('19-12-2005', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (49944, 'Available', to_date('08-07-2004', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (29566, 'Under Maintenance', to_date('20-01-2005', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (95736, 'Reserved', to_date('18-10-2022', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9829, 'Under Maintenance', to_date('16-03-2015', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (51307, 'Discarded', to_date('23-03-2019', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (51949, 'Reserved', to_date('13-08-2005', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (59853, 'Reserved', to_date('06-01-2008', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (19170, 'Out of Service', to_date('17-04-2010', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (76491, 'Under Maintenance', to_date('29-11-2017', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (49840, 'Under Maintenance', to_date('07-11-2000', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (21190, 'Out of Service', to_date('30-09-2001', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (38466, 'In Repair', to_date('12-11-2012', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (37946, 'In Use', to_date('15-07-2023', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (23018, 'Discarded', to_date('06-09-2021', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (60216, 'In Use', to_date('17-01-2003', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (78483, 'Under Maintenance', to_date('05-10-2023', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (82594, 'Discarded', to_date('17-11-2001', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (16673, 'Under Maintenance', to_date('28-06-2011', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (38746, 'In Repair', to_date('18-01-2019', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (92272, 'Reserved', to_date('12-07-2009', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (85581, 'Reserved', to_date('22-01-2016', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (15153, 'Reserved', to_date('14-08-2004', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93691, 'Discarded', to_date('24-06-2003', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (68918, 'Reserved', to_date('06-12-2008', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (44023, 'Out of Service', to_date('11-01-2021', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (35717, 'Out of Service', to_date('17-11-2016', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (30813, 'Reserved', to_date('25-02-2011', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27291, 'In Repair', to_date('13-06-2023', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (70761, 'Available', to_date('01-02-2018', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (22285, 'Under Maintenance', to_date('12-01-2008', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (18469, 'Discarded', to_date('18-06-2016', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9797, 'Out of Service', to_date('03-10-2003', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (88109, 'In Use', to_date('11-05-2017', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (39186, 'Available', to_date('21-04-2012', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (81364, 'Reserved', to_date('23-11-2019', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (76126, 'Reserved', to_date('02-04-2004', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (21601, 'In Use', to_date('21-04-2000', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (64910, 'Under Maintenance', to_date('20-11-2004', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (94302, 'In Repair', to_date('08-07-2010', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (97005, 'Out of Service', to_date('18-07-2001', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93745, 'Available', to_date('25-03-2002', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (85857, 'Reserved', to_date('05-06-2008', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (75934, 'In Repair', to_date('26-06-2000', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (47946, 'Reserved', to_date('12-12-2000', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (17774, 'Out of Service', to_date('05-10-2002', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (90087, 'In Repair', to_date('16-07-2007', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (82507, 'Out of Service', to_date('16-07-2011', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (2994, 'Available', to_date('28-12-2022', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (91389, 'Out of Service', to_date('17-05-2008', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (61071, 'In Repair', to_date('15-04-2007', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (1620, 'Discarded', to_date('03-07-2013', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (28480, 'Under Maintenance', to_date('30-11-2017', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (90519, 'Reserved', to_date('18-11-2014', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (71437, 'Reserved', to_date('15-09-2019', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (45964, 'In Use', to_date('17-10-2006', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (76772, 'Out of Service', to_date('01-03-2020', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (63061, 'Out of Service', to_date('02-12-2017', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (76728, 'Reserved', to_date('16-04-2002', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (47081, 'In Use', to_date('28-11-2008', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (80021, 'Available', to_date('27-11-2014', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (22636, 'Available', to_date('21-06-2023', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9143, 'In Repair', to_date('28-06-2012', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (49111, 'Out of Service', to_date('06-12-2016', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (43914, 'Discarded', to_date('04-07-2020', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (42340, 'Reserved', to_date('06-05-2010', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (71292, 'Discarded', to_date('24-03-2002', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (2540, 'Out of Service', to_date('13-01-2018', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (41424, 'Available', to_date('20-01-2003', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (48488, 'In Use', to_date('12-09-2012', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (29949, 'Out of Service', to_date('14-05-2020', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (57952, 'In Use', to_date('22-12-2023', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (6557, 'Under Maintenance', to_date('02-11-2006', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (14371, 'Under Maintenance', to_date('09-07-2010', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9792, 'Available', to_date('03-04-2007', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (59781, 'Discarded', to_date('04-08-2009', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (28106, 'In Repair', to_date('10-11-2020', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (54000, 'Available', to_date('15-02-2012', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (87163, 'In Repair', to_date('07-03-2021', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (40055, 'Under Maintenance', to_date('25-04-2019', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (43399, 'In Use', to_date('06-05-2013', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (15861, 'In Repair', to_date('04-09-2016', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (83815, 'Discarded', to_date('28-11-2008', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (12152, 'In Repair', to_date('28-08-2009', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (32048, 'Available', to_date('18-03-2014', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (76660, 'Reserved', to_date('02-09-2000', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (60659, 'Available', to_date('28-02-2008', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (64546, 'Discarded', to_date('21-09-2003', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9701, 'In Use', to_date('06-08-2005', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (35078, 'Under Maintenance', to_date('09-06-2000', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (11515, 'Available', to_date('09-02-2014', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (54561, 'Available', to_date('09-09-2005', 'dd-mm-yyyy'), 'Available');
commit;
prompt 100 records committed...
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (21791, 'Reserved', to_date('09-05-2004', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (5518, 'Under Maintenance', to_date('23-08-2002', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (56866, 'Under Maintenance', to_date('24-11-2013', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (2118, 'In Repair', to_date('05-05-2011', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (37286, 'Available', to_date('15-07-2000', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (11855, 'Out of Service', to_date('16-10-2002', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (37605, 'In Repair', to_date('17-02-2021', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (83482, 'Under Maintenance', to_date('12-07-2018', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (42441, 'In Use', to_date('03-12-2015', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (81187, 'Reserved', to_date('19-09-2015', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8783, 'In Use', to_date('16-05-2014', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (25022, 'Under Maintenance', to_date('12-09-2013', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (34543, 'Under Maintenance', to_date('26-06-2018', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (37585, 'In Use', to_date('04-02-2014', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (33362, 'In Repair', to_date('23-08-2019', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (96949, 'Reserved', to_date('18-05-2006', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (15665, 'Discarded', to_date('02-12-2004', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (95842, 'Under Maintenance', to_date('09-12-2010', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (75965, 'Under Maintenance', to_date('04-12-2000', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (7076, 'In Repair', to_date('07-09-2015', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (86417, 'Discarded', to_date('17-02-2011', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (55225, 'Discarded', to_date('04-02-2022', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (96625, 'Out of Service', to_date('04-09-2014', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (94559, 'Discarded', to_date('26-10-2008', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (39694, 'Out of Service', to_date('23-09-2002', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93222, 'Discarded', to_date('28-09-2004', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (44535, 'Out of Service', to_date('16-04-2004', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (23658, 'Under Maintenance', to_date('27-07-2007', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (54423, 'Out of Service', to_date('16-07-2005', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (59294, 'Available', to_date('26-11-2011', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (51797, 'Discarded', to_date('23-08-2002', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (77473, 'Available', to_date('23-10-2002', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (89318, 'Out of Service', to_date('06-02-2020', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (68626, 'Discarded', to_date('04-12-2010', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27175, 'Available', to_date('24-07-2022', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (51708, 'Under Maintenance', to_date('01-01-2013', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (76631, 'Discarded', to_date('27-02-2008', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (95873, 'Reserved', to_date('02-01-2014', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (49841, 'Available', to_date('02-05-2019', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (48411, 'In Repair', to_date('08-09-2022', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (15896, 'Out of Service', to_date('03-03-2023', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (68917, 'Out of Service', to_date('31-08-2016', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (63130, 'Reserved', to_date('17-03-2021', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (69730, 'Available', to_date('31-12-2016', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (67681, 'In Repair', to_date('19-10-2004', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (62608, 'Discarded', to_date('09-04-2008', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (68285, 'Under Maintenance', to_date('26-11-2019', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (11659, 'Under Maintenance', to_date('27-02-2016', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (47342, 'Out of Service', to_date('08-06-2005', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (92520, 'Out of Service', to_date('08-07-2006', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (18210, 'Discarded', to_date('01-02-2005', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (57790, 'Under Maintenance', to_date('17-12-2013', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (18769, 'Out of Service', to_date('29-08-2008', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8703, 'In Repair', to_date('09-12-2019', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (11219, 'In Repair', to_date('22-11-2022', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (73063, 'Under Maintenance', to_date('20-04-2012', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (88137, 'In Repair', to_date('12-10-2011', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (89424, 'Reserved', to_date('27-05-2010', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (84784, 'Discarded', to_date('01-06-2018', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (97516, 'Discarded', to_date('27-08-2007', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (97656, 'Under Maintenance', to_date('21-04-2012', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (34928, 'Out of Service', to_date('14-08-2023', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9293, 'Discarded', to_date('18-03-2014', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (40035, 'In Use', to_date('31-07-2001', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (19324, 'Under Maintenance', to_date('17-06-2018', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (61179, 'Discarded', to_date('17-08-2007', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (81786, 'Discarded', to_date('17-10-2000', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (72100, 'Discarded', to_date('24-03-2011', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (48669, 'In Use', to_date('05-09-2011', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93615, 'Discarded', to_date('21-04-2015', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (19721, 'In Use', to_date('22-02-2019', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (21545, 'In Use', to_date('29-10-2007', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (98507, 'Out of Service', to_date('07-02-2005', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (60897, 'In Repair', to_date('12-11-2022', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (12627, 'In Use', to_date('19-11-2020', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (30085, 'In Repair', to_date('02-08-2000', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (33510, 'In Use', to_date('17-06-2004', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (26282, 'Out of Service', to_date('09-05-2006', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (28128, 'Available', to_date('30-03-2016', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (59855, 'Reserved', to_date('19-09-2002', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93253, 'In Use', to_date('03-03-2006', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (75618, 'Reserved', to_date('21-12-2019', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (66416, 'Discarded', to_date('17-06-2003', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27172, 'In Use', to_date('01-04-2022', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (75512, 'Under Maintenance', to_date('09-07-2005', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (39314, 'Available', to_date('16-11-2007', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (71881, 'Under Maintenance', to_date('02-06-2021', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (14097, 'In Use', to_date('05-09-2021', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (14486, 'Reserved', to_date('19-12-2000', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (43127, 'Discarded', to_date('03-11-2012', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (60342, 'Out of Service', to_date('15-04-2017', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (26123, 'Reserved', to_date('17-03-2018', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (61198, 'In Use', to_date('26-11-2006', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (95719, 'In Use', to_date('13-02-2023', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (66465, 'Under Maintenance', to_date('24-04-2003', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (48525, 'Discarded', to_date('30-09-2003', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (32396, 'In Use', to_date('22-01-2000', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (82420, 'Reserved', to_date('28-11-2006', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (37514, 'Under Maintenance', to_date('29-04-2019', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (40117, 'Out of Service', to_date('31-05-2003', 'dd-mm-yyyy'), 'Under Maintenance');
commit;
prompt 200 records committed...
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (4298, 'Under Maintenance', to_date('31-12-2001', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (58963, 'In Repair', to_date('16-11-2018', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27102, 'Available', to_date('02-04-2023', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (26995, 'In Use', to_date('17-01-2014', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (6345, 'In Repair', to_date('15-08-2017', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (45244, 'In Repair', to_date('23-08-2018', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (88935, 'Out of Service', to_date('05-08-2021', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (96291, 'In Repair', to_date('07-09-2014', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (14953, 'Discarded', to_date('01-09-2021', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (19071, 'Reserved', to_date('20-04-2001', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (70574, 'In Repair', to_date('13-12-2007', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (89923, 'Reserved', to_date('30-01-2001', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (47259, 'Under Maintenance', to_date('18-03-2017', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9908, 'Reserved', to_date('23-11-2007', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (7173, 'In Repair', to_date('28-06-2021', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (98344, 'In Use', to_date('17-03-2020', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (54711, 'Under Maintenance', to_date('13-03-2003', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (66295, 'Under Maintenance', to_date('13-03-2023', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (92690, 'Under Maintenance', to_date('04-02-2006', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (88657, 'Discarded', to_date('10-05-2012', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8337, 'In Use', to_date('10-12-2001', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (89521, 'In Use', to_date('10-02-2005', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8767, 'Reserved', to_date('02-09-2005', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (52764, 'Under Maintenance', to_date('07-09-2015', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (52098, 'Available', to_date('30-06-2014', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (89389, 'Reserved', to_date('16-08-2006', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (66920, 'Reserved', to_date('24-06-2004', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (44663, 'Under Maintenance', to_date('24-07-2001', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (84660, 'Reserved', to_date('20-09-2007', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (62686, 'Out of Service', to_date('20-02-2008', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (33137, 'Under Maintenance', to_date('29-08-2001', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (58073, 'Reserved', to_date('25-01-2016', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (36368, 'In Repair', to_date('09-12-2003', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93882, 'Discarded', to_date('25-09-2008', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (20622, 'Out of Service', to_date('13-09-2012', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (65795, 'Out of Service', to_date('03-04-2012', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (26726, 'Under Maintenance', to_date('08-06-2008', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (92546, 'In Repair', to_date('27-01-2014', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (28618, 'In Repair', to_date('20-04-2017', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (12604, 'Available', to_date('07-01-2015', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (58151, 'Discarded', to_date('14-12-2019', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (87095, 'Discarded', to_date('26-11-2022', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (36151, 'Discarded', to_date('14-11-2017', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8995, 'Reserved', to_date('03-08-2011', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9718, 'Under Maintenance', to_date('10-03-2017', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (18544, 'Discarded', to_date('24-07-2013', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (95782, 'In Use', to_date('11-01-2002', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (24938, 'Under Maintenance', to_date('10-01-2010', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (30912, 'Available', to_date('26-04-2017', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (34253, 'Out of Service', to_date('20-06-2002', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27362, 'In Use', to_date('11-02-2001', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (83624, 'Under Maintenance', to_date('25-09-2001', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (35381, 'Reserved', to_date('16-06-2014', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (81681, 'In Repair', to_date('16-08-2006', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (11769, 'In Repair', to_date('01-09-2004', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (55219, 'Discarded', to_date('14-12-2019', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (94678, 'Discarded', to_date('13-03-2014', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (2137, 'In Use', to_date('16-02-2006', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (84672, 'Out of Service', to_date('11-12-2018', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (50610, 'Discarded', to_date('01-04-2006', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (32023, 'Discarded', to_date('01-02-2020', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (24524, 'Under Maintenance', to_date('28-08-2002', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (30274, 'Reserved', to_date('28-05-2005', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (33255, 'Available', to_date('31-10-2007', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (87822, 'Out of Service', to_date('24-02-2004', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (72239, 'Under Maintenance', to_date('17-07-2012', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (34808, 'Discarded', to_date('25-03-2020', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (61754, 'Available', to_date('23-09-2020', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (11540, 'In Use', to_date('29-11-2012', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (10122, 'In Repair', to_date('19-07-2005', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (61927, 'In Repair', to_date('06-03-2020', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (87498, 'Reserved', to_date('20-12-2013', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (23731, 'Available', to_date('17-02-2010', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (47642, 'Out of Service', to_date('25-07-2009', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9622, 'Discarded', to_date('30-04-2007', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (87087, 'Reserved', to_date('01-08-2011', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (94484, 'In Use', to_date('08-08-2016', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (10581, 'In Repair', to_date('11-07-2007', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8971, 'Out of Service', to_date('25-05-2008', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (2755, 'Out of Service', to_date('24-03-2023', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (39304, 'Out of Service', to_date('02-08-2013', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (6064, 'Out of Service', to_date('10-06-2014', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (33336, 'Under Maintenance', to_date('23-10-2015', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (4959, 'Available', to_date('25-11-2011', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (12850, 'Available', to_date('20-04-2001', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (16319, 'Out of Service', to_date('30-11-2015', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (92115, 'Discarded', to_date('16-03-2022', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (86129, 'Under Maintenance', to_date('06-06-2000', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (2694, 'Reserved', to_date('04-06-2009', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (92416, 'Available', to_date('18-08-2002', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (24492, 'Reserved', to_date('06-12-2006', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (54419, 'Available', to_date('26-12-2009', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (23068, 'Out of Service', to_date('08-08-2011', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (48027, 'In Use', to_date('10-11-2004', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93184, 'Available', to_date('19-07-2018', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27454, 'Available', to_date('27-07-2022', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8615, 'Discarded', to_date('08-12-2007', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (53170, 'In Repair', to_date('18-12-2006', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (78195, 'Reserved', to_date('27-04-2017', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (26082, 'Out of Service', to_date('08-07-2015', 'dd-mm-yyyy'), 'Available');
commit;
prompt 300 records committed...
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8136, 'Out of Service', to_date('26-06-2011', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27960, 'Reserved', to_date('19-11-2005', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (70564, 'Available', to_date('26-09-2005', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (68123, 'Discarded', to_date('02-01-2020', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (78342, 'Under Maintenance', to_date('10-10-2010', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (36361, 'Reserved', to_date('26-08-2021', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (66114, 'Reserved', to_date('26-12-2014', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (62121, 'Reserved', to_date('17-07-2011', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (77609, 'In Use', to_date('16-04-2004', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (79933, 'Reserved', to_date('19-11-2011', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (59204, 'Available', to_date('21-06-2019', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (1092, 'Out of Service', to_date('23-06-2016', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (59718, 'Under Maintenance', to_date('24-12-2010', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (91585, 'Available', to_date('12-04-2002', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (36478, 'Available', to_date('21-04-2019', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (56275, 'In Repair', to_date('28-06-2002', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (67612, 'Discarded', to_date('30-09-2008', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (29324, 'Out of Service', to_date('15-02-2001', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (70614, 'Discarded', to_date('23-10-2002', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (70880, 'Out of Service', to_date('06-02-2009', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27143, 'In Repair', to_date('18-12-2016', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (70003, 'Under Maintenance', to_date('19-10-2009', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (14078, 'Available', to_date('10-01-2005', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (53843, 'Discarded', to_date('01-03-2014', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (40825, 'In Use', to_date('16-12-2010', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (3075, 'Available', to_date('05-04-2009', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (92868, 'In Repair', to_date('15-03-2022', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (73570, 'Out of Service', to_date('13-05-2016', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (81581, 'In Repair', to_date('07-07-2004', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (24337, 'Reserved', to_date('20-07-2018', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (272, 'Discarded', to_date('17-04-2022', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (51690, 'Reserved', to_date('26-09-2021', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (86494, 'In Repair', to_date('22-05-2012', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (29687, 'Out of Service', to_date('20-04-2009', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (90604, 'Reserved', to_date('19-06-2003', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (56805, 'Discarded', to_date('19-02-2006', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (50559, 'Reserved', to_date('15-10-2012', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (8871, 'Discarded', to_date('26-03-2012', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (72974, 'Out of Service', to_date('06-08-2004', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (98239, 'Out of Service', to_date('06-10-2021', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (20429, 'In Repair', to_date('22-11-2005', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (39229, 'In Use', to_date('26-08-2007', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (5020, 'In Repair', to_date('14-10-2019', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (19792, 'Out of Service', to_date('27-08-2015', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (88166, 'In Use', to_date('29-04-2000', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (79451, 'Reserved', to_date('09-12-2007', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (86666, 'Discarded', to_date('29-10-2008', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93480, 'Under Maintenance', to_date('03-03-2008', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (84997, 'In Use', to_date('10-09-2023', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (63327, 'Discarded', to_date('28-01-2020', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (53875, 'Out of Service', to_date('27-09-2003', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (13299, 'Available', to_date('12-07-2007', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (75056, 'In Use', to_date('13-01-2013', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (93490, 'Out of Service', to_date('14-02-2008', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (72391, 'Out of Service', to_date('28-03-2023', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (88962, 'Discarded', to_date('04-04-2020', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (49135, 'Discarded', to_date('20-05-2017', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (35174, 'In Repair', to_date('21-09-2023', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (31496, 'Under Maintenance', to_date('05-04-2011', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (39659, 'Reserved', to_date('30-09-2013', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (18441, 'Out of Service', to_date('16-03-2016', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (9958, 'Under Maintenance', to_date('11-08-2000', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (37754, 'Available', to_date('14-06-2015', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (87798, 'In Repair', to_date('15-09-2022', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (15155, 'Reserved', to_date('13-01-2013', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (16040, 'In Repair', to_date('17-02-2020', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (59095, 'Out of Service', to_date('22-12-2005', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (75062, 'Reserved', to_date('27-03-2011', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (22438, 'Discarded', to_date('21-01-2022', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (54515, 'Reserved', to_date('18-04-2021', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (91201, 'Available', to_date('06-06-2020', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (81559, 'Reserved', to_date('24-10-2011', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (68013, 'Out of Service', to_date('22-11-2002', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (88146, 'Discarded', to_date('09-01-2012', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (75039, 'Available', to_date('18-06-2007', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (42074, 'Available', to_date('29-03-2017', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (63160, 'Out of Service', to_date('18-06-2019', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (84290, 'Discarded', to_date('10-09-2020', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (27404, 'In Repair', to_date('03-02-2016', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (72449, 'Discarded', to_date('30-10-2010', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (28627, 'Discarded', to_date('06-07-2000', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (30715, 'In Use', to_date('28-02-2006', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (21439, 'Out of Service', to_date('03-06-2001', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (5814, 'Reserved', to_date('06-08-2007', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (88387, 'In Use', to_date('19-02-2014', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (29345, 'In Repair', to_date('30-03-2012', 'dd-mm-yyyy'), 'In Use');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (80385, 'Reserved', to_date('26-02-2003', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (86330, 'In Use', to_date('09-10-2016', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (63389, 'Discarded', to_date('04-04-2014', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (90019, 'Out of Service', to_date('19-03-2010', 'dd-mm-yyyy'), 'Out of Service');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (71330, 'Discarded', to_date('25-01-2012', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (62947, 'In Use', to_date('20-04-2004', 'dd-mm-yyyy'), 'Under Maintenance');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (65297, 'In Use', to_date('19-02-2019', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (24236, 'Reserved', to_date('20-04-2005', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (98961, 'Under Maintenance', to_date('10-07-2004', 'dd-mm-yyyy'), 'In Repair');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (83150, 'Available', to_date('03-05-2023', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (90255, 'Under Maintenance', to_date('13-11-2001', 'dd-mm-yyyy'), 'Discarded');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (38902, 'In Repair', to_date('17-03-2023', 'dd-mm-yyyy'), 'Available');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (99310, 'Out of Service', to_date('22-12-2000', 'dd-mm-yyyy'), 'Reserved');
insert into TOOLS (tool_id, tool_name, manufacture_date, status)
values (86706, 'Reserved', to_date('26-09-2008', 'dd-mm-yyyy'), 'Reserved');
commit;
prompt 400 records loaded
prompt Loading PRODUCTION_ORDERS...
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (492514, 92546, 340, to_date('24-11-2009', 'dd-mm-yyyy'), to_date('24-11-2022', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (78998, 66416, 234, to_date('11-08-2000', 'dd-mm-yyyy'), to_date('25-01-2029', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (280873, 17774, 466, to_date('01-02-2006', 'dd-mm-yyyy'), to_date('03-07-2024', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (366443, 89389, 181, to_date('20-08-2008', 'dd-mm-yyyy'), to_date('04-10-2027', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (925056, 19324, 243, to_date('10-02-2011', 'dd-mm-yyyy'), to_date('19-02-2022', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (201650, 8971, 334, to_date('31-05-2000', 'dd-mm-yyyy'), to_date('23-11-2026', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (690158, 54000, 187, to_date('06-05-2005', 'dd-mm-yyyy'), to_date('23-10-2023', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (341870, 26726, 24, to_date('08-07-2016', 'dd-mm-yyyy'), to_date('13-09-2025', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (874680, 75039, 390, to_date('18-09-2000', 'dd-mm-yyyy'), to_date('13-05-2025', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (88171, 68285, 324, to_date('20-06-2009', 'dd-mm-yyyy'), to_date('27-08-2023', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (109906, 35381, 74, to_date('26-11-2012', 'dd-mm-yyyy'), to_date('14-06-2025', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (932951, 6557, 450, to_date('19-04-2016', 'dd-mm-yyyy'), to_date('09-12-2030', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (765722, 72449, 483, to_date('29-08-2019', 'dd-mm-yyyy'), to_date('21-04-2024', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (415474, 1620, 270, to_date('11-02-2011', 'dd-mm-yyyy'), to_date('26-12-2023', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (478517, 87798, 287, to_date('06-04-2004', 'dd-mm-yyyy'), to_date('02-10-2025', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (326029, 8995, 171, to_date('06-04-2009', 'dd-mm-yyyy'), to_date('25-10-2031', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (66764, 90087, 344, to_date('09-04-2008', 'dd-mm-yyyy'), to_date('26-08-2031', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (649351, 49111, 160, to_date('18-08-2019', 'dd-mm-yyyy'), to_date('28-10-2024', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (349933, 59294, 246, to_date('08-07-2002', 'dd-mm-yyyy'), to_date('14-08-2031', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (887926, 88137, 220, to_date('24-08-2006', 'dd-mm-yyyy'), to_date('26-03-2028', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (636344, 27404, 230, to_date('06-07-2010', 'dd-mm-yyyy'), to_date('13-10-2026', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (655801, 26882, 47, to_date('27-07-2008', 'dd-mm-yyyy'), to_date('15-04-2027', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (895589, 48669, 149, to_date('31-03-2003', 'dd-mm-yyyy'), to_date('17-12-2029', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (683526, 23731, 420, to_date('03-08-2003', 'dd-mm-yyyy'), to_date('31-12-2025', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (881156, 91201, 313, to_date('27-06-2009', 'dd-mm-yyyy'), to_date('27-05-2031', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (624858, 93490, 98, to_date('29-04-2000', 'dd-mm-yyyy'), to_date('22-12-2029', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (718866, 2994, 158, to_date('22-08-2010', 'dd-mm-yyyy'), to_date('28-01-2021', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (305847, 47259, 253, to_date('25-04-2014', 'dd-mm-yyyy'), to_date('14-08-2023', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (726756, 76491, 311, to_date('13-03-2014', 'dd-mm-yyyy'), to_date('14-02-2029', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (306922, 77473, 47, to_date('14-12-2016', 'dd-mm-yyyy'), to_date('01-10-2025', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (482042, 26282, 233, to_date('21-11-2004', 'dd-mm-yyyy'), to_date('08-12-2027', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (18624, 98961, 152, to_date('04-08-2008', 'dd-mm-yyyy'), to_date('02-07-2024', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (400761, 57790, 284, to_date('21-07-2017', 'dd-mm-yyyy'), to_date('30-12-2025', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (561583, 27362, 55, to_date('24-03-2012', 'dd-mm-yyyy'), to_date('30-11-2023', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (345748, 1620, 127, to_date('25-10-2000', 'dd-mm-yyyy'), to_date('08-06-2026', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (211386, 75965, 184, to_date('03-06-2009', 'dd-mm-yyyy'), to_date('26-08-2030', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (28553, 93490, 73, to_date('19-08-2005', 'dd-mm-yyyy'), to_date('17-12-2031', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (218951, 78195, 476, to_date('25-12-2004', 'dd-mm-yyyy'), to_date('02-11-2031', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (220921, 23018, 32, to_date('02-10-2017', 'dd-mm-yyyy'), to_date('27-07-2027', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (167032, 85857, 144, to_date('25-12-2011', 'dd-mm-yyyy'), to_date('01-10-2028', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (41485, 30274, 410, to_date('08-03-2018', 'dd-mm-yyyy'), to_date('30-03-2029', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (253485, 96625, 31, to_date('01-09-2013', 'dd-mm-yyyy'), to_date('18-01-2029', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (833255, 18769, 390, to_date('04-09-2000', 'dd-mm-yyyy'), to_date('15-07-2025', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (141913, 12627, 58, to_date('30-10-2003', 'dd-mm-yyyy'), to_date('11-09-2023', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (397582, 6557, 168, to_date('19-05-2000', 'dd-mm-yyyy'), to_date('13-09-2026', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (270320, 70761, 390, to_date('06-03-2012', 'dd-mm-yyyy'), to_date('18-09-2021', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (600158, 95842, 348, to_date('06-08-2012', 'dd-mm-yyyy'), to_date('25-10-2031', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (758404, 12627, 92, to_date('02-05-2006', 'dd-mm-yyyy'), to_date('24-07-2031', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (614744, 63389, 287, to_date('06-11-2005', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (304096, 59853, 150, to_date('01-12-2006', 'dd-mm-yyyy'), to_date('08-08-2023', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (320198, 88657, 383, to_date('08-03-2018', 'dd-mm-yyyy'), to_date('16-02-2030', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (709990, 48669, 361, to_date('20-05-2017', 'dd-mm-yyyy'), to_date('19-01-2021', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (616452, 88657, 333, to_date('24-11-2010', 'dd-mm-yyyy'), to_date('18-03-2029', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (930283, 90019, 234, to_date('11-02-2015', 'dd-mm-yyyy'), to_date('09-06-2029', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (675065, 92272, 73, to_date('24-08-2018', 'dd-mm-yyyy'), to_date('23-05-2028', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (778839, 9908, 152, to_date('30-04-2015', 'dd-mm-yyyy'), to_date('21-04-2023', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (389965, 24337, 235, to_date('20-01-2000', 'dd-mm-yyyy'), to_date('19-03-2029', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (689016, 48488, 184, to_date('29-05-2004', 'dd-mm-yyyy'), to_date('04-10-2024', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (544017, 39659, 29, to_date('16-11-2017', 'dd-mm-yyyy'), to_date('25-07-2031', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (165880, 83482, 49, to_date('03-03-2004', 'dd-mm-yyyy'), to_date('13-03-2025', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (457030, 15861, 166, to_date('15-10-2002', 'dd-mm-yyyy'), to_date('05-07-2025', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (821415, 51949, 369, to_date('29-08-2013', 'dd-mm-yyyy'), to_date('20-02-2021', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (130838, 63160, 479, to_date('28-10-2019', 'dd-mm-yyyy'), to_date('17-06-2023', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (133382, 54515, 466, to_date('07-01-2000', 'dd-mm-yyyy'), to_date('01-02-2031', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (157079, 48525, 82, to_date('24-07-2001', 'dd-mm-yyyy'), to_date('20-11-2022', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (318418, 76126, 89, to_date('06-01-2015', 'dd-mm-yyyy'), to_date('23-11-2028', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (903287, 42340, 13, to_date('16-02-2017', 'dd-mm-yyyy'), to_date('26-06-2023', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (960034, 11769, 81, to_date('08-10-2018', 'dd-mm-yyyy'), to_date('12-12-2028', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (742938, 92416, 419, to_date('18-01-2011', 'dd-mm-yyyy'), to_date('12-06-2027', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (999707, 29566, 391, to_date('11-01-2017', 'dd-mm-yyyy'), to_date('24-02-2026', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (15457, 93490, 255, to_date('10-06-2010', 'dd-mm-yyyy'), to_date('11-01-2021', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (977025, 92868, 153, to_date('01-01-2003', 'dd-mm-yyyy'), to_date('02-03-2027', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (456276, 83624, 488, to_date('22-01-2009', 'dd-mm-yyyy'), to_date('31-07-2027', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (848691, 70003, 218, to_date('09-07-2017', 'dd-mm-yyyy'), to_date('14-09-2024', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (665041, 61198, 394, to_date('11-10-2008', 'dd-mm-yyyy'), to_date('30-05-2024', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (981084, 19170, 316, to_date('08-12-2018', 'dd-mm-yyyy'), to_date('30-03-2029', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (532242, 30912, 13, to_date('22-02-2006', 'dd-mm-yyyy'), to_date('03-01-2028', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (616945, 50610, 228, to_date('16-10-2005', 'dd-mm-yyyy'), to_date('04-09-2023', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (313164, 97005, 325, to_date('15-05-2013', 'dd-mm-yyyy'), to_date('14-08-2031', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (830026, 37754, 33, to_date('20-03-2007', 'dd-mm-yyyy'), to_date('08-04-2028', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (922869, 12627, 247, to_date('16-07-2009', 'dd-mm-yyyy'), to_date('09-01-2023', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (508067, 87095, 210, to_date('02-02-2004', 'dd-mm-yyyy'), to_date('13-05-2030', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (736069, 91585, 448, to_date('05-01-2014', 'dd-mm-yyyy'), to_date('05-05-2030', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (129705, 53170, 155, to_date('02-02-2015', 'dd-mm-yyyy'), to_date('28-05-2026', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (782489, 9958, 98, to_date('16-08-2008', 'dd-mm-yyyy'), to_date('02-01-2027', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (350964, 22636, 333, to_date('30-08-2006', 'dd-mm-yyyy'), to_date('19-10-2030', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (478379, 87798, 331, to_date('09-03-2000', 'dd-mm-yyyy'), to_date('30-07-2024', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (666940, 81187, 354, to_date('22-12-2010', 'dd-mm-yyyy'), to_date('23-09-2029', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (284778, 2137, 279, to_date('26-11-2019', 'dd-mm-yyyy'), to_date('07-02-2025', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (664299, 89424, 449, to_date('30-11-2000', 'dd-mm-yyyy'), to_date('06-11-2025', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (933159, 34574, 209, to_date('27-03-2001', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (630226, 70880, 387, to_date('22-03-2016', 'dd-mm-yyyy'), to_date('25-07-2025', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (109089, 98344, 383, to_date('21-10-2002', 'dd-mm-yyyy'), to_date('30-09-2027', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (533446, 26882, 55, to_date('11-10-2019', 'dd-mm-yyyy'), to_date('08-04-2021', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (734507, 93615, 394, to_date('01-11-2007', 'dd-mm-yyyy'), to_date('30-09-2026', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (642933, 26726, 7, to_date('17-02-2008', 'dd-mm-yyyy'), to_date('02-10-2023', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (239281, 48488, 376, to_date('14-10-2016', 'dd-mm-yyyy'), to_date('28-07-2029', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (299946, 33510, 419, to_date('04-05-2005', 'dd-mm-yyyy'), to_date('10-09-2026', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (462625, 75056, 84, to_date('01-09-2014', 'dd-mm-yyyy'), to_date('20-03-2025', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (609007, 21545, 41, to_date('05-03-2014', 'dd-mm-yyyy'), to_date('12-11-2029', 'dd-mm-yyyy'), 'Canceled');
commit;
prompt 100 records committed...
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (75045, 84672, 482, to_date('17-08-2019', 'dd-mm-yyyy'), to_date('28-10-2026', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (63455, 26123, 338, to_date('25-09-2003', 'dd-mm-yyyy'), to_date('27-07-2030', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (661399, 39304, 89, to_date('17-05-2004', 'dd-mm-yyyy'), to_date('12-07-2029', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (371180, 27404, 111, to_date('21-07-2017', 'dd-mm-yyyy'), to_date('09-05-2027', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (855730, 35973, 484, to_date('04-01-2007', 'dd-mm-yyyy'), to_date('25-02-2027', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (996199, 79451, 87, to_date('11-04-2011', 'dd-mm-yyyy'), to_date('09-01-2028', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (168477, 272, 452, to_date('06-10-2012', 'dd-mm-yyyy'), to_date('03-01-2026', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (181664, 56866, 18, to_date('01-12-2013', 'dd-mm-yyyy'), to_date('12-08-2023', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (396680, 18441, 427, to_date('03-05-2013', 'dd-mm-yyyy'), to_date('22-11-2029', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (469934, 97516, 495, to_date('01-11-2011', 'dd-mm-yyyy'), to_date('26-08-2024', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (757846, 1092, 481, to_date('27-03-2015', 'dd-mm-yyyy'), to_date('26-01-2028', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (985362, 91201, 289, to_date('23-05-2019', 'dd-mm-yyyy'), to_date('11-01-2028', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (138049, 23068, 229, to_date('23-10-2013', 'dd-mm-yyyy'), to_date('28-09-2031', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (995385, 1092, 187, to_date('22-06-2005', 'dd-mm-yyyy'), to_date('08-04-2027', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (94917, 19324, 191, to_date('26-06-2014', 'dd-mm-yyyy'), to_date('19-05-2031', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (515569, 44663, 363, to_date('28-10-2009', 'dd-mm-yyyy'), to_date('06-12-2027', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (506139, 24938, 199, to_date('27-09-2007', 'dd-mm-yyyy'), to_date('21-11-2024', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (974214, 72449, 495, to_date('02-05-2008', 'dd-mm-yyyy'), to_date('01-08-2021', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (4092, 92520, 148, to_date('13-06-2009', 'dd-mm-yyyy'), to_date('17-06-2027', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (202171, 11219, 453, to_date('22-04-2011', 'dd-mm-yyyy'), to_date('19-06-2028', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (587226, 8783, 454, to_date('09-02-2003', 'dd-mm-yyyy'), to_date('07-08-2031', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (263462, 54711, 497, to_date('07-10-2003', 'dd-mm-yyyy'), to_date('25-10-2024', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (48848, 8995, 218, to_date('04-07-2005', 'dd-mm-yyyy'), to_date('17-09-2031', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (892354, 20429, 48, to_date('29-11-2001', 'dd-mm-yyyy'), to_date('22-06-2024', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (113887, 60659, 256, to_date('03-06-2002', 'dd-mm-yyyy'), to_date('12-03-2021', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (552506, 43399, 244, to_date('15-09-2004', 'dd-mm-yyyy'), to_date('03-04-2026', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (424318, 52764, 224, to_date('30-11-2005', 'dd-mm-yyyy'), to_date('27-11-2026', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (383804, 9797, 83, to_date('22-09-2004', 'dd-mm-yyyy'), to_date('19-03-2025', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (763826, 23018, 242, to_date('30-09-2009', 'dd-mm-yyyy'), to_date('09-07-2028', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (552517, 78483, 119, to_date('26-04-2007', 'dd-mm-yyyy'), to_date('24-09-2024', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (162364, 9792, 12, to_date('05-07-2004', 'dd-mm-yyyy'), to_date('02-02-2031', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (770409, 96625, 258, to_date('03-02-2012', 'dd-mm-yyyy'), to_date('09-02-2022', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (771207, 97516, 68, to_date('16-01-2019', 'dd-mm-yyyy'), to_date('28-10-2022', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (998405, 28618, 366, to_date('14-11-2015', 'dd-mm-yyyy'), to_date('25-01-2031', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (649156, 23658, 419, to_date('26-08-2019', 'dd-mm-yyyy'), to_date('07-12-2025', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (600466, 61754, 11, to_date('09-02-2001', 'dd-mm-yyyy'), to_date('15-05-2031', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (850480, 11219, 456, to_date('28-09-2003', 'dd-mm-yyyy'), to_date('19-01-2022', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (376533, 35078, 137, to_date('19-12-2000', 'dd-mm-yyyy'), to_date('16-07-2026', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (447804, 9701, 191, to_date('16-10-2019', 'dd-mm-yyyy'), to_date('07-08-2028', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (337511, 72239, 337, to_date('09-02-2019', 'dd-mm-yyyy'), to_date('28-09-2028', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (186219, 65795, 198, to_date('05-07-2005', 'dd-mm-yyyy'), to_date('07-01-2028', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (757417, 88657, 456, to_date('04-04-2007', 'dd-mm-yyyy'), to_date('26-12-2031', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (173189, 40035, 96, to_date('05-05-2003', 'dd-mm-yyyy'), to_date('18-04-2028', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (1288, 23731, 390, to_date('20-12-2018', 'dd-mm-yyyy'), to_date('09-03-2027', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (988530, 71330, 95, to_date('24-12-2008', 'dd-mm-yyyy'), to_date('24-01-2025', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (833695, 23018, 417, to_date('05-10-2009', 'dd-mm-yyyy'), to_date('28-11-2025', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (319871, 28128, 351, to_date('08-12-2016', 'dd-mm-yyyy'), to_date('20-07-2026', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (717021, 94302, 419, to_date('29-04-2003', 'dd-mm-yyyy'), to_date('29-11-2028', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (932920, 99420, 404, to_date('21-12-2009', 'dd-mm-yyyy'), to_date('19-12-2027', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (247052, 42441, 133, to_date('21-04-2014', 'dd-mm-yyyy'), to_date('16-09-2031', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (920066, 39314, 101, to_date('07-05-2004', 'dd-mm-yyyy'), to_date('17-05-2029', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (343480, 61198, 354, to_date('09-04-2018', 'dd-mm-yyyy'), to_date('08-12-2027', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (992917, 89923, 66, to_date('03-12-2004', 'dd-mm-yyyy'), to_date('27-08-2025', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (85898, 56275, 188, to_date('20-06-2015', 'dd-mm-yyyy'), to_date('01-08-2028', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (834417, 93745, 413, to_date('07-03-2009', 'dd-mm-yyyy'), to_date('03-01-2021', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (335927, 72391, 147, to_date('23-11-2019', 'dd-mm-yyyy'), to_date('05-12-2029', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (776144, 16319, 18, to_date('02-04-2004', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (536116, 90255, 447, to_date('09-04-2010', 'dd-mm-yyyy'), to_date('10-08-2030', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (316450, 34253, 323, to_date('27-12-2005', 'dd-mm-yyyy'), to_date('29-06-2027', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (326201, 49135, 18, to_date('20-06-2004', 'dd-mm-yyyy'), to_date('09-04-2025', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (245020, 73570, 190, to_date('17-02-2014', 'dd-mm-yyyy'), to_date('14-09-2029', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (867393, 7173, 382, to_date('23-12-2003', 'dd-mm-yyyy'), to_date('25-09-2025', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (389527, 21190, 56, to_date('04-09-2002', 'dd-mm-yyyy'), to_date('04-04-2024', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (15290, 32396, 114, to_date('27-11-2019', 'dd-mm-yyyy'), to_date('07-07-2031', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (249964, 19071, 173, to_date('21-06-2009', 'dd-mm-yyyy'), to_date('11-12-2028', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (732044, 30715, 316, to_date('08-03-2017', 'dd-mm-yyyy'), to_date('31-03-2028', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (36303, 24236, 389, to_date('10-02-2014', 'dd-mm-yyyy'), to_date('05-08-2028', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (378418, 82594, 73, to_date('07-06-2018', 'dd-mm-yyyy'), to_date('20-04-2029', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (875100, 72239, 45, to_date('14-03-2018', 'dd-mm-yyyy'), to_date('21-03-2023', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (776342, 77473, 54, to_date('14-02-2014', 'dd-mm-yyyy'), to_date('22-08-2024', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (200672, 27172, 177, to_date('12-01-2007', 'dd-mm-yyyy'), to_date('02-02-2025', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (182615, 24236, 493, to_date('23-07-2010', 'dd-mm-yyyy'), to_date('17-09-2022', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (596459, 68917, 345, to_date('06-10-2016', 'dd-mm-yyyy'), to_date('28-11-2026', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (564346, 87095, 440, to_date('01-04-2012', 'dd-mm-yyyy'), to_date('06-12-2021', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (602225, 32023, 35, to_date('25-02-2016', 'dd-mm-yyyy'), to_date('26-12-2031', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (816798, 89923, 305, to_date('04-04-2000', 'dd-mm-yyyy'), to_date('16-01-2026', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (252682, 61179, 206, to_date('16-11-2016', 'dd-mm-yyyy'), to_date('05-02-2031', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (814226, 68285, 302, to_date('17-01-2013', 'dd-mm-yyyy'), to_date('02-06-2022', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (363203, 78195, 172, to_date('26-07-2011', 'dd-mm-yyyy'), to_date('27-06-2022', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (434352, 68123, 64, to_date('02-06-2001', 'dd-mm-yyyy'), to_date('19-01-2021', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (828219, 8615, 146, to_date('17-07-2003', 'dd-mm-yyyy'), to_date('31-01-2031', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (947098, 59855, 321, to_date('07-02-2014', 'dd-mm-yyyy'), to_date('17-11-2023', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (447947, 42441, 386, to_date('16-05-2017', 'dd-mm-yyyy'), to_date('31-12-2030', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (408203, 34808, 127, to_date('16-07-2015', 'dd-mm-yyyy'), to_date('07-08-2027', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (49044, 66416, 15, to_date('18-04-2004', 'dd-mm-yyyy'), to_date('31-10-2029', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (948344, 65297, 293, to_date('07-06-2002', 'dd-mm-yyyy'), to_date('11-03-2023', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (914854, 676, 214, to_date('22-07-2001', 'dd-mm-yyyy'), to_date('24-04-2026', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (98399, 52764, 257, to_date('30-08-2010', 'dd-mm-yyyy'), to_date('06-10-2023', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (790841, 98239, 98, to_date('25-09-2009', 'dd-mm-yyyy'), to_date('20-05-2028', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (541449, 33510, 302, to_date('18-01-2009', 'dd-mm-yyyy'), to_date('02-06-2023', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (980831, 24492, 237, to_date('14-02-2017', 'dd-mm-yyyy'), to_date('14-09-2024', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (932187, 87822, 113, to_date('06-08-2001', 'dd-mm-yyyy'), to_date('12-05-2023', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (299724, 91585, 372, to_date('30-03-2005', 'dd-mm-yyyy'), to_date('07-03-2025', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (674318, 16673, 302, to_date('09-10-2004', 'dd-mm-yyyy'), to_date('18-04-2022', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (898245, 36151, 40, to_date('26-06-2014', 'dd-mm-yyyy'), to_date('02-01-2025', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (796595, 18544, 171, to_date('02-05-2011', 'dd-mm-yyyy'), to_date('09-12-2024', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (225427, 56275, 420, to_date('13-01-2014', 'dd-mm-yyyy'), to_date('04-05-2024', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (318117, 49944, 96, to_date('27-04-2017', 'dd-mm-yyyy'), to_date('07-03-2026', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (644377, 60659, 335, to_date('30-01-2005', 'dd-mm-yyyy'), to_date('30-07-2029', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (743504, 93490, 25, to_date('03-10-2013', 'dd-mm-yyyy'), to_date('06-03-2030', 'dd-mm-yyyy'), 'On Hold');
commit;
prompt 200 records committed...
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (467017, 61198, 6, to_date('23-05-2011', 'dd-mm-yyyy'), to_date('11-11-2030', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (578589, 21439, 237, to_date('10-08-2009', 'dd-mm-yyyy'), to_date('12-06-2023', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (423377, 54423, 228, to_date('14-04-2016', 'dd-mm-yyyy'), to_date('03-04-2030', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (7230, 29687, 114, to_date('01-08-2017', 'dd-mm-yyyy'), to_date('28-09-2021', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (831090, 63061, 302, to_date('02-03-2010', 'dd-mm-yyyy'), to_date('12-10-2021', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (119891, 80021, 316, to_date('01-05-2019', 'dd-mm-yyyy'), to_date('11-04-2027', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (980712, 87087, 159, to_date('06-07-2017', 'dd-mm-yyyy'), to_date('13-03-2025', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (334599, 85857, 347, to_date('27-07-2011', 'dd-mm-yyyy'), to_date('25-07-2021', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (502478, 35078, 266, to_date('23-07-2017', 'dd-mm-yyyy'), to_date('29-03-2025', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (900916, 95719, 173, to_date('11-10-2019', 'dd-mm-yyyy'), to_date('10-12-2022', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (730130, 86417, 480, to_date('11-08-2017', 'dd-mm-yyyy'), to_date('13-09-2022', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (627532, 66295, 130, to_date('07-12-2010', 'dd-mm-yyyy'), to_date('29-07-2031', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (327451, 19721, 192, to_date('10-02-2003', 'dd-mm-yyyy'), to_date('12-07-2021', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (224129, 8871, 5, to_date('28-11-2001', 'dd-mm-yyyy'), to_date('24-06-2028', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (693100, 15896, 204, to_date('03-07-2013', 'dd-mm-yyyy'), to_date('05-12-2031', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (898115, 26123, 314, to_date('27-01-2005', 'dd-mm-yyyy'), to_date('13-11-2021', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (909417, 61071, 397, to_date('19-12-2017', 'dd-mm-yyyy'), to_date('07-01-2029', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (96884, 76126, 384, to_date('02-09-2017', 'dd-mm-yyyy'), to_date('04-11-2026', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (250774, 60216, 402, to_date('22-01-2010', 'dd-mm-yyyy'), to_date('08-08-2029', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (536182, 87498, 29, to_date('05-07-2006', 'dd-mm-yyyy'), to_date('15-04-2021', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (517135, 70003, 77, to_date('18-05-2005', 'dd-mm-yyyy'), to_date('02-02-2023', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (905260, 28128, 175, to_date('27-07-2004', 'dd-mm-yyyy'), to_date('10-06-2022', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (708435, 83624, 258, to_date('27-03-2011', 'dd-mm-yyyy'), to_date('11-08-2023', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (889390, 26282, 447, to_date('22-01-2001', 'dd-mm-yyyy'), to_date('23-06-2024', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (805404, 81581, 320, to_date('21-06-2002', 'dd-mm-yyyy'), to_date('04-12-2028', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (400392, 72449, 371, to_date('27-06-2011', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (672456, 34808, 285, to_date('11-06-2002', 'dd-mm-yyyy'), to_date('22-07-2026', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (155801, 30715, 424, to_date('23-04-2019', 'dd-mm-yyyy'), to_date('07-05-2023', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (348279, 19792, 263, to_date('30-03-2013', 'dd-mm-yyyy'), to_date('29-04-2025', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (997286, 9908, 326, to_date('01-10-2005', 'dd-mm-yyyy'), to_date('31-10-2031', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (239746, 50559, 188, to_date('17-03-2004', 'dd-mm-yyyy'), to_date('02-04-2027', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (588956, 99310, 79, to_date('16-04-2009', 'dd-mm-yyyy'), to_date('27-12-2030', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (984764, 82594, 419, to_date('29-10-2012', 'dd-mm-yyyy'), to_date('23-05-2022', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (386164, 79451, 396, to_date('17-06-2001', 'dd-mm-yyyy'), to_date('22-01-2026', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (463277, 30912, 267, to_date('15-11-2018', 'dd-mm-yyyy'), to_date('04-06-2024', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (455255, 9829, 148, to_date('30-05-2009', 'dd-mm-yyyy'), to_date('08-07-2031', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (847380, 17774, 164, to_date('31-05-2000', 'dd-mm-yyyy'), to_date('05-08-2024', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (432707, 22636, 145, to_date('21-07-2007', 'dd-mm-yyyy'), to_date('17-08-2023', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (985387, 79933, 483, to_date('15-06-2016', 'dd-mm-yyyy'), to_date('13-08-2027', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (478184, 30274, 54, to_date('12-01-2008', 'dd-mm-yyyy'), to_date('24-07-2030', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (692871, 23658, 200, to_date('04-03-2008', 'dd-mm-yyyy'), to_date('13-04-2022', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (214392, 9293, 261, to_date('16-07-2016', 'dd-mm-yyyy'), to_date('21-08-2026', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (507595, 39314, 42, to_date('03-01-2019', 'dd-mm-yyyy'), to_date('05-05-2026', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (397509, 21601, 329, to_date('11-08-2003', 'dd-mm-yyyy'), to_date('31-01-2028', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (122674, 68285, 215, to_date('03-05-2001', 'dd-mm-yyyy'), to_date('13-04-2031', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (18810, 91585, 72, to_date('12-06-2012', 'dd-mm-yyyy'), to_date('19-06-2024', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (129313, 9797, 496, to_date('19-01-2017', 'dd-mm-yyyy'), to_date('15-05-2029', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (442420, 71292, 96, to_date('18-01-2017', 'dd-mm-yyyy'), to_date('02-07-2026', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (334742, 75618, 21, to_date('27-02-2016', 'dd-mm-yyyy'), to_date('19-03-2024', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (969833, 23731, 167, to_date('05-04-2007', 'dd-mm-yyyy'), to_date('07-11-2022', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (170963, 9958, 216, to_date('21-05-2002', 'dd-mm-yyyy'), to_date('28-08-2027', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (471806, 62608, 416, to_date('01-04-2002', 'dd-mm-yyyy'), to_date('28-02-2026', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (959951, 16040, 408, to_date('12-12-2019', 'dd-mm-yyyy'), to_date('13-10-2026', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (978261, 30813, 34, to_date('11-01-2019', 'dd-mm-yyyy'), to_date('28-05-2028', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (50926, 51797, 366, to_date('15-06-2000', 'dd-mm-yyyy'), to_date('18-05-2028', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (366832, 77473, 186, to_date('22-07-2007', 'dd-mm-yyyy'), to_date('30-04-2029', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (95305, 33362, 46, to_date('28-01-2014', 'dd-mm-yyyy'), to_date('22-01-2027', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (540648, 19170, 47, to_date('12-12-2008', 'dd-mm-yyyy'), to_date('20-07-2029', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (974999, 66416, 10, to_date('29-12-2013', 'dd-mm-yyyy'), to_date('15-12-2031', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (736022, 34808, 462, to_date('15-06-2018', 'dd-mm-yyyy'), to_date('03-08-2025', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (149634, 51949, 75, to_date('27-03-2008', 'dd-mm-yyyy'), to_date('06-09-2025', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (850629, 15155, 356, to_date('28-08-2019', 'dd-mm-yyyy'), to_date('24-11-2024', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (438349, 61179, 399, to_date('29-11-2017', 'dd-mm-yyyy'), to_date('10-12-2028', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (932831, 18441, 170, to_date('07-07-2001', 'dd-mm-yyyy'), to_date('10-09-2024', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (501799, 9792, 318, to_date('15-12-2005', 'dd-mm-yyyy'), to_date('02-01-2029', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (222751, 93745, 181, to_date('29-10-2014', 'dd-mm-yyyy'), to_date('29-01-2022', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (539961, 81538, 385, to_date('30-05-2005', 'dd-mm-yyyy'), to_date('04-12-2027', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (385730, 18469, 238, to_date('05-08-2009', 'dd-mm-yyyy'), to_date('10-11-2026', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (971399, 272, 168, to_date('04-05-2001', 'dd-mm-yyyy'), to_date('14-03-2029', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (828799, 38746, 25, to_date('23-12-2019', 'dd-mm-yyyy'), to_date('23-12-2028', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (109594, 60342, 22, to_date('20-05-2005', 'dd-mm-yyyy'), to_date('22-04-2026', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (240776, 75056, 128, to_date('06-04-2008', 'dd-mm-yyyy'), to_date('25-06-2029', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (101969, 11515, 134, to_date('04-02-2007', 'dd-mm-yyyy'), to_date('30-03-2026', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (746625, 70564, 277, to_date('16-07-2004', 'dd-mm-yyyy'), to_date('15-06-2026', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (647234, 8337, 307, to_date('15-01-2011', 'dd-mm-yyyy'), to_date('17-01-2023', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (316697, 33137, 271, to_date('11-07-2003', 'dd-mm-yyyy'), to_date('23-04-2026', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (256684, 70614, 31, to_date('12-10-2013', 'dd-mm-yyyy'), to_date('25-11-2025', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (321477, 11219, 230, to_date('12-03-2005', 'dd-mm-yyyy'), to_date('11-06-2021', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (75050, 69730, 70, to_date('15-10-2019', 'dd-mm-yyyy'), to_date('05-05-2029', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (372467, 8703, 414, to_date('28-09-2010', 'dd-mm-yyyy'), to_date('10-01-2021', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (526566, 93691, 336, to_date('25-04-2000', 'dd-mm-yyyy'), to_date('16-08-2024', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (839825, 54515, 6, to_date('02-06-2010', 'dd-mm-yyyy'), to_date('19-07-2026', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (301840, 14371, 43, to_date('14-05-2004', 'dd-mm-yyyy'), to_date('05-04-2022', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (687385, 36368, 370, to_date('03-11-2004', 'dd-mm-yyyy'), to_date('23-04-2022', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (451182, 68918, 190, to_date('27-09-2015', 'dd-mm-yyyy'), to_date('15-05-2025', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (515691, 24938, 386, to_date('26-04-2006', 'dd-mm-yyyy'), to_date('12-01-2021', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (599992, 30912, 61, to_date('30-03-2015', 'dd-mm-yyyy'), to_date('03-04-2028', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (953652, 61927, 175, to_date('03-10-2011', 'dd-mm-yyyy'), to_date('12-04-2031', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (551851, 88109, 76, to_date('16-03-2012', 'dd-mm-yyyy'), to_date('19-05-2029', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (789475, 47946, 38, to_date('15-09-2003', 'dd-mm-yyyy'), to_date('11-04-2025', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (794931, 12627, 437, to_date('21-03-2014', 'dd-mm-yyyy'), to_date('08-09-2028', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (481453, 98239, 156, to_date('14-02-2001', 'dd-mm-yyyy'), to_date('10-06-2021', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (677345, 47642, 128, to_date('09-04-2009', 'dd-mm-yyyy'), to_date('24-11-2025', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (939286, 44535, 169, to_date('27-05-2006', 'dd-mm-yyyy'), to_date('22-08-2024', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (267076, 60216, 482, to_date('02-05-2019', 'dd-mm-yyyy'), to_date('30-03-2028', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (716526, 27143, 394, to_date('23-03-2000', 'dd-mm-yyyy'), to_date('02-01-2021', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (162093, 18441, 114, to_date('16-05-2009', 'dd-mm-yyyy'), to_date('18-10-2023', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (4771, 5518, 64, to_date('28-10-2000', 'dd-mm-yyyy'), to_date('18-10-2028', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (766292, 87822, 188, to_date('27-12-2000', 'dd-mm-yyyy'), to_date('18-04-2022', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (70253, 82507, 102, to_date('11-03-2009', 'dd-mm-yyyy'), to_date('12-09-2022', 'dd-mm-yyyy'), 'Processing');
commit;
prompt 300 records committed...
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (796883, 27291, 69, to_date('06-08-2004', 'dd-mm-yyyy'), to_date('06-03-2026', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (23434, 90519, 47, to_date('20-10-2006', 'dd-mm-yyyy'), to_date('25-06-2024', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (38843, 40035, 66, to_date('04-05-2009', 'dd-mm-yyyy'), to_date('16-03-2028', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (62226, 30715, 412, to_date('08-06-2017', 'dd-mm-yyyy'), to_date('18-12-2028', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (612067, 56805, 85, to_date('11-09-2014', 'dd-mm-yyyy'), to_date('20-11-2024', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (579476, 24236, 336, to_date('19-08-2009', 'dd-mm-yyyy'), to_date('07-09-2030', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (266843, 23018, 136, to_date('30-11-2012', 'dd-mm-yyyy'), to_date('31-07-2026', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (775333, 18210, 54, to_date('10-05-2001', 'dd-mm-yyyy'), to_date('29-08-2023', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (473263, 28627, 260, to_date('27-04-2016', 'dd-mm-yyyy'), to_date('25-12-2025', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (665118, 9797, 311, to_date('04-06-2013', 'dd-mm-yyyy'), to_date('14-04-2025', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (320214, 97516, 79, to_date('05-07-2008', 'dd-mm-yyyy'), to_date('04-06-2021', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (623334, 19170, 464, to_date('13-04-2003', 'dd-mm-yyyy'), to_date('11-02-2024', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (489558, 30715, 293, to_date('26-07-2003', 'dd-mm-yyyy'), to_date('09-02-2029', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (854428, 27172, 190, to_date('26-08-2015', 'dd-mm-yyyy'), to_date('11-02-2029', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (821134, 49840, 42, to_date('25-04-2002', 'dd-mm-yyyy'), to_date('10-04-2021', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (430938, 6557, 270, to_date('31-08-2011', 'dd-mm-yyyy'), to_date('10-09-2026', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (234211, 8615, 250, to_date('11-09-2019', 'dd-mm-yyyy'), to_date('11-11-2026', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (789649, 70614, 104, to_date('24-12-2002', 'dd-mm-yyyy'), to_date('23-06-2028', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (20996, 96625, 97, to_date('18-04-2002', 'dd-mm-yyyy'), to_date('30-03-2029', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (826381, 27454, 211, to_date('10-07-2002', 'dd-mm-yyyy'), to_date('08-10-2021', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (777856, 81364, 479, to_date('27-02-2000', 'dd-mm-yyyy'), to_date('12-01-2024', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (980031, 39694, 86, to_date('02-05-2008', 'dd-mm-yyyy'), to_date('27-01-2022', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (489851, 61198, 367, to_date('31-10-2001', 'dd-mm-yyyy'), to_date('06-01-2031', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (946506, 76728, 444, to_date('23-02-2002', 'dd-mm-yyyy'), to_date('16-02-2023', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (534208, 76631, 174, to_date('09-11-2006', 'dd-mm-yyyy'), to_date('29-10-2021', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (913156, 26123, 458, to_date('23-03-2009', 'dd-mm-yyyy'), to_date('22-05-2027', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (618374, 92546, 289, to_date('08-08-2014', 'dd-mm-yyyy'), to_date('09-10-2024', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (454341, 79933, 267, to_date('13-01-2011', 'dd-mm-yyyy'), to_date('27-10-2023', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (918261, 54561, 112, to_date('26-08-2013', 'dd-mm-yyyy'), to_date('08-01-2022', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (478764, 82507, 132, to_date('24-04-2007', 'dd-mm-yyyy'), to_date('07-07-2024', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (932309, 49944, 54, to_date('13-09-2000', 'dd-mm-yyyy'), to_date('19-01-2027', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (869173, 78342, 244, to_date('30-01-2009', 'dd-mm-yyyy'), to_date('13-06-2021', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (816996, 43127, 31, to_date('07-02-2003', 'dd-mm-yyyy'), to_date('11-01-2029', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (705086, 16673, 317, to_date('22-03-2009', 'dd-mm-yyyy'), to_date('29-05-2024', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (219423, 49841, 193, to_date('17-01-2004', 'dd-mm-yyyy'), to_date('23-07-2021', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (209134, 42340, 235, to_date('18-01-2002', 'dd-mm-yyyy'), to_date('24-11-2024', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (872581, 81786, 171, to_date('03-07-2014', 'dd-mm-yyyy'), to_date('10-12-2027', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (807670, 22636, 121, to_date('18-08-2008', 'dd-mm-yyyy'), to_date('29-07-2030', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (468960, 39659, 315, to_date('25-12-2000', 'dd-mm-yyyy'), to_date('27-11-2026', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (946268, 60897, 340, to_date('26-03-2009', 'dd-mm-yyyy'), to_date('28-06-2031', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (578075, 53843, 470, to_date('12-02-2003', 'dd-mm-yyyy'), to_date('18-06-2026', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (550710, 36368, 76, to_date('30-07-2009', 'dd-mm-yyyy'), to_date('16-03-2026', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (623594, 85857, 8, to_date('12-03-2000', 'dd-mm-yyyy'), to_date('15-04-2030', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (274123, 45964, 236, to_date('03-06-2012', 'dd-mm-yyyy'), to_date('30-07-2029', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (185632, 67681, 417, to_date('10-09-2010', 'dd-mm-yyyy'), to_date('31-10-2028', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (920868, 95842, 56, to_date('10-01-2011', 'dd-mm-yyyy'), to_date('29-09-2030', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (143884, 22438, 401, to_date('27-10-2013', 'dd-mm-yyyy'), to_date('01-02-2029', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (687815, 58151, 435, to_date('04-02-2006', 'dd-mm-yyyy'), to_date('09-08-2026', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (427200, 93222, 63, to_date('24-03-2007', 'dd-mm-yyyy'), to_date('21-08-2029', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (113616, 21190, 108, to_date('14-09-2012', 'dd-mm-yyyy'), to_date('23-11-2027', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (385224, 86666, 366, to_date('01-11-2019', 'dd-mm-yyyy'), to_date('16-06-2026', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (876619, 24337, 438, to_date('10-11-2008', 'dd-mm-yyyy'), to_date('22-07-2025', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (47734, 48027, 183, to_date('17-12-2003', 'dd-mm-yyyy'), to_date('09-08-2027', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (832045, 63327, 187, to_date('26-02-2002', 'dd-mm-yyyy'), to_date('21-01-2029', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (787298, 71881, 395, to_date('10-09-2015', 'dd-mm-yyyy'), to_date('07-10-2024', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (929036, 62608, 298, to_date('27-02-2016', 'dd-mm-yyyy'), to_date('16-11-2026', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (150886, 49840, 96, to_date('26-08-2017', 'dd-mm-yyyy'), to_date('13-04-2026', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (898213, 19721, 296, to_date('25-01-2003', 'dd-mm-yyyy'), to_date('23-03-2030', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (876033, 54419, 116, to_date('13-03-2003', 'dd-mm-yyyy'), to_date('28-01-2028', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (850378, 21601, 91, to_date('12-03-2014', 'dd-mm-yyyy'), to_date('31-10-2022', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (357219, 11659, 150, to_date('26-01-2006', 'dd-mm-yyyy'), to_date('19-09-2021', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (176959, 89424, 38, to_date('04-11-2004', 'dd-mm-yyyy'), to_date('15-04-2027', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (78052, 90019, 484, to_date('25-08-2004', 'dd-mm-yyyy'), to_date('18-06-2031', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (392846, 11540, 292, to_date('24-02-2015', 'dd-mm-yyyy'), to_date('13-04-2028', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (774904, 22636, 346, to_date('07-10-2014', 'dd-mm-yyyy'), to_date('05-01-2021', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (812234, 90255, 65, to_date('04-06-2013', 'dd-mm-yyyy'), to_date('15-10-2023', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (347624, 28627, 107, to_date('23-03-2010', 'dd-mm-yyyy'), to_date('07-05-2030', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (198102, 68013, 57, to_date('11-08-2013', 'dd-mm-yyyy'), to_date('01-12-2026', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (782926, 33255, 133, to_date('23-01-2015', 'dd-mm-yyyy'), to_date('14-11-2025', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (775935, 35973, 443, to_date('09-05-2003', 'dd-mm-yyyy'), to_date('14-02-2031', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (606123, 37754, 247, to_date('04-08-2016', 'dd-mm-yyyy'), to_date('23-09-2027', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (252355, 72449, 412, to_date('13-04-2004', 'dd-mm-yyyy'), to_date('26-11-2030', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (626785, 66416, 357, to_date('29-04-2013', 'dd-mm-yyyy'), to_date('13-01-2025', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (729228, 72100, 413, to_date('03-02-2011', 'dd-mm-yyyy'), to_date('03-03-2028', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (993979, 25022, 466, to_date('25-10-2016', 'dd-mm-yyyy'), to_date('10-05-2028', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (653934, 51949, 343, to_date('30-11-2000', 'dd-mm-yyyy'), to_date('01-01-2023', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (826701, 2540, 358, to_date('25-06-2011', 'dd-mm-yyyy'), to_date('11-09-2028', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (196375, 40117, 70, to_date('11-08-2009', 'dd-mm-yyyy'), to_date('13-05-2023', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (935128, 66920, 432, to_date('26-06-2001', 'dd-mm-yyyy'), to_date('07-11-2030', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (693369, 9622, 306, to_date('06-07-2016', 'dd-mm-yyyy'), to_date('03-02-2023', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (398316, 11659, 232, to_date('29-09-2018', 'dd-mm-yyyy'), to_date('30-10-2023', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (51065, 63327, 441, to_date('08-03-2004', 'dd-mm-yyyy'), to_date('06-03-2021', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (13969, 52098, 382, to_date('31-01-2011', 'dd-mm-yyyy'), to_date('02-10-2028', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (245968, 18769, 126, to_date('09-10-2004', 'dd-mm-yyyy'), to_date('24-02-2026', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (885898, 56805, 245, to_date('27-08-2014', 'dd-mm-yyyy'), to_date('12-06-2026', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (315244, 93882, 463, to_date('24-06-2009', 'dd-mm-yyyy'), to_date('06-02-2025', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (664813, 30085, 239, to_date('21-08-2019', 'dd-mm-yyyy'), to_date('11-07-2031', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (476892, 84672, 315, to_date('12-10-2002', 'dd-mm-yyyy'), to_date('01-09-2031', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (208044, 11659, 405, to_date('26-04-2003', 'dd-mm-yyyy'), to_date('30-10-2021', 'dd-mm-yyyy'), 'On Hold');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (270437, 15155, 385, to_date('13-11-2007', 'dd-mm-yyyy'), to_date('30-12-2021', 'dd-mm-yyyy'), 'Pending');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (673842, 59781, 387, to_date('02-08-2009', 'dd-mm-yyyy'), to_date('15-06-2028', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (858739, 35078, 291, to_date('17-12-2014', 'dd-mm-yyyy'), to_date('29-06-2021', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (315880, 9797, 188, to_date('03-12-2018', 'dd-mm-yyyy'), to_date('31-08-2023', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (881581, 21791, 59, to_date('29-12-2008', 'dd-mm-yyyy'), to_date('02-12-2024', 'dd-mm-yyyy'), 'Processing');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (493557, 51307, 101, to_date('06-12-2017', 'dd-mm-yyyy'), to_date('19-07-2027', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (501619, 16040, 2, to_date('07-04-2018', 'dd-mm-yyyy'), to_date('12-02-2029', 'dd-mm-yyyy'), 'Shipped');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (663769, 59853, 426, to_date('29-06-2002', 'dd-mm-yyyy'), to_date('15-02-2021', 'dd-mm-yyyy'), 'Canceled');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (533354, 2994, 148, to_date('09-08-2010', 'dd-mm-yyyy'), to_date('23-05-2031', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (369733, 56866, 135, to_date('06-08-2013', 'dd-mm-yyyy'), to_date('24-04-2026', 'dd-mm-yyyy'), 'Completed');
insert into PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
values (795731, 84672, 461, to_date('16-08-2008', 'dd-mm-yyyy'), to_date('28-05-2025', 'dd-mm-yyyy'), 'Pending');
commit;
prompt 400 records loaded
prompt Loading RAW_MARETIALS...
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (521818, 'Yttria', 24, 'Rocketry Tech Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (370183, 'Oganesson', 4120, 'Interstellar Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (295501, 'Gadolinium Antimonide', 679, 'Stellar Components Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (14372, 'Yttrium Antimonide', 2103, 'Martian Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (647273, 'Scandium Sulfide', 869, 'Spacecraft Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (284597, 'Zinc Aluminate', 3574, 'RocketTech Industries');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (415785, 'Moscovium', 1968, 'Meteor Components Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (890695, 'Yttrium Phosphide', 7047, 'Celestial Innovations');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (522572, 'Chromia', 3541, 'SolarParts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (691980, 'Neodymium Aluminum Oxide', 4654, 'Spacemakers Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (561109, 'Holmium Sulfide', 9386, 'SpaceInnovations Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (757785, 'Yttrium Boride', 7285, 'Starship Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (638601, 'Samarium Antimonide', 7983, 'Meteor Components Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (490512, 'Tungsten Boride', 5343, 'Galactic Supply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (280286, 'Erbium', 8572, 'Satellite Components Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (811180, 'Terbium Oxide', 5138, 'AstroParts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (396225, 'Erbium Nitride', 2847, 'Quantum Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (407471, 'Indium', 896, 'Planetary Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (310605, 'Lawrencium', 2286, 'Nova Components Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (44275, 'Holmium Boride', 2394, 'OrbitMaterial Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (853532, 'Cerium Silicide', 1094, 'Planetary Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (936738, 'Holmium Arsenide', 8224, 'Celestial Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (515332, 'Gadolinium Sulfide', 4783, 'InterSpace Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (185813, 'Titanium Nitride', 4677, 'AstroParts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (663341, 'Terbium Oxide', 4366, 'Rocketry Parts Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (276298, 'Potassium Niobate', 258, 'Spacecraft Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (821209, 'Tennessine', 6186, 'AeroMaterial Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (637391, 'Yttrium Carbide', 5822, 'OrbitMaterial Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (10695, 'Lutetium Aluminum Oxide', 7362, 'Aerospace Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (265733, 'Ytterbium Silicide', 332, 'RocketMaterials Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (155958, 'Cerium Boride', 6863, 'Aerospace Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (410956, 'Gadolinium Oxide', 2253, 'SpaceParts Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (550362, 'Yttrium Aluminum Oxide', 2210, 'Eclipse Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (323730, 'Zirconium Boride', 6557, 'Quantum Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (385771, 'Tungsten Disulfide', 1798, 'Nebula Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (66309, 'Ytterbium Antimonide', 7360, 'ExoTech Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (344341, 'Erbium Aluminum Oxide', 2847, 'Horizon Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (385576, 'Holmium Oxide', 6189, 'Rocketry Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (252822, 'Molybdenum', 4974, 'AeroParts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (648597, 'Praseodymium Oxide', 5865, 'SpaceTech Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (799353, 'Neodymium Carbide', 9394, 'Horizon Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (840660, 'Samarium Silicide', 14, 'Pulsar Supplies Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (312760, 'Praseodymium Phosphide', 3740, 'Celestial Innovations');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (625826, 'Terbium Carbide', 8208, 'Celestial Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (604349, 'Magnesia', 2522, 'Rocketry Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (469974, 'Gadolinium Aluminum Oxynitride', 6719, 'Rocketry Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (872209, 'Terbium Sulfide', 3190, 'Galactic Supply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (826349, 'Terbium Boride', 4914, 'Quantum Materials Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (668004, 'Kevlar', 7840, 'Exoplanet Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (383609, 'Lutetium Boride', 7262, 'OrbitMaterial Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (926272, 'Samarium Oxide', 535, 'Spacetech Suppliers');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (376370, 'Zirconium', 972, 'Rocketry Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (56223, 'Chromium', 259, 'Rocketry Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (958257, 'Terbium Boride', 9256, 'SpaceComponent Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (96029, 'Promethium', 9486, 'InterSpace Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (637448, 'Thulium Arsenide', 209, 'Planetary Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (929631, 'Tennessine', 8378, 'Cosmos Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (774717, 'Holmium Nitride', 1334, 'Horizon Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (566032, 'Ytterbium Boride', 4615, 'TerraMaterials Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (143990, 'Lutetium Arsenide', 9666, 'Eclipse Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (481088, 'Vanadium Boride', 8844, 'Spacetech Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (555383, 'Boron Arsenide', 7538, 'OrbitTech Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (21815, 'Tantalum Carbide', 5746, 'ExoTech Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (540757, 'Steel', 3968, 'Eclipse Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (873175, 'Cerium Nitride', 742, 'Cosmos Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (101756, 'Erbium Aluminum Oxynitride', 1675, 'AstroSupply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (587384, 'Ytterbium Carbide', 2316, 'Galactic Supply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (520360, 'Titanium Diboride', 9708, 'Aerospace Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (175701, 'Chromium', 9962, 'Meteor Components Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (231932, 'Erbium Arsenide', 1710, 'Quantum Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (762725, 'Praseodymium Silicide', 7760, 'Nova Manufacturing');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (760762, 'Terbium Antimonide', 9812, 'Celestial Supplies Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (303200, 'Nihonium', 3575, 'SpaceTech Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (718116, 'Zirconia', 4131, 'Satellite Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (361301, 'Ytterbium Phosphide', 3880, 'Cosmos Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (862779, 'Terbium Silicide', 7922, 'Celestial Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (952436, 'Terbium Aluminum Oxynitride', 4208, 'SpaceComponent Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (224110, 'Strontium Zirconate', 8326, 'MeteorTech Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (447547, 'Carbon Fiber', 5224, 'Rocketry Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (287578, 'Lutetium Nitride', 2767, 'SpaceTech Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (539897, 'Strontium Titanate', 4423, 'Rocketry Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (242818, 'Terbium Silicide', 957, 'AeroParts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (274378, 'Holmium Boride', 3457, 'GlobalTech Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (294175, 'Samarium Boride', 2539, 'Celestial Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (139299, 'Holmium Silicide', 1084, 'Meteor Components Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (33748, 'Kevlar', 341, 'Starship Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (220687, 'Ytterbium Nitride', 1740, 'Starship Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (876939, 'Praseodymium Boride', 9270, 'SpaceComponent Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (419082, 'Berkelium', 9741, 'Aerospace Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (560505, 'Dubnium', 815, 'Zenith Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (728838, 'Yttria', 9103, 'Nebula Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (703094, 'Yttrium Silicide', 3199, 'SpaceComponent Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (579916, 'Potassium Aluminum Oxide', 8997, 'Cosmos Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (428301, 'Barium Aluminum Oxide', 7121, 'Pulsar Supplies Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (242179, 'Cerium Boride', 4818, 'Galactic Supply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (50211, 'Holmium Silicide', 7159, 'RocketTech Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (292195, 'Silver', 4888, 'InterSpace Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (821446, 'Rhodium', 8773, 'Aerospace Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (142529, 'Thulium Oxide', 2778, 'Pulsar Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (743713, 'Lutetium Carbide', 943, 'OrbitTech Corp');
commit;
prompt 100 records committed...
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (633540, 'Lutetium Aluminum Oxynitride', 5259, 'Interstellar Supply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (440852, 'Vanadium', 4435, 'LunarSupplies Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (687684, 'Chromium', 5871, 'Celestial Supplies Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (94379, 'Praseodymium Arsenide', 5683, 'AstroParts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (26301, 'Yttrium Sulfide', 4132, 'Exospace Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (441534, 'Praseodymium Arsenide', 6301, 'Spacecraft Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (948919, 'Praseodymium', 352, 'Celestial Supplies Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (835832, 'Praseodymium Silicide', 8223, 'Titan Manufacturing');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (175051, 'Titanium Diboride', 6090, 'Cosmos Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (370106, 'Thulium Sulfide', 4460, 'SolarTech Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (748485, 'Silicon Boride', 221, 'SpaceX Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (62055, 'Praseodymium Oxide', 5494, 'LunarParts Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (4091, 'Lutetium Nitride', 644, 'Planetary Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (102287, 'Holmium Boride', 1281, 'LunarTech Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (597108, 'Lutetium Aluminum Oxide', 1598, 'Planetary Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (164875, 'Erbium Aluminum Oxide', 8893, 'Meteor Components Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (594949, 'Strontium Titanate', 6615, 'AeroMaterial Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (780394, 'Ytterbium Nitride', 5779, 'Galaxy Innovations');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (631492, 'Californium', 7096, 'AstroParts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (771476, 'Fermium', 8652, 'OrbitalTech Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (123880, 'Hassium', 6504, 'Interstellar Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (750849, 'Hafnium Boride', 7999, 'Constellation Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (551816, 'Aluminum', 196, 'LunarSupplies Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (681891, 'Gadolinium Phosphide', 8218, 'Starship Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (799364, 'Moscovium', 867, 'DeepSpace Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (501673, 'Barium Aluminum Oxide', 3381, 'OrbitMaterial Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (559238, 'Holmium Aluminum Oxide', 9627, 'InterSpace Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (806506, 'Silicon', 8623, 'Martian Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (799608, 'Hafnium Carbide', 2696, 'Cosmos Parts Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (599990, 'Erbium Arsenide', 7146, 'AstroParts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (293391, 'Praseodymium Aluminum Oxynitride', 3733, 'AstroSupplies Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (103558, 'Neodymium', 2864, 'Stellar Manufacturing');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (210048, 'Holmium Sulfide', 1785, 'Martian Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (629523, 'Thulium Boride', 8661, 'Stellar Components Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (769884, 'Lutetium Aluminum Oxynitride', 4856, 'Exoplanet Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (516632, 'Gadolinium Aluminum Oxide', 276, 'Galactic Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (960842, 'Aluminum Nitride', 9112, 'Horizon Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (128102, 'Tellurium', 5821, 'Nebula Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (317804, 'Terbium Boride', 3703, 'TerraMaterials Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (912171, 'Aluminum Boride', 907, 'Stellar Manufacturing');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (764379, 'Praseodymium Sulfide', 1211, 'Interstellar Supply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (525151, 'Promethium', 9420, 'LunarParts Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (517212, 'Lutetium Boride', 3728, 'Aerospace Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (16966, 'Cadmium Telluride', 9893, 'LunarSupplies Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (52772, 'Ytterbium Arsenide', 4550, 'Constellation Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (79203, 'Titanium Aluminide', 7529, 'Pulsar Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (136651, 'Thulium Antimonide', 5504, 'Nova Manufacturing');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (355659, 'Gold', 1830, 'RocketParts Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (915360, 'Tantalum Carbide', 9899, 'RocketTech Industries');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (815387, 'Cerium Aluminum Oxide', 9867, 'SolarParts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (70634, 'Titanium Nitride', 1096, 'OrbitMaterial Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (188245, 'Lutetium Oxide', 5156, 'Stellar Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (36213, 'Gallium Arsenide', 6713, 'Celestial Supplies Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (462938, 'Berkelium', 2179, 'GlobalTech Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (277154, 'Cerium Carbide', 8442, 'Starship Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (447570, 'Sodium', 6519, 'Quantum Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (631620, 'Praseodymium Antimonide', 7503, 'GlobalTech Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (392688, 'Praseodymium Oxide', 614, 'Aerospace Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (715180, 'Lanthanum Boride', 5719, 'Galaxy Innovations');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (676831, 'Holmium', 5155, 'MilkyWay Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (387604, 'Erbium Silicide', 2211, 'NovaParts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (554574, 'Silicon Carbide', 6091, 'Horizon Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (282160, 'Tungsten Boride', 5727, 'DeepSpace Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (967078, 'Rhodium', 7267, 'Aerospace Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (397411, 'Scandium', 2587, 'DeepSpace Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (415134, 'Alumina', 8684, 'Pulsar Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (751513, 'Palladium', 260, 'LunarSupplies Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (894712, 'Boron Carbide', 389, 'OrbitTech Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (99013, 'Sodium', 6562, 'SpaceComponent Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (895006, 'Holmium Oxide', 1987, 'Starlight Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (710140, 'Thorium', 4479, 'MilkyWay Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (458985, 'Ytterbium Phosphide', 7774, 'AstroParts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (212610, 'Terbium Nitride', 2622, 'Nebula Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (306432, 'Ceria', 7501, 'Spacecraft Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (495916, 'Meitnerium', 1291, 'Celestial Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (19501, 'Holmium Nitride', 2759, 'Quantum Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (678128, 'Dysprosium', 4186, 'RocketParts Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (290753, 'Aluminum Boride', 8997, 'DeepSpace Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (135192, 'Bohrium', 5722, 'Comet Supplies Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (233714, 'Cerium Aluminum Oxynitride', 3147, 'Celestech Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (592721, 'Tantalum', 3982, 'Starlight Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (755913, 'Lanthanum Silicide', 6899, 'SpaceX Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (280298, 'Ytterbium Boride', 9291, 'RocketTech Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (994432, 'Ytterbium Phosphide', 5577, 'Celestial Innovations');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (148267, 'Calcium Zirconate', 8415, 'SpaceTech Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (813957, 'Gadolinium Boride', 2656, 'Stellar Components Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (147037, 'Erbium Aluminum Oxynitride', 4386, 'Cosmic Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (367316, 'Terbium Aluminum Oxynitride', 9900, 'Celestial Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (568872, 'Platinum', 1949, 'Aerospace Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (718532, 'Meitnerium', 3117, 'Starship Supplies Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (452192, 'Dysprosium Carbide', 8641, 'Celestial Innovations');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (528372, 'Magnesium Aluminate', 3555, 'Galactic Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (48369, 'Praseodymium Aluminum Oxynitride', 1481, 'SolarParts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (802387, 'Cerium Sulfide', 4907, 'CelestialTech Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (351022, 'Molybdenum Disulfide', 9307, 'Titan Manufacturing');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (701464, 'Tantalum', 5948, 'DeepSpace Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (687816, 'Erbium Arsenide', 712, 'OrbitMaterial Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (414872, 'Ytterbium Nitride', 8801, 'Celestial Innovations');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (374760, 'Holmium Aluminum Oxide', 7631, 'MeteorTech Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (95806, 'Barium Titanate', 2817, 'AstroTech Industries');
commit;
prompt 200 records committed...
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (432999, 'Scandium Antimonide', 4528, 'AstroSupplies Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (859437, 'Molybdenum Boride', 4098, 'Stellar Components Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (368117, 'Graphite', 3228, 'Pulsar Supplies Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (843460, 'Neodymium Silicide', 618, 'Nebula Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (11931, 'Boron Carbide', 3367, 'RocketParts Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (331137, 'Molybdenum Boride', 3000, 'StellarTech Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (426783, 'Darmstadtium', 8459, 'Orbit Suppliers');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (936844, 'Ytterbium Phosphide', 891, 'Nova Components Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (872348, 'Lanthanum', 7602, 'Galactic Supply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (854125, 'Tungsten', 4983, 'SpaceComponent Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (834921, 'Dysprosium Oxide', 2800, 'AstroManufacturing Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (166228, 'Tungsten Boride', 4642, 'SpaceTech Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (119218, 'Tantalum', 1911, 'AstroSupplies Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (219159, 'Zirconium Oxide', 1174, 'DeepSpace Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (2673, 'Praseodymium Oxide', 7225, 'Pulsar Supplies Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (57228, 'Neodymium Arsenide', 6712, 'AstroManufacturing Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (452232, 'Terbium Boride', 9657, 'ExoTech Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (921095, 'Dysprosium Antimonide', 8725, 'Interstellar Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (403655, 'Silicon', 8576, 'RocketTech Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (808317, 'Samarium Phosphide', 156, 'StellarTech Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (103308, 'Calcium Aluminum Oxide', 7255, 'SolarTech Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (96394, 'Nickel', 5187, 'OrbitTech Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (512462, 'Thulium', 3939, 'Spacecraft Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (228317, 'Americium', 618, 'LunarParts Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (774090, 'Terbium Boride', 8554, 'Rocketry Parts Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (460616, 'Nihonium', 2888, 'Horizon Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (742164, 'Rhodium', 5019, 'SpaceParts Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (673902, 'Osmium', 704, 'Exoplanet Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (573451, 'Cerium Silicide', 9209, 'DeepSpace Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (245923, 'Lanthanum Antimonide', 3308, 'ExoTech Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (381810, 'Barium Titanate', 2515, 'Starship Supplies Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (987099, 'Protactinium', 4359, 'SpaceComponent Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (954988, 'Dysprosium Aluminum Oxynitride', 1057, 'Spacecraft Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (138580, 'Samarium Arsenide', 1448, 'Aerospace Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (533922, 'Holmium Oxide', 497, 'Cosmos Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (432785, 'Neodymium Phosphide', 1237, 'Quantum Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (654527, 'Erbium', 6494, 'Spacemakers Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (216452, 'Cerium Silicide', 214, 'Aerospace Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (52002, 'Seaborgium', 775, 'SpaceX Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (636187, 'Titanium Nitride', 1085, 'Rocketry Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (627618, 'Terbium Antimonide', 2842, 'Galactic Supply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (886506, 'Terbium Nitride', 4785, 'RocketTech Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (478025, 'Lanthanum Phosphide', 7284, 'CelestialTech Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (520387, 'Yttrium Boride', 8111, 'Satellite Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (987038, 'Gadolinium Silicide', 6735, 'AstroBuild Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (822312, 'Silicon Boride', 6989, 'ExoTech Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (979945, 'Lanthanum Boride', 446, 'NovaParts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (243818, 'Cerium Sulfide', 5358, 'DeepSpace Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (940293, 'Thulium Boride', 8486, 'Eclipse Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (901539, 'Hafnium Carbide', 9683, 'DeepSpace Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (289194, 'Antimony', 1559, 'LunarSupplies Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (137762, 'Dysprosium Sulfide', 9087, 'MeteorTech Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (727113, 'Niobium Carbide', 6465, 'Quantum Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (143460, 'Thulium Arsenide', 1120, 'Aerospace Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (638176, 'Lead Zirconate', 7162, 'AstroSupply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (643853, 'Ytterbium Silicide', 3142, 'Constellation Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (556956, 'Selenium Sulfide', 1473, 'LunarTech Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (646447, 'Ytterbium Antimonide', 9334, 'Exoplanet Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (697775, 'Zirconium Aluminum Oxide', 3411, 'Asteroid Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (251581, 'Praseodymium Boride', 3334, 'Galactic Supply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (546504, 'Aluminum', 1121, 'DeepSpace Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (525476, 'Iron', 6504, 'Celestech Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (514852, 'Silicon Nitride', 460, 'AstroSupply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (435782, 'Steel', 1809, 'Celestial Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (657169, 'Livermorium', 4197, 'Comet Supplies Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (849622, 'Boron Carbide', 3337, 'InterSpace Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (449742, 'Cerium Phosphide', 6832, 'Interstellar Supply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (594146, 'Cerium', 1428, 'RocketTech Industries');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (632589, 'Cerium Nitride', 5049, 'RocketParts Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (579566, 'Lanthanum', 3441, 'AstroTech Industries');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (113759, 'Praseodymium Phosphide', 3790, 'Starship Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (984714, 'Tennessine', 138, 'Interstellar Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (936126, 'Yttrium Aluminum Oxynitride', 7954, 'MilkyWay Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (505085, 'Aluminum', 7698, 'Stellar Components Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (306691, 'Ytterbium Silicide', 9721, 'AstroParts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (663381, 'Osmium', 5350, 'Martian Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (688371, 'Praseodymium Nitride', 1498, 'Orbit Suppliers');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (182562, 'Samarium Phosphide', 8640, 'Quantum Materials Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (954303, 'Samarium Nitride', 4502, 'SolarParts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (421389, 'Yttrium Antimonide', 8313, 'Nebula Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (604640, 'Strontium Zirconate', 2948, 'LunarParts Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (872477, 'Yttria', 4826, 'Spacecraft Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (45842, 'Erbium Antimonide', 3882, 'MilkyWay Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (722836, 'Barium Titanate', 8487, 'MeteorTech Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (932477, 'Dysprosium Antimonide', 2627, 'Interstellar Supply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (476918, 'Bismuth', 5214, 'Galaxy Innovations');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (571523, 'Mendelevium', 3854, 'Martian Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (642169, 'Praseodymium Aluminum Oxide', 7923, 'NovaParts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (389153, 'Chromium', 8290, 'SpaceMaterials Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (477069, 'Holmium Silicide', 3539, 'Nova Components Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (460043, 'Barium Titanate', 5030, 'Spacetech Suppliers');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (801686, 'Lanthanum Boride', 5633, 'Planetary Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (99163, 'Californium', 9498, 'AstroParts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (870717, 'Gadolinium Aluminum Oxynitride', 2684, 'Asteroid Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (516074, 'Chromium', 7013, 'DeepSpace Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (309040, 'Calcium', 1966, 'InterstellarTech Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (531729, 'Lutetium Nitride', 1994, 'MilkyWay Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (109753, 'Cerium', 9060, 'AstroBuild Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (357765, 'Holmium Boride', 2780, 'Exoplanet Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (694731, 'Strontium Titanate', 2987, 'Cosmic Components');
commit;
prompt 300 records committed...
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (438303, 'Silica', 2079, 'Galactic Supply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (37666, 'Thulium Silicide', 6977, 'StellarSupplies Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (354242, 'Gadolinium Antimonide', 3048, 'Aerospace Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (849614, 'Holmium Antimonide', 4846, 'Interstellar Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (790059, 'Samarium Antimonide', 985, 'SpaceInnovations Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (827048, 'Cerium Aluminum Oxynitride', 3019, 'Eclipse Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (563106, 'Gallium Nitride', 657, 'Satellite Components Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (962395, 'Neodymium Boride', 8158, 'Nova Manufacturing');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (715401, 'Copernicium', 9250, 'Spacecraft Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (917093, 'Thallium', 424, 'StellarSupplies Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (667935, 'Gadolinium Silicide', 4938, 'CelestialTech Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (457131, 'Lutetium Aluminum Oxynitride', 2371, 'Satellite Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (437459, 'Praseodymium', 1091, 'Exospace Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (951097, 'Samarium Nitride', 3452, 'Cosmic Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (915786, 'Erbium Antimonide', 6092, 'Planetary Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (930729, 'Gold', 154, 'ExoTech Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (211588, 'Chromium', 8788, 'AstroManufacturing Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (713956, 'Titanium Boride', 1765, 'Celestial Supplies Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (54690, 'Iron', 9565, 'SpaceMaterials Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (90451, 'Neodymium Phosphide', 1758, 'Stellar Components Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (262869, 'Nickel', 7048, 'Spacetech Suppliers');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (69670, 'Terbium', 4801, 'SpaceTech Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (271153, 'Erbium Arsenide', 421, 'LunarParts Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (691406, 'Cobalt', 9398, 'LunarSupplies Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (723613, 'Gadolinium Carbide', 7385, 'SpaceInnovations Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (898836, 'Nobelium', 6146, 'Cosmos Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (127663, 'Magnesium Aluminate', 7720, 'Spacecraft Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (474061, 'Roentgenium', 1627, 'Spacetech Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (570854, 'Ytterbium Antimonide', 2495, 'Aerospace Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (36159, 'Uranium', 7915, 'Spacetech Suppliers');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (500178, 'Ytterbium Oxide', 8888, 'Aerospace Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (101729, 'Strontium Zirconate', 7713, 'MilkyWay Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (563856, 'Lutetium Aluminum Oxynitride', 632, 'Rocketry Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (207939, 'Lutetium Carbide', 5118, 'Interstellar Supply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (515639, 'Bohrium', 4098, 'Spacetech Suppliers');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (98075, 'Gadolinium Arsenide', 2007, 'Spacecraft Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (181606, 'Vanadium', 9982, 'CelestialTech Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (969582, 'Thallium', 46, 'OrbitalTech Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (489458, 'Cerium Silicide', 640, 'Exoplanet Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (784618, 'Roentgenium', 8329, 'SpaceInnovations Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (560319, 'Ytterbium Sulfide', 3034, 'StellarTech Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (643095, 'Silicon', 6638, 'AstroManufacturing Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (863027, 'Thulium Silicide', 7302, 'Cosmos Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (218229, 'Moscovium', 4333, 'Galactic Innovations');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (430938, 'Ytterbium Carbide', 961, 'Planetary Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (254586, 'Terbium Phosphide', 4858, 'StellarSupplies Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (141215, 'Boron Carbide', 8736, 'Meteor Components Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (128628, 'Ferrite', 5886, 'OrbitMaterial Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (56631, 'Lutetium Arsenide', 7995, 'RocketTech Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (471762, 'Osmium', 5071, 'Aerospace Parts Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (829863, 'Cadmium Telluride', 9840, 'Celestial Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (855886, 'Vanadium', 1444, 'Starship Supplies Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (170292, 'Mendelevium', 5795, 'AstroManufacturing Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (541435, 'Samarium Aluminum Oxynitride', 2417, 'GlobalTech Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (373295, 'Tantalum Boride', 133, 'AstroTech Industries');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (287930, 'Thulium Boride', 6426, 'SpaceComponent Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (912043, 'Thallium', 7829, 'Intergalactic Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (227019, 'Titanium', 1187, 'Interstellar Supply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (91805, 'Titanium', 8128, 'RocketParts Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (798033, 'Oganesson', 7588, 'Constellation Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (766733, 'Plutonium', 3747, 'Orbital Manufacturing');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (746026, 'Yttrium Silicide', 9197, 'AstroManufacturing Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (119169, 'Thulium Arsenide', 5703, 'Celestial Supplies Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (182325, 'Beryllium', 7400, 'DeepSpace Parts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (501436, 'Silicon', 3755, 'Interstellar Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (707573, 'Neodymium', 2162, 'Nova Manufacturing');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (340137, 'Calcium', 2485, 'Eclipse Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (597283, 'Beryllium Oxide', 8418, 'AstroSupply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (102953, 'Yttrium Boride', 2991, 'LunarParts Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (49877, 'Lithium', 8076, 'Spacemakers Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (327935, 'Sodium', 217, 'Spacetech Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (497238, 'Alumina', 7663, 'Cosmos Parts Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (715310, 'Tin', 5900, 'SolarParts Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (977755, 'Dysprosium Silicide', 1579, 'Satellite Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (281768, 'Dysprosium Oxide', 7140, 'Stellar Manufacturing');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (571872, 'Silicon', 992, 'SpaceComponent Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (577264, 'Uranium', 606, 'Nova Manufacturing');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (900129, 'Erbium Aluminum Oxide', 8341, 'Cosmos Parts Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (964314, 'Lead', 2358, 'Rocketry Tech Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (683718, 'Aluminum Oxynitride', 7478, 'Spacetech Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (959794, 'Californium', 3294, 'Rocketry Parts Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (367522, 'Chromium Boride', 9429, 'Aerospace Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (639232, 'Magnesium', 225, 'SpaceMaterials Corp');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (805663, 'Beryllium Oxide', 3778, 'AstroSupply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (103610, 'Yttrium Boride', 2578, 'ExoTech Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (9555, 'Cerium Phosphide', 5684, 'Planetary Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (8655, 'Sodium', 4712, 'Exoplanet Supplies');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (958442, 'Titanium Aluminide', 8514, 'Spacemakers Ltd');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (156642, 'Holmium Silicide', 3878, 'DeepSpace Components');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (472453, 'Nobelium', 2103, 'Pulsar Supplies Co');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (150690, 'Lanthanum Aluminum Oxynitride', 3783, 'Interstellar Supply Chain');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (148144, 'Scandium Nitride', 6646, 'Rocketry Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (111554, 'Cerium Antimonide', 3796, 'SpaceComponent Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (356544, 'Scandium Nitride', 2204, 'AstroManufacturing Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (456925, 'Samarium Aluminum Oxide', 3771, 'LunarParts Solutions');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (303708, 'Europium', 3845, 'Galactic Innovations');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (743230, 'Dysprosium Arsenide', 4494, 'InterSpace Materials');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (153756, 'Samarium Antimonide', 2406, 'Celestial Innovations');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (569924, 'Cerium Sulfide', 3756, 'Rocketry Parts Inc');
insert into RAW_MARETIALS (material_id, material_name, quantity_in_stock, supplier)
values (214426, 'Dysprosium Carbide', 874, 'NovaParts Ltd');
commit;
prompt 400 records loaded
prompt Loading WAREHOUSES...
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (726696, 'Evansville', 13511, 5752);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (579426, 'Downey', 13414, 7967);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (781435, 'MN', 12168, 6920);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (525482, 'Arvada', 12443, 5500);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (3888, 'Reno', 10638, 7240);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (25416, 'Huntington Beach', 13374, 9677);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (316728, 'Midland', 14548, 5579);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (680278, 'Pompano Beach', 14444, 9443);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (430533, 'CA', 13637, 7936);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (780387, 'FL', 10671, 9227);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (99644, 'CA', 13742, 7343);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (217444, 'CA', 12875, 9006);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (190519, 'VA', 10336, 6597);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (209133, 'NC', 13247, 7188);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (562600, 'Mobile', 13646, 8798);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (836242, 'MI', 12490, 6307);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (761671, 'Norman', 10309, 5694);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (392265, 'ND', 13522, 6523);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (525713, 'NC', 11619, 8846);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (545510, 'Thornton', 11736, 6946);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (103267, 'Augusta', 13310, 8601);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (313716, 'Boston', 11831, 9767);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (384291, 'Kent', 11918, 5882);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (851152, 'CA', 11195, 7194);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (843523, 'Buffalo', 12707, 6784);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (48238, 'NY', 14863, 6217);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (296339, 'CA', 14139, 9989);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (943642, 'WA', 12021, 6174);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (467108, 'NJ', 13929, 6986);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (948904, 'CA', 14095, 9126);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (370057, 'CT', 11648, 5117);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (885529, 'Salt Lake City', 14376, 8056);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (502628, 'Ann Arbor', 12895, 8418);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (834608, 'Gilbert', 14232, 7876);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (851339, 'TN', 10027, 6282);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (798926, 'Oklahoma City', 10866, 9240);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (710142, 'Rochester', 14457, 9941);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (177565, 'CO', 11645, 5180);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (311279, 'Berkeley', 10506, 6742);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (53021, 'Bend', 14986, 5546);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (268649, 'CA', 10832, 7259);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (290808, 'Arvada', 12808, 9265);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (833660, 'Huntington Beach', 13403, 5192);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (451569, 'OH', 14548, 9402);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (963595, 'Sugar Land', 10046, 5104);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (515690, 'Conroe', 12733, 6052);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (202465, 'Lincoln', 11558, 7949);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (420400, 'IA', 10123, 7025);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (374373, 'Cape Coral', 14368, 9426);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (409387, 'Midland', 13411, 6355);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (89370, 'Visalia', 13775, 6138);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (194909, 'Green Bay', 13482, 5618);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (61818, 'Moreno Valley', 13743, 9573);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (932394, 'KS', 12246, 8062);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (241246, 'OR', 13257, 7883);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (7564, 'Costa Mesa', 11025, 5551);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (755713, 'San Bernardino', 14240, 5488);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (636027, 'MA', 10499, 8323);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (667662, 'VA', 11042, 5490);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (275403, 'Santa Rosa', 12226, 7552);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (542285, 'KS', 11480, 9893);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (849920, 'Reading', 11716, 5737);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (828379, 'CA', 14446, 7641);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (787534, 'Greenville', 13068, 9891);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (51708, 'MN', 14079, 5471);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (869530, 'Paterson', 10173, 7544);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (820857, 'MN', 10494, 6574);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (892637, 'Fairfield', 14480, 5568);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (645599, 'FL', 12082, 7064);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (143634, 'NV', 14313, 6805);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (567747, 'Surprise', 14362, 5275);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (686460, 'Fargo', 10772, 9508);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (604521, 'Augusta', 10404, 8852);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (461826, 'WA', 10176, 9599);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (4400, 'NE', 12812, 9666);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (199322, 'CO', 13080, 5736);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (315483, 'WA', 12265, 6541);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (142025, 'AZ', 14848, 7199);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (266356, 'Elgin', 12630, 5789);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (583612, 'WA', 12795, 9576);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (459440, 'Clearwater', 12628, 9559);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (217968, 'NJ', 14889, 8271);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (876857, 'Clearwater', 14066, 6997);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (301292, 'West Covina', 10006, 9828);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (198790, 'Glendale', 11636, 8230);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (626711, 'Cary', 14774, 6053);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (934337, 'CA', 14268, 6140);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (311390, 'Thornton', 11937, 5965);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (364878, 'DC', 13051, 5975);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (396134, 'Durham', 10331, 5548);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (299926, 'MO', 10719, 7753);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (257507, 'Stockton', 11380, 5317);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (645493, 'Detroit', 12691, 6490);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (832433, 'Indianapolis', 12181, 5706);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (784948, 'CA', 14681, 5240);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (655314, 'Pembroke Pines', 10139, 5255);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (772372, 'NC', 11866, 5938);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (707629, 'FL', 14170, 6619);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (338425, 'Sterling Heights', 14624, 8069);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (80053, 'Aurora', 12462, 5383);
commit;
prompt 100 records committed...
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (708695, 'Seattle', 10818, 5135);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (447058, 'Fairfield', 11806, 6700);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (234571, 'Costa Mesa', 14668, 8951);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (354033, 'NY', 13481, 9725);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (836587, 'Birmingham', 12156, 6737);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (316881, 'CA', 10705, 9878);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (260297, 'San Antonio', 13021, 6035);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (734137, 'Coral Springs', 12651, 8908);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (144621, 'Elk Grove', 14296, 7431);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (611576, 'TX', 10020, 7778);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (902711, 'San Jose', 10416, 5090);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (99319, 'Riverside', 12185, 7356);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (415311, 'Arlington', 14895, 5115);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (841443, 'WA', 10883, 6918);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (536613, 'Chicago', 13547, 6696);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (138098, 'Tyler', 10491, 5473);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (21352, 'NC', 12101, 6566);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (477951, 'IL', 14231, 6799);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (691060, 'CA', 13447, 8285);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (550467, 'CA', 13732, 5304);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (466503, 'AL', 14792, 8059);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (53412, 'Rochester', 13111, 8857);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (257941, 'Ontario', 12403, 5308);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (485020, 'Frisco', 13692, 6677);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (892374, 'Cleveland', 11513, 5828);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (275962, 'CA', 13975, 5442);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (218108, 'West Valley City', 10640, 8410);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (420202, 'Palm Bay', 13498, 8578);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (391853, 'Hialeah', 12478, 9290);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (918354, 'TX', 13258, 8354);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (978345, 'CA', 11349, 9405);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (33549, 'Springfield', 12687, 5795);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (862446, 'Manchester', 12217, 9461);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (359784, 'CA', 13205, 8415);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (973758, 'Omaha', 11262, 7813);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (702791, 'KS', 13319, 5740);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (823731, 'WI', 13022, 6157);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (773391, 'FL', 10301, 7669);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (855271, 'Waterbury', 14089, 8040);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (693356, 'CA', 13415, 5631);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (604854, 'Waco', 13379, 5173);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (313765, 'MO', 13715, 6561);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (677130, 'IN', 13953, 6568);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (345866, 'Virginia Beach', 10397, 9686);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (532034, 'AZ', 11409, 5474);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (304436, 'San Bernardino', 13730, 6125);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (84399, 'Buffalo', 13832, 9141);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (263638, 'NC', 14525, 6304);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (116059, 'Westminster', 13306, 6379);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (425382, 'OR', 10188, 5177);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (500463, 'St. Louis', 13993, 7951);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (500184, 'Thousand Oaks', 12329, 5262);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (239786, 'Springfield', 11769, 9754);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (900525, 'MA', 10924, 7496);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (314530, 'Dallas', 10428, 8832);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (746712, 'TN', 10055, 9891);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (345644, 'IL', 14447, 7193);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (685235, 'CA', 10201, 9014);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (69125, 'Hayward', 13301, 8440);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (519627, 'Frisco', 12098, 9272);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (623131, 'TX', 12369, 7212);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (653823, 'Eugene', 12154, 5006);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (647594, 'Fresno', 10371, 6445);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (348025, 'Peoria', 14438, 5417);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (196320, 'Buffalo', 13389, 7433);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (787050, 'Kent', 14220, 7276);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (461605, 'Clearwater', 10441, 7717);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (961200, 'Modesto', 13081, 5466);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (311346, 'CA', 10618, 6771);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (359618, 'Clearwater', 10581, 6339);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (638644, 'SC', 11790, 9514);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (476144, 'Clovis', 12494, 8866);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (523921, 'CA', 10864, 7623);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (127678, 'North Charleston', 10599, 8619);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (209521, 'MO', 10613, 8668);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (585038, 'Allentown', 14044, 9557);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (886825, 'TX', 13067, 8054);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (516323, 'TX', 12256, 8626);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (295861, 'Tucson', 14459, 8775);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (742764, 'Denton', 14435, 8169);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (137409, 'Jacksonville', 11740, 8986);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (807093, 'OR', 10587, 6151);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (297613, 'TN', 10662, 7380);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (354396, 'Temecula', 14144, 9202);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (885092, 'MS', 10405, 6386);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (325475, 'Sparks', 11122, 8453);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (80546, 'Mesa', 14789, 8168);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (962704, 'NC', 10862, 8214);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (798866, 'Meridian', 10029, 8451);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (628397, 'Columbus', 13321, 7439);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (163748, 'Escondido', 14070, 8146);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (435656, 'Abilene', 12930, 9014);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (794794, 'TX', 12464, 7798);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (691737, 'Columbia', 14013, 6860);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (907128, 'Coral Springs', 10835, 9837);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (153911, 'Chesapeake', 12771, 5842);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (223506, 'SC', 13882, 8649);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (97816, 'TN', 10829, 9496);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (698917, 'AL', 10959, 8460);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (198325, 'Fargo', 10338, 5561);
commit;
prompt 200 records committed...
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (57704, 'Sunnyvale', 13215, 9022);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (222899, 'TX', 10649, 9340);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (143163, 'Costa Mesa', 12291, 9126);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (537450, 'Fresno', 11543, 9846);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (79661, 'Berkeley', 10590, 7914);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (424699, 'NC', 13030, 8791);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (247237, 'Durham', 13097, 9018);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (215035, 'IL', 11699, 7364);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (68719, 'TX', 10769, 7494);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (229873, 'Boulder', 13647, 5837);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (609328, 'Little Rock', 10492, 9585);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (537519, 'Toledo', 13955, 5972);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (988790, 'Cambridge', 11586, 5284);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (521523, 'IL', 12733, 6247);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (605947, 'Birmingham', 13886, 8723);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (261542, 'WA', 12732, 9896);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (175861, 'Cleveland', 12381, 6353);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (412620, 'CA', 14292, 6095);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (920103, 'Spokane', 14841, 5888);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (612001, 'MO', 13507, 8429);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (536069, 'Boulder', 10612, 6835);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (69456, 'FL', 13946, 7267);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (351996, 'TX', 12289, 7542);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (841567, 'TX', 14225, 7048);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (163394, 'PA', 13664, 5369);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (675169, 'CA', 14868, 8302);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (419882, 'OR', 10919, 6182);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (388199, 'Victorville', 10907, 5687);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (262306, 'CO', 12268, 7551);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (63060, 'San Antonio', 11063, 8841);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (372342, 'Lexington', 14148, 9751);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (52479, 'WI', 13470, 6040);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (634609, 'Irving', 13993, 9585);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (797869, 'IA', 12971, 5676);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (611277, 'Clinton', 14555, 7013);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (460186, 'Lincoln', 14979, 5544);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (829177, 'Glendale', 14793, 9596);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (363286, 'IA', 10893, 9941);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (879409, 'El Paso', 12325, 9749);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (249792, 'AZ', 10086, 9575);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (329455, 'VA', 12441, 9814);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (349445, 'Columbia', 13443, 9296);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (447781, 'NY', 13682, 9938);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (259968, 'CA', 13472, 8628);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (740955, 'NC', 14973, 8765);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (640423, 'Portland', 10973, 5119);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (303253, 'TX', 14328, 6946);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (717076, 'Aurora', 13273, 5508);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (978764, 'CA', 14115, 8454);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (601747, 'MO', 14017, 9693);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (336009, 'Fargo', 12878, 9717);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (422677, 'TX', 14528, 7520);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (455038, 'WI', 13731, 6557);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (267885, 'CA', 11727, 8387);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (527051, 'Costa Mesa', 14303, 8954);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (941025, 'CA', 12614, 8650);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (266500, 'Durham', 13256, 8605);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (529751, 'PA', 10312, 6852);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (135703, 'Columbia', 13361, 9313);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (786570, 'Fairfield', 11680, 6757);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (381947, 'Los Angeles', 11133, 5173);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (322207, 'AK', 11474, 8204);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (887106, 'TX', 13039, 6586);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (611459, 'TX', 13088, 5761);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (829745, 'Green Bay', 13253, 9070);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (811558, 'MD', 10843, 5210);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (159728, 'ME', 12989, 9893);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (393030, 'Wichita Falls', 13850, 7828);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (885330, 'Allentown', 11387, 7519);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (583054, 'Glendale', 11421, 7484);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (172850, 'VA', 12965, 8862);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (621321, 'MN', 10062, 5557);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (258710, 'Pearland', 11630, 9354);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (828393, 'Palmdale', 12013, 8661);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (174077, 'Cedar Rapids', 11260, 5825);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (486563, 'TX', 10350, 9174);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (281961, 'Austin', 12837, 7201);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (533215, 'CA', 10667, 8596);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (626833, 'Carlsbad', 13149, 8002);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (66682, 'Fontana', 14298, 8708);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (96730, 'CA', 10055, 9668);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (664607, 'PA', 13114, 5545);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (397864, 'Glendale', 14316, 9685);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (514800, 'Greenville', 10887, 6189);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (841735, 'CA', 12971, 8531);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (358601, 'Des Moines', 11201, 8359);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (944735, 'Newport News', 14301, 9431);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (246736, 'FL', 11940, 7832);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (840264, 'AZ', 14337, 5923);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (107676, 'High Point', 11332, 8663);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (503333, 'Killeen', 14935, 7245);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (128500, 'FL', 10553, 6222);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (787675, 'CA', 13417, 6522);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (948251, 'Fort Lauderdale', 12903, 8049);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (275361, 'CA', 13773, 6774);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (663801, 'CA', 14533, 7506);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (938898, 'FL', 14421, 9737);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (648199, 'Lowell', 11741, 5262);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (615847, 'FL', 12538, 7487);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (181542, 'MS', 14835, 8575);
commit;
prompt 300 records committed...
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (295931, 'CA', 14943, 6893);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (894329, 'CA', 13543, 8391);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (220639, 'New Haven', 10554, 6865);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (23323, 'Wichita Falls', 14004, 9257);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (795342, 'CO', 14398, 8426);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (479903, 'Akron', 12309, 7048);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (313901, 'Santa Clarita', 13187, 7591);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (730935, 'Columbus', 14608, 9502);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (495772, 'CO', 12458, 6062);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (492123, 'Escondido', 13783, 9566);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (835621, 'St. Petersburg', 10277, 9735);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (233870, 'Seattle', 12676, 6566);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (765430, 'CA', 12496, 5012);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (499638, 'CA', 13889, 5176);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (629107, 'CA', 14583, 7942);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (36810, 'UT', 11138, 7208);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (469597, 'IL', 10012, 6154);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (740044, 'Odessa', 12172, 6206);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (628488, 'Gilbert', 10214, 8621);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (407136, 'College Station', 13260, 9868);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (158123, 'Jackson', 11085, 8223);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (307380, 'Columbus', 10230, 5258);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (46210, 'NE', 11070, 7130);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (562424, 'CA', 11082, 6856);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (252929, 'FL', 10796, 9996);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (339632, 'Abilene', 10155, 7400);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (560542, 'Arvada', 14279, 9964);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (857942, 'IL', 13859, 6547);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (235506, 'Shreveport', 11677, 7484);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (206230, 'Columbus', 12970, 7354);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (503074, 'MO', 13631, 6945);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (974158, 'Fargo', 11490, 5559);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (834414, 'IL', 12141, 6116);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (695549, 'CA', 12064, 6685);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (46214, 'CT', 13023, 8406);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (104233, 'Lafayette', 12965, 5946);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (212787, 'Beaumont', 14923, 7928);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (202412, 'Downey', 11635, 5982);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (390690, 'FL', 14890, 7381);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (141521, 'AZ', 14798, 7385);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (155826, 'KS', 10516, 8748);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (915584, 'Detroit', 10122, 7054);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (953054, 'Saint Paul', 13643, 6793);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (867075, 'CO', 14463, 9359);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (258304, 'OK', 10613, 5387);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (5278, 'Chula Vista', 13647, 5110);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (553176, 'Chattanooga', 14110, 6637);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (137143, 'WA', 13836, 8351);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (112062, 'CO', 11536, 7827);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (810649, 'FL', 14445, 5953);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (601745, 'Corona', 14972, 6174);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (70666, 'NY', 12627, 5029);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (493514, 'Lubbock', 12682, 6402);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (27303, 'Boston', 14313, 8162);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (287772, 'CA', 12198, 6114);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (236781, 'TN', 11822, 6432);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (551144, 'Sioux City', 14954, 8993);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (894784, 'New York', 13036, 5281);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (766087, 'Springfield', 12486, 5803);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (842322, 'TX', 12121, 8159);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (993004, 'Bakersfield', 14202, 8211);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (384088, 'AZ', 11832, 8011);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (344844, 'CA', 11698, 5414);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (919317, 'WA', 12369, 6555);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (274220, 'FL', 14660, 8587);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (385151, 'Kansas City', 11789, 6389);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (673012, 'West Valley City', 13301, 8134);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (512490, 'Gresham', 13001, 5900);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (784483, 'Clearwater', 12385, 8759);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (894357, 'Spokane', 12298, 6986);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (927883, 'Irvine', 11799, 7346);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (866758, 'Knoxville', 14476, 5597);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (35562, 'Fresno', 13691, 8656);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (202037, 'Mesa', 14494, 5083);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (2572, 'MI', 11174, 8825);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (614737, 'Antioch', 10713, 7358);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (848787, 'Pompano Beach', 13589, 6691);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (79964, 'CA', 14691, 6870);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (693507, 'NV', 13326, 7919);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (964236, 'CA', 12534, 7392);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (542567, 'AZ', 14222, 6946);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (968856, 'CA', 12824, 6622);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (887944, 'Newark', 11503, 6739);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (885760, 'FL', 11095, 8593);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (119875, 'Clinton', 13306, 6359);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (165881, 'McKinney', 10882, 8897);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (751456, 'Palmdale', 13747, 6346);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (300008, 'CA', 11327, 7725);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (455758, 'UT', 12566, 6911);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (12147, 'Irving', 11348, 5715);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (915435, 'NC', 11325, 8941);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (265377, 'SC', 10373, 7615);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (484832, 'San Diego', 11172, 7816);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (80211, 'Westminster', 10634, 8754);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (664596, 'Aurora', 12170, 5044);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (165456, 'Norman', 11026, 9335);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (388783, 'CA', 14181, 7705);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (361572, 'IL', 12524, 6528);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (124472, 'Concord', 14319, 5696);
insert into WAREHOUSES (warehouse_id, warehouse_location, capacity, current_quantity)
values (896531, 'TN', 10165, 9391);
commit;
prompt 400 records loaded
prompt Enabling foreign key constraints for MACHINES...
alter table MACHINES enable constraint SYS_C009191;
prompt Enabling foreign key constraints for PRODUCTION_ORDERS...
alter table PRODUCTION_ORDERS enable constraint SYS_C009168;
prompt Enabling triggers for MACHINE_MAINTENANCE...
alter table MACHINE_MAINTENANCE enable all triggers;
prompt Enabling triggers for MACHINES...
alter table MACHINES enable all triggers;
prompt Enabling triggers for TOOLS...
alter table TOOLS enable all triggers;
prompt Enabling triggers for PRODUCTION_ORDERS...
alter table PRODUCTION_ORDERS enable all triggers;
prompt Enabling triggers for RAW_MARETIALS...
alter table RAW_MARETIALS enable all triggers;
prompt Enabling triggers for WAREHOUSES...
alter table WAREHOUSES enable all triggers;

set feedback on
set define on
prompt Done
