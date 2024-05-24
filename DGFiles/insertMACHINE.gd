
[General]
Version=1

[Preferences]
Username=
Password=2823
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=MACHINES
Count=400

[Record]
Name=MACHINE_ID
Type=NUMBER
Size=
Data=Random(1, 99999)
Master=

[Record]
Name=MACHINE_NAME
Type=VARCHAR2
Size=100
Data=List(Lathe, Milling Machine, Grinding Machine, Drilling Machine, Router, Plasma Cutter, Laser Cutter, Water Jet Cutter, Machining Center, Turning Center, Swiss Machine, EDM Machine, Wire EDM, Sink EDM, Surface Grinder, Cylindrical Grinder, Gear Hobbing Machine, Gear Shaping Machine, Gear Grinding Machine, Boring Mill, Vertical Boring Mill, Horizontal Boring Mill, Broaching Machine, Honing Machine, Lapping Machine, Polishing Machine, Buffing Machine, Finishing Machine, Threading Machine, Spline Cutting Machine, Engraving Machine, Punching Machine, Stamping Machine, Press Brake, Shearing Machine, Bending Machine, Roll Forming Machine, Extrusion Machine, Injection Molding Machine, Blow Molding Machine, Thermoforming Machine, Rotational Molding Machine, Compression Molding Machine, Transfer Molding Machine, Foam Cutting Machine, 3D Printer, Additive Manufacturing Machine, Subtractive Manufacturing Machine, Assembly Machine, Welding Machine, Spot Welding Machine, Laser Welding Machine, Ultrasonic Welding Machine, Friction Stir Welding Machine, Electron Beam Welding Machine, Resistance Welding Machine, Soldering Machine, Brazing Machine, Cutting Machine, Slitting Machine, Sawing Machine, Band Saw, Circular Saw, Hacksaw, Abrasive Saw, Water Jet Saw, Wire Saw, Diamond Saw, Grit Blasting Machine, Sand Blasting Machine, Shot Blasting Machine, Bead Blasting Machine, Vibratory Finishing Machine, Tumbling Machine, Deburring Machine, Edge Rounding Machine, Surface Treatment Machine, Coating Machine, Painting Machine, Anodizing Machine, Electroplating Machine, Powder Coating Machine, Heat Treating Machine, Annealing Machine, Quenching Machine, Tempering Machine, Hardening Machine, Case Hardening Machine, Nitriding Machine, Carburizing Machine, Vacuum Heat Treating Machine, Induction Hardening Machine, Cryogenic Treatment Machine, Stress Relieving Machine, Shot Peening Machine, Peening Machine, Peeling Machine, Leveling Machine, Straightening Machine, Planer, Shaper, Slotter, Mortiser, Tenoner, Dovetailer, Spindle Moulder, Router Table, Edge Banding Machine, Panel Saw, Beam Saw, Cold Saw, Cut-off Saw, Miter Saw, Radial Arm Saw, Scroll Saw, Table Saw, Panel Bender, Panel Folding Machine, Tube Bender, Pipe Bender, Wire Bender, Bar Bender, Rebar Bender, Plate Bender, Sheet Metal Bender, Hydraulic Press, Mechanical Press, Servo Press, Punch Press, Forging Press, Stamping Press, Die Cutting Machine, Slitter Rewinder, Laminating Machine, Folding Machine, Bag Making Machine, Pouch Making Machine, Carton Making Machine, Box Making Machine, Case Making Machine, Label Making Machine, Tube Making Machine, Pipe Making Machine, Wire Drawing Machine, Bar Drawing Machine, Rod Drawing Machine, Tube Drawing Machine, Pipe Drawing Machine, Wire Rolling Machine, Bar Rolling Machine, Rod Rolling Machine, Tube Rolling Machine, Pipe Rolling Machine, Thread Rolling Machine, Spline Rolling Machine, Knurling Machine, Grooving Machine, Serrating Machine, Chamfering Machine, Facing Machine, Counterboring Machine, Countersinking Machine, Reaming Machine, Tapping Machine, Drilling and Tapping Machine, Milling and Drilling Machine, Turning and Milling Machine, Boring and Milling Machine, Grinding and Polishing Machine, Honing and Lapping Machine, Welding and Cutting Machine, Machining and Assembly Machine, Inspection Machine, Measuring Machine, Testing Machine, Calibration Machine, Alignment Machine, Balancing Machine, Noise Testing Machine, Vibration Testing Machine, Fatigue Testing Machine, Stress Testing Machine, Strain Testing Machine, Thermal Testing Machine, Environmental Testing Machine, Corrosion Testing Machine, Electrical Testing Machine, Optical Testing Machine, Acoustic Testing Machine, Mechanical Testing Machine, Metallurgical Testing Machine, Chemical Testing Machine, Physical Testing Machine, Non-Destructive Testing Machine, Destructive Testing Machine, Leak Testing Machine, Flow Testing Machine, Pressure Testing Machine, Vacuum Testing Machine, Burst Testing Machine, Tensile Testing Machine, Compression Testing Machine, Flexural Testing Machine, Impact Testing Machine, Hardness Testing Machine, Microhardness Testing Machine, Scratch Testing Machine, Wear Testing Machine, Abrasion Testing Machine, Erosion Testing Machine, Adhesion Testing Machine, Creep Testing Machine, Fracture Testing Machine, Fatigue Crack Growth Testing Machine, Residual Stress Testing Machine, Stress Corrosion Cracking Testing Machine, Hydrogen Embrittlement Testing Machine, Stress Rupture Testing Machine, Low Cycle Fatigue Testing Machine, High Cycle Fatigue Testing Machine, Thermal Cycling Testing Machine, Thermal Shock Testing Machine, Thermal Fatigue Testing Machine, Thermal Expansion Testing Machine, Thermal Conductivity Testing Machine, Heat Capacity Testing Machine, Thermomechanical Analysis Machine, Differential Scanning Calorimetry Machine, Thermogravimetric Analysis Machine, Dynamic Mechanical Analysis Machine, Rheology Testing Machine, Viscometer, Melt Flow Indexer, Capillary Rheometer, Rotational Rheometer, Oscillatory Rheometer, Extensional Rheometer, Extrusion Rheometer, Rheo-Optical Testing Machine, Rheo-SAXS, Rheo-WAXS, Rheo-IR, Rheo-Raman, Rheo-Dielectric Machine, Rheo-Microscopy Machine, Rheo-Tomography Machine, Rheo-Spectroscopy Machine)
Master=

[Record]
Name=INSTALLATION_DATE
Type=DATE
Size=
Data=Random(1/1/2000, 1/1/2024)
Master=

[Record]
Name=STATUS
Type=VARCHAR2
Size=100
Data=List(Operational, Idle, Under Maintenance, Malfunctioning, Standby, Shutdown, Calibration, Testing, In Production, Decommissioned)
Master=

[Record]
Name=MAINTENANCE_ID
Type=NUMBER
Size=
Data=List(select MAINTENANCE_ID from Machine_Maintenance)
Master=

