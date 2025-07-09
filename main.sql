--1

create table Carrier(
  CarrierId integer primary key autoincrement,
  CarrierName varchar(255) not null,
  DiscountPercentageThirtyDaysAdvanceBooking integer,
  DiscountPercentageSixtyDaysAdvanceBooking integer,
  DiscountPercentageNinetyDaysAdvanceBooking integer,
  RefundPercenageForTicketCancellation2DaysBeforeTravelDate integer,
  RefundPercenageForTicketCancellation10DayBeforeTravelDate integer,
  RefundPercenageForTicketCancellation20DayBeforeTravelDate integer,
  BulkBookingDiscount integer,
  SilverUserDiscount integer,
  GoldUserDiscount integer,
  PlatinumUserDiscount integer
);

--2

INSERT INTO Carrier (
  CarrierName,
  DiscountPercentageThirtyDaysAdvanceBooking,
  DiscountPercentageSixtyDaysAdvanceBooking,
  DiscountPercentageNinetyDaysAdvanceBooking,
  RefundPercenageForTicketCancellation2DaysBeforeTravelDate,
  RefundPercenageForTicketCancellation10DayBeforeTravelDate,
  RefundPercenageForTicketCancellation20DayBeforeTravelDate,
  BulkBookingDiscount,
  SilverUserDiscount,
  GoldUserDiscount,
  PlatinumUserDiscount
) VALUES 
('SkyJet Airways', 5, 10, 15, 30, 50, 70, 10, 5, 10, 15),
('AeroFly Express', 4, 9, 14, 25, 45, 65, 8, 4, 9, 13),
('Nimbus Travels', 6, 12, 18, 35, 55, 75, 12, 6, 11, 16),
('BlueSky Airlines', 3, 7, 11, 20, 40, 60, 7, 3, 8, 12),
('Falcon Wings', 7, 13, 20, 40, 60, 80, 15, 7, 12, 18);

--3
create table Flight(
  FlightId integer primary key autoincrement,
  CarrierId integer references Carrier(CarrierId),
  Origin varchar(255),
  Dest varchar(255),
  AirFare integer,
  SeatCapacityEconomyClass integer,
  SeatCapacityBusinessClass integer,
  SeatCapacityExecutiveClass integer
);

--4

INSERT INTO Flight (
  CarrierId, Origin, Dest, AirFare, 
  SeatCapacityEconomyClass, SeatCapacityBusinessClass, SeatCapacityExecutiveClass
) VALUES
(2, 'Hyderabad', 'Mumbai', 4100, 140, 30, 9),
(2, 'Delhi', 'Pune', 3900, 120, 25, 6),
(2, 'Ahmedabad', 'Kolkata', 4400, 150, 28, 8),
(2, 'Goa', 'Bangalore', 3500, 130, 22, 5),
(2, 'Chennai', 'Indore', 3600, 110, 20, 6),
(2, 'Pune', 'Chennai', 4300, 145, 24, 7),
(2, 'Lucknow', 'Delhi', 4200, 135, 26, 7),

(4, 'Mumbai', 'Goa', 3600, 140, 23, 6),
(4, 'Bangalore', 'Pune', 4100, 150, 30, 10),
(4, 'Kolkata', 'Hyderabad', 4000, 120, 25, 7),
(4, 'Delhi', 'Ahmedabad', 4500, 160, 28, 9),
(4, 'Goa', 'Indore', 3850, 135, 27, 8),
(4, 'Pune', 'Delhi', 3950, 145, 29, 6),

(3, 'Chennai', 'Delhi', 4600, 150, 30, 9),
(3, 'Hyderabad', 'Ahmedabad', 4300, 140, 27, 8),
(3, 'Mumbai', 'Lucknow', 3900, 135, 24, 7),
(3, 'Indore', 'Bangalore', 4000, 125, 23, 6),

(1, 'Delhi', 'Mumbai', 4500, 150, 30, 10),
(4, 'Delhi', 'Mumbai', 4200, 132, 40, 20),
(1, 'Pune', 'Hyderabad', 4100, 145, 25, 8),
(1, 'Goa', 'Chennai', 3800, 120, 20, 5),
(1, 'Bangalore', 'Ahmedabad', 4600, 155, 29, 9),
(1, 'Kolkata', 'Delhi', 4700, 130, 28, 7),

(5, 'Chennai', 'Goa', 3900, 135, 24, 6);


