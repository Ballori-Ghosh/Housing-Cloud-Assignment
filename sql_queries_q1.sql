CREATE TABLE Hotel (
    hotel_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    phone_number VARCHAR(20),
    email VARCHAR(100),
	total_rooms INT NOT NULL,
	established_date date
);


CREATE TABLE Room (
    room_id VARCHAR(255) PRIMARY KEY,
    room_type VARCHAR(50) NOT NULL,
    capacity INTEGER NOT NULL,
    floor INTEGER,
	room_layout VARCHAR(10),
	sq_feet DECIMAL(10, 2),
	currency_type VARCHAR(10) NOT NULL,
	price_per_night DECIMAL(10, 2) NOT NULL,
    status ENUM('available', 'occupied', 'maintenance') NOT NULL,
	hotel_id VARCHAR(255),
	FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id)
);

CREATE TABLE Customer (
    customer_id VARCHAR(255) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    zip_code VARCHAR(20),
	gender VARCHAR(10),
	first_reservation_date date,
	date_of_birth date
);

CREATE TABLE Reservation (
    reservation_id VARCHAR(255) PRIMARY KEY,
	checkin_datetime DATE NOT NULL,
    checkout_datetime DATE NOT NULL,
	status ENUM('confirmed', 'checked_in', 'checked_out', 'canceled') NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
	coupon_applied VARCHAR(32),
	total_guests INTEGER NOT NULL,
	total_nights INTEGER NOT NULL,
	customer_id VARCHAR(255),
	room_id VARCHAR(255),
	hotel_id VARCHAR(255),
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id),
    FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id)
);

CREATE TABLE Reservation_Room_Details (
    reservation_id VARCHAR(255),
	room_id VARCHAR(255),
	FOREIGN KEY (reservation_id) REFERENCES Reservation(reservation_id),
	FOREIGN KEY (room_id) REFERENCES Room(room_id)
);


CREATE TABLE Payment (
    payment_id VARCHAR(255) PRIMARY KEY,
	reservation_id VARCHAR(255),
    payment_date datetime NOT NULL,
	amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
	currency_type VARCHAR(10) NOT NULL,
	FOREIGN KEY (reservation_id) REFERENCES Reservation(reservation_id)
);

CREATE TABLE Employee (
    employee_id VARCHAR(255) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
	supervisor_id VARCHAR(255),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    position VARCHAR(50),
    salary DECIMAL(10, 2),
	hotel_id VARCHAR(255),
	supervisorID VARCHAR(255),
	FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id),
	FOREIGN KEY (supervisorID) REFERENCES Employee(employee_id)
);

CREATE TABLE holiday_pricing (
    holiday_event_id VARCHAR(255) PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
	surge_multiplier FLOAT,
	hotel_id VARCHAR(255),
    FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id)
);

CREATE TABLE Room_Service_Request (
    request_id VARCHAR(255) PRIMARY KEY,
    request_date DATETIME NOT NULL,
    request_details TEXT NOT NULL,
    status ENUM('pending', 'completed') NOT NULL,
	is_chargeable BOOLEAN,
	currency_type VARCHAR(10),
	charges_for_service DECIMAL(10,2),
	reservation_id VARCHAR(255),
	FOREIGN KEY (reservation_id) REFERENCES Reservation(reservation_id)
);