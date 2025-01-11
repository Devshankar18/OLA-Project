CREATE TABLE Bookings (
    Date DATE,
    Time TIME,
    Booking_ID VARCHAR(50) PRIMARY KEY,
    Booking_Status VARCHAR(50),
    Customer_ID VARCHAR(50),
    Vehicle_Type VARCHAR(50),
    Pickup_Location VARCHAR(255),
    Drop_Location VARCHAR(255),
    V_TAT FLOAT,
    C_TAT FLOAT,
    Canceled_Rides_by_Customer VARCHAR(255),
    Canceled_Rides_by_Driver VARCHAR(255),
    Incomplete_Rides VARCHAR(50),
    Incomplete_Rides_Reason VARCHAR(255),
    Booking_Value INT,
    Payment_Method VARCHAR(50),
    Ride_Distance INT,
    Driver_Ratings FLOAT,
    Customer_Rating FLOAT
);

-- drop table bookings;

select * from Bookings;

COPY Bookings
FROM 'C:\Program Files\PostgreSQL\17\Bookings.csv'
DELIMITER ',' 
CSV HEADER
NULL AS 'null';

-- Queries for the dataset

-- 1. Retrieve all successful bookings:
select * from Bookings
where booking_status = 'Success';


-- 2. Find the average ride distance for each vehicle type:
select vehicle_type, avg(ride_distance)
from bookings
group by vehicle_type;

-- 3. Get the total number of cancelled rides by customers:
SELECT count(*) FROM bookings
WHERE booking_status = 'Canceled by Customer';

-- 4. List the top 5 customers who booked the highest number of rides:
select customer_id, count(booking_id) as total_rides
from bookings
group by customer_id
order by total_rides desc limit 5;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
select count(*)
from bookings
where canceled_rides_by_driver = 'Personal & Car related issue';

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
select min(driver_ratings) as minimun_rating, max(driver_ratings) as maximum_ratings
from bookings 
where vehicle_type = 'Prime Sedan';

-- 7. Retrieve all rides where payment was made using UPI:
select *
from bookings
where payment_method = 'UPI';

-- 8. Find the average customer rating per vehicle type:
select vehicle_type, avg(customer_rating) as average_rating
from bookings
group by vehicle_type;

-- 9. Calculate the total booking value of rides completed successfully:
select sum(booking_value) as total_booking_value
from bookings
where booking_status = 'Success';


-- 10. List all incomplete rides along with the reason:
select booking_id, incomplete_rides_reason
from bookings
where incomplete_rides = 'Yes';




