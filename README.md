This program is a Cyber Cafe Management System written in Assembly Language using the Irvine32 library.
It allows users to register customers, add new computers to the record, start and end sessions, and display customer and computer inventories.
The program uses a menu-driven interface to guide users through various operations.

**Files Included**

cybercafe.asm: The main assembly source file containing the entire program code.

irvine32.inc: The include file for the Irvine32 library (not provided, should be included from the Irvine32 package).

**Features**

Welcome Page: Displays a welcome message to the user.

Main Menu: Offers options to register a customer, add a new computer, display customer inventory, display computer inventory, and exit the program.

Customer Registration: Allows users to input customer information (name and contact number) and stores it.

Computer Registration: Allows users to add new computers to the inventory by assigning an ID.

Session Management: Allows users to start and end sessions, displaying session start and end times, duration, and charges.

Display Inventory: Displays the list of registered customers and computers.

**Navigating the Menu**

Welcome Screen: The program starts by displaying a welcome message.

Main Menu: Choose an option by entering the corresponding number:

1: Register a Customer.

2: Add a New Computer in Record.

3: Display Customer Inventory.

4: Display Computer Inventory.

5: Exit the Program.

Registering a Customer

Follow the prompts to enter the customer's full name and contact number.
Successful registration will be acknowledged with a confirmation message.
After registration, the second menu will be displayed with options to start a session, end a session, or exit to the main menu.

Adding a Computer

Enter the computer ID when prompted.
Successful entry will be acknowledged with a confirmation message.

Session Management

Start Session: Displays the current system time as the session start time.

End Session: Displays the current system time as the session end time, calculates the session duration, and charges.

Displaying Inventories

Customer Inventory: Lists all registered customers with their names and contact numbers.

Computer Inventory: Lists all registered computers with their IDs.

Exiting the Program

Choose the exit option from the main menu to terminate the program.

**Code Structure**

**Data Segment**

Welcome Page Strings: Strings used for the welcome message.
Menu Strings: Strings for the main and secondary menus.
Customer and Computer Data: Arrays to store customer names, contact numbers, and computer IDs.
Session Data: Variables to store session start and end times, duration, and charges.
Other Strings: Strings for various prompts and messages displayed during the program execution.

**Code Segment**

Main Procedure: The entry point of the program, handling the main loop and menu navigation.
Procedures:
welcome: Displays the welcome message.
displaymenu: Displays the main menu.
registerCustomer: Handles customer registration.
registerComputer: Handles computer registration.
startSession: Starts a session, recording the start time.
endSession: Ends a session, calculating duration and charges.
display_loop: Displays customer inventory.
displayComputers: Displays computer inventory.
exitProgram: Handles program termination.
secondmenu: Displays the secondary menu after customer registration.
displaySession: Displays session duration and charges.

**Notes**

Ensure the Irvine32 library is correctly installed and included in your project setup.
The program uses DOS interrupts and Windows API calls (e.g., GetSystemTime) to manage inputs and outputs, which are specific to the Irvine32 library.