--5
select c.CarrierName, count(c.CarrierId) as CarrierCount from Carrier c join Flight f on f.CarrierId = c.CarrierId group by c.CarrierId order by count(f.CarrierId) desc;


--6
SELECT f.FlightId, c.CarrierName, f.Origin, f.Dest, f.Airfare
FROM Flight f
JOIN Carrier c ON f.CarrierId = c.CarrierId
WHERE f.Dest = 'Mumbai'
  AND f.Airfare = (
    SELECT MIN(g.Airfare)
    FROM Flight g
    WHERE g.Dest = 'Mumbai'
);



CREATE TABLE FlightSchedule (
  ScheduleId INTEGER PRIMARY KEY AUTOINCREMENT,
  FlightId INTEGER REFERENCES Flight(FlightId),
  TravelDate DATE NOT NULL
);

INSERT INTO FlightSchedule (FlightId, TravelDate) VALUES
(1, '2025-07-10'),
(2, '2025-07-10'),
(3, '2025-07-10'),
(4, '2025-07-10'),
(5, '2025-07-10'),
(6, '2025-07-10'),
(7, '2025-07-10'),
(8, '2025-07-10'),
(19, '2025-07-10'),
(10, '2025-07-10'),
(11, '2025-07-10'),
(12, '2025-07-10'),
(18, '2025-07-10'),
(14, '2025-07-10'),
(19, '2025-07-10');


CREATE TABLE FlightBookings (
  BookingId INTEGER PRIMARY KEY AUTOINCREMENT,
  FlightId INTEGER REFERENCES Flight(FlightId),
  ScheduleId INTEGER REFERENCES FlightSchedule(ScheduleId),
  SeatType VARCHAR(20) DEFAULT 'Economy' CHECK (SeatType IN ('Economy', 'Business', 'Executive')),
  BookingStatus VARCHAR(20) DEFAULT 'Booked' CHECK (BookingStatus IN ('Booked', 'Cancelled'))
);

--8

INSERT INTO FlightBookings (FlightId, ScheduleId, SeatType, BookingStatus) VALUES
-- Flight 1 (6 bookings)
(1, 1, 'Economy', 'Booked'),
(1, 1, 'Business', 'Booked'),
(1, 1, 'Executive', 'Booked'),
(1, 1, 'Economy', 'Cancelled'),
(1, 1, 'Economy', 'Booked'),
(1, 1, 'Business', 'Booked'),

-- Flight 2 (5 bookings)
(2, 2, 'Economy', 'Booked'),
(2, 2, 'Economy', 'Booked'),
(2, 2, 'Executive', 'Booked'),
(2, 2, 'Business', 'Cancelled'),
(2, 2, 'Executive', 'Cancelled'),

-- Flight 3 (4 bookings)
(3, 3, 'Business', 'Booked'),
(3, 3, 'Business', 'Booked'),
(3, 3, 'Executive', 'Booked'),
(3, 3, 'Economy', 'Booked'),

-- Flight 4 (3 bookings)
(4, 4, 'Economy', 'Booked'),
(4, 4, 'Economy', 'Cancelled'),
(4, 4, 'Executive', 'Booked'),

-- Flight 5 (6 bookings)
(5, 5, 'Economy', 'Booked'),
(5, 5, 'Business', 'Booked'),
(19, 15, 'Business', 'Booked'),
(5, 5, 'Executive', 'Booked'),
(19, 15, 'Economy', 'Booked'),
(5, 5, 'Economy', 'Cancelled'),

-- Flight 6 (4 bookings)
(6, 6, 'Business', 'Booked'),
(6, 6, 'Business', 'Cancelled'),
(6, 6, 'Executive', 'Booked'),
(6, 6, 'Economy', 'Booked'),

-- Flight 7 (5 bookings)
(7, 7, 'Economy', 'Booked'),
(7, 7, 'Executive', 'Booked'),
(19, 9, 'Executive', 'Booked'),
(7, 7, 'Business', 'Booked'),
(7, 7, 'Business', 'Cancelled'),

-- Flight 8 (3 bookings)
(8, 8, 'Economy', 'Booked'),
(8, 8, 'Business', 'Booked'),
(8, 8, 'Executive', 'Booked'),

-- Flight 9 (5 bookings)
(9, 9, 'Economy', 'Cancelled'),
(9, 9, 'Economy', 'Booked'),
(18, 13, 'Business', 'Cancelled'),
(9, 9, 'Executive', 'Booked'),
(18, 13, 'Business', 'Booked'),

