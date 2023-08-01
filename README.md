# **Jon Klein: Hotel California**
### *Fictional hotel interface made with JDBC and Oracle SQL databases for CSE 341*

<br>

## Build Instructions
Note: The following commands should be run in the project root directory

### To Compile
```
make
```

### To Run
```
java -jar Main.jar
```

#### **IMPORTANT: This build is intended for Lehigh sunlab machines only and depends on its database cluster.**

## Organization
- All Java source code is in `src/Main.java`
- All PL/SQL functions and procedures are saved in the `pl-and-sql` directory
- Tables are in `tables/hoteltable.sql`
- Code to insert into tables are in the `tables/inserts` directory (some manual adjustments were made beyond this to ensure "interesting" data)

## Time Traveling [IMPORTANT]
This program uses December 8th, 1976 @ 4pm EST, the date of release of Hotel California as its `now` time.
Thus, all times prior to this are treated as times in the past, and all times after this are treated as times in the future.

## Interfaces

Three interfaces are featured in this project:
1. Customer online reservation access
2. Front-desk agent
3. Housekeeping

More detail about each of these interfaces can be found below.

## Customer Online Reservation Access

This interface enables registered guests to make a reservation, or to make an account if they don't have one

#### Creating New Accounts
Account creation collects the following information:
- First name, last name
- Address
- Phone number (Format is "(###) ###-####")
- Email (Must comply to RFC2822 standard formatting)
- Credit card number (Format is "#### #### #### ####")

#### Making Reservations
Any guest that exists in the guests table may make a reservation
- This reservation may start today, or in the future, but not in the past
- If the reservation begins today, a "walk-in" request will be filed and the guest will be checked in afterwards
- The hotel, preferred room type, and duration of stay are recorded
- A confirmation of the reservation is presented

#### Notes
- Guests pay for their reservation at check-out time

## Front-Desk Agent

This interface performs check-in and check-out requests for guests with active reservations

#### Check In
- Sign guest in with first/last name (and phone number if there are duplicate first/last name combinations)
- Search hotel location by city
For a guest having an active reservation (reservation start <= the time now <= reservation end)...
- Confirm the transaction with guest
- Assign a vacant, clean room to them of the preferred room type
For walk-ins (No reservation s.t. reservation start <= the time now <= reservation end)...
- Create a new reservation for them (similar to first interface)
- Ask for preferred room type and duration of stay
- Assign a vacant, clean room to them of the preferred room type

#### Check Out
- Sign guest in
- Confirm that they have an active reservation (reservation start <= the time now <= reservation end)
- If guest is a frequent guest, ask if they would like to use their points to pay for their reservation (100 points = $1)
- If guest is a frequent guest, award them 500 points for every night of the reservation

#### TESTING
Some customers to test walk-in:
- Shirley Angos
- Mike Kaufman (588) 323-2415
Customers to test check-in:
- William Cox
- Cassandra	Reynolds
Customers to test check-out:
- Adrian Ross
- Mike Kaufman (499) 419-1417

#### Notes
- Guests pay for their reservation at check-out time
- Rooms are marked as unclean and vacant in the check-out procedure
- Reservations that have not been checked in yet have a room number of '00000'

## Housekeeping

The housekeeping interface lets cleaning staff log which rooms they've cleaned so that the database remains consistent with the state of the hotel
- A hotel is selected by city
- Rooms are entered on a single line separated by spaces
- "Bad rooms", that is, rooms that cannot be cleaned are filtered out
- Rooms that remain are "cleaned" and are set to clean in the database

#### TESTING
Note: Hotel with ID 0XX has rooms XX### where ### is in between 100 and 199 inclusive
For example , if h_id = 012, rooms in that hotel are [12100, 12101, ..., 12198, 12199]

The following tests are for the hotel in `Honolulu`:
Valid rooms to clean:
- 04129 04130 04131
Room numbers that don't exist in this hotel:
- 04200 04999 12100 99999 fish -1/12
Room numbers that exist in this hotel but are occupied:
- 04136, 04137, 04138
Room numbers that exist in this hotel but are already clean:
- 04106, 04107, 04108

#### Notes
- Rooms are marked as unclean and vacant in the check-out procedure as opposed to in a trigger

## ER Design
Unfortunately, my rushed ER diagram did not suffice for this project, so I needed to make some changes.
The updated diagram is a pdf that can be found in this directory under the name `Jon Klein - Updated ER Design.pdf`
