CREATE TABLE Sailors (
    sid INTEGER,
    sname VARCHAR(255),
    rating INTEGER,
    age INTEGER
);

CREATE TABLE Boats (
    bid INTEGER,
    bname VARCHAR(255),
    color VARCHAR(255)
);

CREATE TABLE Reserves (
    sid INTEGER,
    bid INTEGER,
    day DATE
);

INSERT INTO Sailors (sid, sname, rating, age)
VALUES (1, 'John', 8, 25),
    (2, 'Mike', 9, 28),
    (3, 'Sarah', 7, 23),
    (4, 'Emily', 6, 26),
    (5, 'David', 9, 27);

INSERT INTO Boats (bid, bname, color)
VALUES (101, 'Boat1', 'red'),
    (102, 'Boat2', 'green'),
    (103, 'Boat3', 'blue'),
    (104, 'Boat4', 'red'),
    (105, 'Boat5', 'green');

INSERT INTO Reserves (sid, bid, day)
VALUES (1, 101, '2022-01-01'),
    (2, 102, '2022-01-02'),
    (3, 103, '2022-01-03'),
    (4, 104, '2022-01-04'),
    (5, 105, '2022-01-05');

-- Question: Retrieve the sid, sname, rating, and age of sailors whose rating is greater than 7?
SELECT S.sid, S.sname, S.rating, S.age
FROM Sailors AS S
Where S.rating > 7;

-- Question: Retrieve the sid, sname, and color of boats that are green?
SELECT S.sid, S.sname
FROM Sailors AS S
WHERE S.color = "green"; 

-- Question: Retrieve the color of the boats reserved by the sailor with the name 'Lubber'."
SELECT B.color
FROM Sailors As S, Reserves As R, Boats as B
WHERE S.sid=R.sid AND R.bid=B.bid AND S.sname = "Lubber";

-- Question: Retrieve the sname of where bid of the boat is 103?
SELECT S.sname
FROM Sailors AS S, Reserves AS R, Boats as B
Where S.sid=R.sid AND R.bid=103;

-- Question: Retrieve the sname of sailors who have reserved a red?
SELECT S.sname
FROM Sailors AS S, Reserves AS R, Boats as B
WHERE S.sid=R.sid AND R.bid=B.bid And  B.color='red';

-- Question: Retrieve the sname of sailors who have reserved a boat that is either red or green?
SELECT sname
FROM Sailors, Boats, Reserves
Where Sailors.sid=Reserves.sid AND Reserves.bid=Boats.bid And Boats.color='red'
UNION
SELECT sname
FROM Sailors,Boats,Reserves
Where Sailors.sid=Reserves.sid AND Reserves.bid=Boats.bid AND Boats.color='green';

-- Q 7
-- Question: Retrieve the sname of sailors who have reserved a boat that is both red and green?
SELECT sname
FROM Sailors, Boats, Reserves
WHERE Sailors.sid=Reserves.sid AND Reserves.bid=Boats.bid AND Boats.color='red'
INTERSECT
SELECT sname
FROM Sailors, Boats, Reserves
WHERE Sailors.sid=Reserves.sid AND Reserves.bid=Boats.bid AND Boats.color='green';

-- Q 8
-- Question: Retrieve the sid of sailors who have reserved a boat that is red but not green?
SELECT S.sid
FROM Sailors AS S, Reserves AS R, Boats as B
WHERE S.sid=R.sid AND R.bid=B.bid AND B.color='red'
EXCEPT
SELECT S2.sid
FROM Sailors AS S2, Reserves AS R2, Boats as B2
WHERE S2.sid=R2.sid AND R2.bid=B2.bid AND B2.color='green';

-- Q 9
-- Question: Retrieve the names of sailors who have made a reservation for the boat with bid 103?
SELECT S.sname
FROM Sailors AS S
WHERE S.sid IN (SELECT R.sid
                FROM Reserves AS R
                WHERE R.bid=103);

-- Q 10
-- Question: Retrieve the names of sailors who have made reservations for both red and green boats?
SELECT S.sname
FROM Sailors AS S
WHERE S.sid IN ((SELECT R.sid
                FROM Reserves AS R, Boats AS B
                WHERE R.bid=B.bid AND B.color='red')
                INTERSECT
                (SELECT R2.sid
                FROM Reserves AS R2, Boats AS B2
                WHERE R2.bid=B2.bid AND B2.color='green'));

-- Q 11
-- Question: Retrieve the names of sailors whose age is greater than the maximum age of sailors with a rating of 10?
SELECT S.sname
FROM Sailors AS S
WHERE S.age > (SELECT MAX(S2.age)
                FROM Sailors AS S2
                WHERE S2.rating = 10);
                
-- Q 12
-- Question: Retrieve the number of reservations for each red boat?
SELECT B.bid, Count(*) AS reservationcount
FROM Boats AS B, Reserves AS R
WHERE R.bid=B.bid AND B.color='red'
GROUP BY B.bid;

-- Q13
-- Question: Retrieve the number of reservations for each red boat?
SELECT B.bid, Count(*) AS reservationcount
FROM Boats AS B, Reserves AS R
WHERE R.bid=B.bid AND B.color='red'
GROUP BY B.bid;
HAVING B.color='red';

-- Q 14
-- Question: Retrieve the names of sailors who have reserved a boat with the name 'interlake'?
SELECT Sname
FROM Sailors
WHERE Sailors.sid IN (SELECT Reserves.bid, Reserves.sid
                        FROM Reserves
                        CONTAINS (SELECT Boats.bid
                                    FROM Boats
                                    WHERE bname = "interlake"));

-- Q 15
-- Question: Retrieve the average age of sailors with a rating greater than 18, who have made more than one reservation?
SELECT S.rating.Avg(S.age) As average
FROM Sailors AS S
WHERE S.age > 18
GROUP BY S.rating
HAVING Count(*) > 1;

-- Q 16
-- Question: What are the names of the sailors who have reserved every boat?
SELECT S.sname
FROM Sailors AS S
WHERE NOT EXISTS (SELECT B.bid
                    FROM Boats AS B
                    WHERE NOT EXISTS (SELECT R.bid
                                        FROM Reserves AS R
                                        WHERE R.bid=B.bid AND R.sid=S.sid));
        
-- Q 17
-- Question: What are the names of the sailors who have reserved the boat with ID 100, have a rating greater than 5, and made the reservation on 08/09/2022?
SELECT S.sname
FROM Sailors AS S, Reserves AS R
WHERE R.sid=S.sid AND R.bid = 100 AND R.rating > 5 AND R.day = "08/09/2022";