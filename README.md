Database Schema Presentation
1. Overview of the Schema
Our database schema is designed to manage a train booking system in Kenya. It encompasses all necessary entities, relationships, and constraints to provide a comprehensive solution for booking, scheduling, and feedback collection.
________________________________________
2. Key Objectives
•	Efficiently manage train schedules, routes, and bookings.
•	Handle payments, feedback, and user roles (e.g., customers and admins).
•	Ensure data integrity and consistency through relationships and constraints.
________________________________________
3. Tables and Their Roles
1.	Users Table
o	Purpose: Stores information about all users, including customers and admins.
o	Key Features:
	Differentiates user roles (e.g., Admin, Customer) using the user_type column.
	Ensures unique emails and secure password storage.
2.	Admin Table
o	Purpose: Manages the administrative details for train operations.
o	Key Features: Includes admin roles like Super Admin or Manager.
3.	Station Table
o	Purpose: Represents train stations with unique codes and geographic locations.
o	Key Features: Stations are linked to train journeys through routes.
4.	Train Table
o	Purpose: Stores details about trains, including routes and seat availability.
o	Key Features:
	Tracks train types (e.g., Express, Passenger).
	Links departure and arrival stations.
5.	Route Table
o	Purpose: Maps stations to specific train journeys, defining stop order, arrival, and departure times.
o	Key Features:
	Supports many-to-many relationships between stations and trains.
6.	Booking Table
o	Purpose: Manages bookings made by users for specific train journeys.
o	Key Features:
	Tracks booking status (e.g., Confirmed, Cancelled) and payment status.
	Associates bookings with users, trains, and stations.
7.	Ticket Table
o	Purpose: Issues tickets for bookings, tracking seat numbers and ticket classes.
o	Key Features:
	Supports different ticket classes (e.g., First Class, Economy).
	Tracks ticket prices and issuance dates.
8.	Payment Table
o	Purpose: Manages payment records for bookings.
o	Key Features:
	Tracks payment methods (e.g., Mobile Money, Credit Card).
	Ensures secure and unique transaction IDs.
9.	Feedback Table
o	Purpose: Collects feedback from users regarding their train journeys.
o	Key Features:
	Allows rating submissions (1-5 stars).
	Links feedback to specific bookings and users.
10.	Schedule Table
o	Purpose: Defines schedules for train journeys.
o	Key Features:
	Tracks journey dates and times.
	Manages status (e.g., Scheduled, Delayed).
________________________________________
4. Key Relationships
•	One-to-Many Relationships:
o	Users → Bookings: A user can make multiple bookings.
o	Train → Routes: A train can have multiple routes.
o	Booking → Tickets: A booking can generate multiple tickets.
•	Many-to-Many Relationships:
o	Routes ↔ Stations: A route includes multiple stations, and a station can appear in multiple routes.
•	One-to-One Relationships:
o	Booking → Payment: Each booking has one associated payment record.
________________________________________
5. Constraints and Data Integrity
•	Primary Keys: Ensure unique identification for each table.
•	Foreign Keys: Establish relationships and maintain referential integrity.
•	Unique Constraints: Prevent duplicate entries (e.g., emails, ticket numbers).
•	Enum Constraints: Standardize specific column values (e.g., status, user_type).
•	Check Constraints: Enforce logical rules (e.g., rating BETWEEN 1 AND 5).
________________________________________
6. Sample Data (Kenyan Context)
•	Stations: Nairobi Central (NRB), Mombasa Terminus (MSA), Kisumu Station (KSM).
•	Trains: Madaraka Express (Nairobi to Mombasa), Western Explorer (Kisumu to Eldoret).
•	Users: John Mwangi, Jane Wanjiru (Customers); Admin One (Admin).
•	Payments: Mobile Money (M-Pesa), Credit Cards.
•	Feedback: Positive comments about timeliness and comfort.
________________________________________
7. How It Works
1.	User Workflow:
o	Users register and log in.
o	They search for trains, select a journey, and book tickets.
o	Payments are processed securely, and tickets are issued.
2.	Admin Workflow:
o	Admins manage trains, schedules, and routes.
o	They oversee bookings and review feedback for service improvement.
3.	Database Workflow:
o	The schema connects users, bookings, trains, and payments through efficient relationships.
o	Feedback is linked to journeys, allowing actionable insights.
________________________________________
8. Why This Schema Works
•	Scalability: Supports an increasing number of users, trains, and bookings.
•	Reliability: Maintains data integrity through strong relationships and constraints.
•	Flexibility: Adapts to future enhancements like loyalty programs or dynamic pricing.
•	Localized Relevance: Tailored to Kenya’s train system and popular payment methods like M-Pesa.
________________________________________
9. Conclusion
This schema is a robust foundation for managing a train booking system. It ensures seamless user experiences, efficient train operations, and actionable insights through feedback and data integration. Thank you!

