-- Create Users Table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    user_type ENUM('Admin', 'Customer') NOT NULL
);

-- Create Admin Table
CREATE TABLE Admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    role ENUM('Super Admin', 'Manager') NOT NULL
);

-- Create Station Table
CREATE TABLE Station (
    station_id INT AUTO_INCREMENT PRIMARY KEY,
    station_name VARCHAR(255) NOT NULL,
    station_code VARCHAR(50) UNIQUE NOT NULL,
    location GEOGRAPHY
);

-- Create Train Table
CREATE TABLE Train (
    train_id INT AUTO_INCREMENT PRIMARY KEY,
    train_name VARCHAR(255) NOT NULL,
    train_number VARCHAR(50) UNIQUE NOT NULL,
    departure_station INT,
    arrival_station INT,
    route TEXT,
    total_seats INT NOT NULL CHECK (total_seats > 0),
    available_seats INT NOT NULL CHECK (available_seats >= 0),
    train_type ENUM('Express', 'Passenger') NOT NULL,
    FOREIGN KEY (departure_station) REFERENCES Station(station_id),
    FOREIGN KEY (arrival_station) REFERENCES Station(station_id)
);

-- Create Route Table
CREATE TABLE Route (
    route_id INT AUTO_INCREMENT PRIMARY KEY,
    train_id INT NOT NULL,
    station_id INT NOT NULL,
    stop_number INT NOT NULL CHECK (stop_number > 0),
    arrival_time TIME NOT NULL,
    departure_time TIME NOT NULL,
    FOREIGN KEY (train_id) REFERENCES Train(train_id),
    FOREIGN KEY (station_id) REFERENCES Station(station_id)
);

-- Create Booking Table
CREATE TABLE Booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    train_id INT NOT NULL,
    departure_station INT NOT NULL,
    arrival_station INT NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    booking_date DATE NOT NULL,
    journey_date DATE NOT NULL,
    status ENUM('Confirmed', 'Cancelled', 'Waitlisted') NOT NULL,
    payment_status ENUM('Paid', 'Pending') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (train_id) REFERENCES Train(train_id),
    FOREIGN KEY (departure_station) REFERENCES Station(station_id),
    FOREIGN KEY (arrival_station) REFERENCES Station(station_id)
);

-- Create Ticket Table
CREATE TABLE Ticket (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    ticket_number VARCHAR(50) UNIQUE NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    class ENUM('First Class', 'Second Class', 'Economy') NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    issue_date DATE NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- Create Payment Table
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount >= 0),
    payment_method VARCHAR(50) NOT NULL,
    transaction_id VARCHAR(255) UNIQUE NOT NULL,
    payment_status ENUM('Success', 'Failed') NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- Create Feedback Table
CREATE TABLE Feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    booking_id INT NOT NULL,
    feedback_text TEXT,
    rating TINYINT CHECK (rating BETWEEN 1 AND 5),
    feedback_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- Create Schedule Table
CREATE TABLE Schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    train_id INT NOT NULL,
    journey_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    status ENUM('Scheduled', 'Delayed', 'Cancelled') NOT NULL,
    FOREIGN KEY (train_id) REFERENCES Train(train_id)
);

-- Populate Users Table
INSERT INTO Users (fullname, email, phone_number, password, user_type)
VALUES
    ('John Mwangi', 'john.mwangi@gmail.com', '+254712345678', 'hashed_password_1', 'Customer'),
    ('Jane Wanjiru', 'jane.wanjiru@gmail.com', '+254723456789', 'hashed_password_2', 'Customer'),
    ('David Kamau', 'david.kamau@gmail.com', '+254733333333', 'hashed_password_3', 'Admin');

-- Populate Admin Table
INSERT INTO Admin (fullname, email, phone_number, password, role)
VALUES
    ('Admin One', 'admin.one@gmail.com', '+254700111222', 'hashed_admin_password', 'Super Admin'),
    ('Admin Two', 'admin.two@gmail.com', '+254701333444', 'hashed_admin_password', 'Manager');

-- Populate Station Table
INSERT INTO Station (station_name, station_code, location)
VALUES
    ('Nairobi Central', 'NRB', '1.2921, 36.8219'),
    ('Mombasa Terminus', 'MSA', '-4.0351, 39.6662'),
    ('Kisumu Station', 'KSM', '-0.0917, 34.7680'),
    ('Eldoret Station', 'ELD', '0.5143, 35.2698');

-- Populate Train Table
INSERT INTO Train (train_name, train_number, departure_station, arrival_station, route, total_seats, available_seats, train_type)
VALUES
    ('Madaraka Express', 'MX101', 1, 2, 'Nairobi - Athi River - Voi - Mombasa', 600, 450, 'Express'),
    ('Western Explorer', 'WE202', 3, 4, 'Kisumu - Nakuru - Eldoret', 400, 300, 'Passenger');

-- Populate Route Table
INSERT INTO Route (train_id, station_id, stop_number, arrival_time, departure_time)
VALUES
    (1, 1, 1, '06:00:00', '06:30:00'),
    (1, 2, 2, '12:00:00', '12:30:00'),
    (2, 3, 1, '08:00:00', '08:15:00'),
    (2, 4, 2, '10:30:00', '10:45:00');

-- Populate Booking Table
INSERT INTO Booking (user_id, train_id, departure_station, arrival_station, seat_number, booking_date, journey_date, status, payment_status)
VALUES
    (1, 1, 1, 2, 'A1', '2025-01-10', '2025-01-15', 'Confirmed', 'Paid'),
    (2, 2, 3, 4, 'B2', '2025-01-05', '2025-01-12', 'Confirmed', 'Paid');

-- Populate Ticket Table
INSERT INTO Ticket (booking_id, ticket_number, seat_number, class, price, issue_date)
VALUES
    (1, 'TKT001', 'A1', 'First Class', 3000.00, '2025-01-10'),
    (2, 'TKT002', 'B2', 'Economy', 1500.00, '2025-01-05');

-- Populate Payment Table
INSERT INTO Payment (booking_id, payment_date, amount, payment_method, transaction_id, payment_status)
VALUES
    (1, '2025-01-10', 3000.00, 'Mobile Money', 'TXN123456', 'Success'),
    (2, '2025-01-05', 1500.00, 'Credit Card', 'TXN654321', 'Success');

-- Populate Feedback Table
INSERT INTO Feedback (user_id, booking_id, feedback_text, rating, feedback_date)
VALUES
    (1, 1, 'The journey was smooth and on time.', 5, '2025-01-16'),
    (2, 2, 'Seats were comfortable, but the train was delayed.', 4, '2025-01-13');

-- Populate Schedule Table
INSERT INTO Schedule (train_id, journey_date, departure_time, arrival_time, status)
VALUES
    (1, '2025-01-15', '06:00:00', '12:30:00', 'Scheduled'),
    (2, '2025-01-12', '08:00:00', '10:45:00', 'Scheduled');
