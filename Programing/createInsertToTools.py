import random
import datetime

# Generate a random date between 1/1/2000 and 1/1/2024
def random_date():
    start_date = datetime.date(2000, 1, 1)
    end_date = datetime.date(2024, 1, 1)
    return start_date + datetime.timedelta(days=random.randint(0, (end_date - start_date).days))

# List of real tool names used in aerospace industry, with a maximum of 2 words
tool_names = [
    "Torque Wrench", "Digital Caliper", "Micrometer", "Laser Level", "Dial Indicator", 
    "Feeler Gauge", "Protractor", "Angle Finder", "Ball Hammer", "Brass Hammer", 
    "Dead Hammer", "Chisels", "Punches", "Files", "Deburring Tool", 
    "Countersink Cutter", "Drill Bits", "Reamers", "Taps", "Tap Wrench", 
    "Die Holder", "Hex Keys", "Spline Keys", "Torque Screwdriver", 
    "Precision Screwdriver", "Soldering Iron", "Heat Gun", "Wire Strippers", 
    "Crimping Tool", "Cable Cutters", "Multimeter", "Oscilloscope", "Power Supply", 
    "Bench Magnifier", "ESD Mat", "ESD Strap", "Hardness Tester", 
    "Thickness Gauge", "Vibration Meter", "Sound Meter", "Thermal Imager", 
    "Infrared Thermometer", "Flow Meter", "Pressure Gauge", "Vacuum Gauge", 
    "Leak Detector", "Force Gauge", "Tensile Tester", "Impact Tester", 
    "Fatigue Tester", "Thermocouple", "RTD Sensor", "Data Logger", 
    "Chart Recorder", "Temperature Controller", "Humidity Controller", 
    "PLC", "HMI", "Robot Arm", "CNC Machine", "3D Printer", "Laser Cutter", 
    "Plasma Cutter", "CNC Lathe", "CNC Router", "Welding Machine", 
    "Laser Welder", "Spot Welder", "TIG Welder", "MIG Welder", 
    "Arc Welder", "Oxy Torch", "Soldering Station", "Fume Extractor", 
    "Handheld Grinder", "Bench Grinder", "Belt Sander", "Disc Sander", 
    "Orbital Sander", "Detail Sander", "Jigsaw", "Bandsaw", "Circular Saw", 
    "Table Saw", "Miter Saw", "Scroll Saw", "Track Saw", "Chainsaw", 
    "Tile Saw", "Wet Saw", "Concrete Saw", "Angle Grinder", "Rotary Tool", 
    "Impact Driver", "Cordless Drill", "Hammer Drill", "Magnetic Drill", 
    "Air Compressor", "Air Hose", "Air Tool", "Air Ratchet", 
    "Air Hammer", "Air Drill", "Air Grinder", "Air Sander", 
    "Air Polisher", "Hydraulic Jack", "Bottle Jack", "Floor Jack", 
    "Engine Crane", "Engine Stand", "Jack Stand", "Creeper", 
    "Mechanics Stool", "Tire Inflator", "Tire Changer", "Wheel Balancer", 
    "Brake Lathe", "Brake Bleeder", "Oil Pan", "Oil Wrench", 
    "Grease Gun", "Parts Washer", "Parts Cleaner", "Tool Box", 
    "Tool Chest", "Tool Cabinet", "Tool Cart", "Tool Belt", 
    "Tool Bag", "Tool Vest", "Tool Pouch", "Workbench", 
    "Bench Vise", "Pipe Vise", "Sawhorse", "Step Stool", 
    "Ladder", "Scaffolding", "Scissor Lift", "Boom Lift", 
    "Forklift", "Pallet Jack", "Hand Truck", "Dolly", 
    "Conveyor", "Chain Hoist", "Lever Hoist", "Electric Hoist", 
    "Winch", "Crane", "Rigging", "Slings", 
    "Shackles", "Hooks", "Ratchet Strap", "Load Binder", 
    "Cargo Net", "Cargo Bar", "Ratchet", "Socket", 
    "Extension Bar", "Universal Joint", "Breaker Bar", 
    "Flex Ratchet", "Combination Wrench", "Box Wrench", 
    "Flare Wrench", "Crowfoot Wrench", "Pipe Wrench", 
    "Allen Wrench", "Torx Wrench", "Pliers", 
    "Cutting Pliers", "Slip Pliers", "Locking Pliers", 
    "Snap Pliers", "Wire Cutters", "Bolt Cutters", 
    "Tin Snips", "Sheet Shear", "Sheet Roller", 
    "Punch Machine", "Swaging Machine", "Body Hammer", 
    "Slide Hammer", "Puller Set", "Gear Puller", 
    "Bearing Puller", "Joint Press", "Drift Punch", 
    "Center Punch", "Pin Punch", "Punch Set", 
    "Hex Key", "Torx Key", "Screwdriver Set", 
    "Carbide Burr", "Router Bit", "Hole Saw", 
    "Jigsaw Blade", "Saw Blade", "Razor Blade", 
    "Utility Knife", "Safety Knife", "Paint Scraper", 
    "Chisel Set", "Wood Chisel", "Mortise Chisel", 
    "Cold Chisel", "Glass Cutter", "Wire Stripper", 
    "Cable Stripper", "Tube Cutter", "Pipe Cutter", 
    "PVC Cutter", "Copper Cutter", "Brake Cutter", 
    "Fuel Cutter", "Hose Cutter", "Torque Wrench", "Digital Caliper", "Micrometer", "Laser Level", "Dial Indicator", 
    "Feeler Gauge", "Protractor", "Angle Finder", "Ball Hammer", "Brass Hammer", 
    "Dead Hammer", "Chisels", "Punches", "Files", "Deburring Tool", 
    "Countersink Cutter", "Drill Bits", "Reamers", "Taps", "Tap Wrench", 
    "Die Holder", "Hex Keys", "Spline Keys", "Torque Screwdriver", 
    "Precision Screwdriver", "Soldering Iron", "Heat Gun", "Wire Strippers", 
    "Crimping Tool", "Cable Cutters", "Multimeter", "Oscilloscope", "Power Supply", 
    "Bench Magnifier", "ESD Mat", "ESD Strap", "Hardness Tester", 
    "Thickness Gauge", "Vibration Meter", "Sound Meter", "Thermal Imager", 
    "Infrared Thermometer", "Flow Meter", "Pressure Gauge", "Vacuum Gauge", 
    "Leak Detector", "Force Gauge", "Tensile Tester", "Impact Tester", 
    "Fatigue Tester", "Thermocouple", "RTD Sensor", "Data Logger", 
    "Chart Recorder", "Temperature Controller", "Humidity Controller", 
    "PLC", "HMI", "Robot Arm", "CNC Machine", "3D Printer", "Laser Cutter", 
    "Plasma Cutter", "CNC Lathe", "CNC Router", "Welding Machine", 
    "Laser Welder", "Spot Welder", "TIG Welder", "MIG Welder", 
    "Arc Welder", "Oxy Torch", "Soldering Station", "Fume Extractor", 
    "Handheld Grinder", "Bench Grinder", "Belt Sander", "Disc Sander", 
    "Orbital Sander", "Detail Sander", "Jigsaw", "Bandsaw", "Circular Saw", 
    "Table Saw", "Miter Saw", "Scroll Saw", "Track Saw", "Chainsaw", 
    "Tile Saw", "Wet Saw", "Concrete Saw", "Angle Grinder", "Rotary Tool", 
    "Impact Driver", "Cordless Drill", "Hammer Drill", "Magnetic Drill", 
    "Air Compressor", "Air Hose", "Air Tool", "Air Ratchet", 
    "Air Hammer", "Air Drill", "Air Grinder", "Air Sander", 
    "Air Polisher", "Hydraulic Jack", "Bottle Jack", "Floor Jack", 
    "Engine Crane", "Engine Stand", "Jack Stand", "Creeper", 
    "Mechanics Stool", "Tire Inflator", "Tire Changer", "Wheel Balancer", 
    "Brake Lathe", "Brake Bleeder", "Oil Pan", "Oil Wrench", 
    "Grease Gun", "Parts Washer", "Parts Cleaner", "Tool Box", 
    "Tool Chest", "Tool Cabinet", "Tool Cart", "Tool Belt", 
    "Tool Bag", "Tool Vest", "Tool Pouch", "Workbench", 
    "Bench Vise", "Pipe Vise", "Sawhorse", "Step Stool", 
    "Ladder", "Scaffolding", "Scissor Lift", "Boom Lift", 
    "Forklift", "Pallet Jack", "Hand Truck", "Dolly", 
    "Conveyor", "Chain Hoist", "Lever Hoist", "Electric Hoist", 
    "Winch", "Crane", "Rigging", "Slings", 
    "Shackles", "Hooks", "Ratchet Strap", "Load Binder", 
    "Cargo Net", "Cargo Bar", "Ratchet", "Socket", 
    "Extension Bar", "Universal Joint", "Breaker Bar", 
    "Flex Ratchet", "Combination Wrench", "Box Wrench", 
    "Flare Wrench", "Crowfoot Wrench", "Pipe Wrench", 
    "Allen Wrench", "Torx Wrench", "Pliers", 
    "Cutting Pliers", "Slip Pliers", "Locking Pliers", 
    "Snap Pliers", "Wire Cutters", "Bolt Cutters", 
    "Tin Snips", "Sheet Shear", "Sheet Roller", 
    "Punch Machine", "Swaging Machine", "Body Hammer", 
    "Slide Hammer", "Puller Set", "Gear Puller", 
    "Bearing Puller", "Joint Press", "Drift Punch", 
    "Center Punch", "Pin Punch", "Punch Set", 
    "Hex Key", "Torx Key", "Screwdriver Set", 
    "Carbide Burr", "Router Bit", "Hole Saw", 
    "Jigsaw Blade", "Saw Blade", "Razor Blade", 
    "Utility Knife", "Safety Knife", "Paint Scraper", 
    "Chisel Set", "Wood Chisel", "Mortise Chisel", 
    "Cold Chisel", "Glass Cutter", "Wire Stripper", 
    "Cable Stripper", "Tube Cutter", "Pipe Cutter", 
    "PVC Cutter", "Copper Cutter", "Brake Cutter", 
    "Fuel Cutter", "Hose Cutter"
]

# Fill up to 400 tool names with invented names if necessary
while len(tool_names) < 400:
    tool_names.append(f"Tool_{len(tool_names) + 1}")

# Open a file to write the SQL inserts
with open("insert_tools.sql", "w") as file:
    file.write("CREATE TABLE Tools (\n")
    file.write("  Tool_ID INT NOT NULL,\n")
    file.write("  Tool_Name varchar2(100) NOT NULL,\n")
    file.write("  Manufacture_Date DATE NOT NULL,\n")
    file.write("  Status varchar2(100) NOT NULL,\n")
    file.write("  PRIMARY KEY (Tool_ID)\n")
    file.write(");\n\n")
    
    for tool_id in range(1, 401):
        tool_name = tool_names[tool_id - 1]
        manufacture_date = random_date().strftime('%Y-%m-%d')
        status = random.choice(["Available", "In Use", "Maintenance", "Retired"])
        insert_statement = f"INSERT INTO Tools (Tool_ID, Tool_Name, Manufacture_Date, Status) VALUES ({tool_id}, '{tool_name}', TO_DATE('{manufacture_date}', 'YYYY-MM-DD'), '{status}');\n"
        file.write(insert_statement)
