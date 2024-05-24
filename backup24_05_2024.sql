prompt PL/SQL Developer Export Tables for user SYS@XE
prompt Created by David on יום שישי 24 מאי 2024
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

prompt Disabling triggers for MACHINE_MAINTENANCE...
alter table MACHINE_MAINTENANCE disable all triggers;
prompt Deleting MACHINE_MAINTENANCE...
delete from MACHINE_MAINTENANCE;
commit;
prompt Loading MACHINE_MAINTENANCE...
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (3452, 41139, to_date('14-02-2022', 'dd-mm-yyyy'), 'Corrective Maintenance', 'In Progress');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (98534, 3888, to_date('29-06-2004', 'dd-mm-yyyy'), 'Safety Checks', 'In Progress');
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
commit;
prompt 100 records committed...
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (77618, 94802, to_date('14-10-2011', 'dd-mm-yyyy'), 'Cleaning Maintenance', 'Completed');
insert into MACHINE_MAINTENANCE (maintenance_id, machine_id, maintenance_date, maintenance_type, status)
values (10134, 13422, to_date('06-02-2014', 'dd-mm-yyyy'), 'Emergency Maintenance', 'Completed');
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
prompt Enabling triggers for MACHINE_MAINTENANCE...
alter table MACHINE_MAINTENANCE enable all triggers;

set feedback on
set define on
prompt Done