-- Flight 10 (3 bookings)
(10, 10, 'Executive', 'Booked'),
(10, 10, 'Executive', 'Booked'),
(10, 10, 'Economy', 'Booked'),

-- Flight 11 (2 bookings)
(11, 11, 'Economy', 'Booked'),
(11, 11, 'Business', 'Cancelled'),

-- Flight 12 (3 bookings)
(12, 12, 'Business', 'Booked'),
(12, 12, 'Executive', 'Booked'),
(12, 12, 'Economy', 'Cancelled'),

-- Flight 13 (2 bookings)
(13, 13, 'Economy', 'Booked'),
(13, 13, 'Business', 'Booked'),

-- Flight 14 (3 bookings)
(14, 14, 'Business', 'Booked'),
(14, 14, 'Executive', 'Booked'),
(14, 14, 'Economy', 'Booked'),

-- Flight 15 (2 bookings)
(15, 15, 'Executive', 'Booked'),
(15, 15, 'Economy', 'Booked');





-- 7 Before cancelling ticket

SELECT
  f.FlightId,
  c.CarrierName,
  f.Origin,
  f.Dest,
  f.AirFare,
  s.TravelDate,
  f.SeatCapacityEconomyClass -
    COUNT(CASE WHEN b.SeatType = 'Economy' AND b.BookingStatus = 'Booked' THEN 1 END) AS AvailableEconomySeats,
  f.SeatCapacityBusinessClass -
    COUNT(CASE WHEN b.SeatType = 'Business' AND b.BookingStatus = 'Booked' THEN 1 END) AS AvailableBusinessSeats,
  f.SeatCapacityExecutiveClass -
    COUNT(CASE WHEN b.SeatType = 'Executive' AND b.BookingStatus = 'Booked' THEN 1 END) AS AvailableExecutiveSeats,
  COUNT(CASE WHEN b.BookingStatus = 'Booked' THEN 1 END) AS TotalBookedSeats
FROM
  Flight f
JOIN
  Carrier c ON f.CarrierId = c.CarrierId
JOIN
  FlightSchedule s ON f.FlightId = s.FlightId
LEFT JOIN
  FlightBookings b ON f.FlightId = b.FlightId AND s.ScheduleId = b.ScheduleId
WHERE
  s.TravelDate = '2025-07-10' and f.Origin = 'Delhi' and f.Dest = 'Mumbai'
GROUP BY
  f.FlightId, c.CarrierName, f.Origin, f.Dest, f.AirFare, s.TravelDate
ORDER BY
TotalBookedSeats DESC;

--9
update FlightBookings set BookingStatus='Cancelled' where BookingId = 23;


--After cancelling ticket

SELECT
  f.FlightId,
  c.CarrierName,
  f.Origin,
  f.Dest,
  f.AirFare,
  s.TravelDate,
  f.SeatCapacityEconomyClass -
    COUNT(CASE WHEN b.SeatType = 'Economy' AND b.BookingStatus = 'Booked' THEN 1 END) AS AvailableEconomySeats,
  f.SeatCapacityBusinessClass -
    COUNT(CASE WHEN b.SeatType = 'Business' AND b.BookingStatus = 'Booked' THEN 1 END) AS AvailableBusinessSeats,
  f.SeatCapacityExecutiveClass -
    COUNT(CASE WHEN b.SeatType = 'Executive' AND b.BookingStatus = 'Booked' THEN 1 END) AS AvailableExecutiveSeats,
  COUNT(CASE WHEN b.BookingStatus = 'Booked' THEN 1 END) AS TotalBookedSeats
FROM
  Flight f
JOIN
  Carrier c ON f.CarrierId = c.CarrierId
JOIN
  FlightSchedule s ON f.FlightId = s.FlightId
LEFT JOIN
  FlightBookings b ON f.FlightId = b.FlightId AND s.ScheduleId = b.ScheduleId
WHERE
  s.TravelDate = '2025-07-10' and f.Origin = 'Delhi' and f.Dest = 'Mumbai'
GROUP BY
  f.FlightId, c.CarrierName, f.Origin, f.Dest, f.AirFare, s.TravelDate
ORDER BY
TotalBookedSeats DESC;

--10

--11

select c.CarrierName from Carrier c join Flight f on c.CarrierId = f.CarrierId and f.Origin = 'Delhi' and f.Dest = 'Mumbai';

--12








