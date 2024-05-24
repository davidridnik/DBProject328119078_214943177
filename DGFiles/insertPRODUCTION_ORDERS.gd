
[General]
Version=1

[Preferences]
Username=
Password=2282
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=PRODUCTION_ORDERS
Count=400

[Record]
Name=PRODUCTION_ORDER_ID
Type=NUMBER
Size=
Data=Random(1, 999999)
Master=

[Record]
Name=TOOL_ID
Type=NUMBER
Size=
Data=List(select TOOL_ID from TOOLS)
Master=

[Record]
Name=QUANTITY
Type=NUMBER
Size=
Data=Random(0, 500)
Master=

[Record]
Name=START_DATE
Type=DATE
Size=
Data=Random(1/1/2000, 1/1/2020)
Master=

[Record]
Name=DUE_DATE
Type=DATE
Size=
Data=Random(1/1/2021, 1/1/2032)
Master=

[Record]
Name=STATUS
Type=VARCHAR2
Size=100
Data=List(Processing, Completed, Canceled, Pending, Shipped, On Hold)
Master=

