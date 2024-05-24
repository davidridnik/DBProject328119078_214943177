
[General]
Version=1

[Preferences]
Username=
Password=2578
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=MACHINE_MAINTENANCE
Count=400

[Record]
Name=MAINTENANCE_ID
Type=NUMBER
Size=
Data=Random(1, 99999)
Master=

[Record]
Name=MACHINE_ID
Type=NUMBER
Size=
Data=Random(1, 99999)
Master=

[Record]
Name=MAINTENANCE_DATE
Type=DATE
Size=
Data=Random(1/1/2000, 1/1/2024)
Master=

[Record]
Name=MAINTENANCE_TYPE
Type=VARCHAR2
Size=100
Data=List(Preventive Maintenance, Corrective Maintenance, Predictive Maintenance, Routine Maintenance, Emergency Maintenance, Scheduled Maintenance, Unscheduled Maintenance, Condition-Based Maintenance, Lubrication Maintenance, Calibration Maintenance, Inspection Maintenance, Overhaul Maintenance, Replacement Maintenance, Alignment Maintenance, Cleaning Maintenance, Safety Checks)
Master=

[Record]
Name=STATUS
Type=VARCHAR2
Size=100
Data=List(Pending, In Progress, Completed, On Hold, Cancelled, Failed)
Master=

