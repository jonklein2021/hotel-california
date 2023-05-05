# **Hotel California**
### *Fictional hotel interface made with JDBC and Oracle SQL databases for CSE 341*

<br>

## Build Instructions

```
make
java -jar Utilization.jar
```

#### **IMPORTANT: This build is intended for Lehigh sunlab machines only.**

## Time Traveling [IMPORTANT]
This program uses December 8th, 1976 @ 4pm EST, the date of release of Hotel California as its `now` time.
Thus, all times prior to this are treated as times in the past, and all times after this are treated as times in the future.

## Interfaces

Three interfaces are featured in this project:
1. Customer online reservation access
2. Front-desk agent
3. Housekeeping

More detail about each of these interfaces can be found below.

### Customer Online Reservation Access

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
- If the reservation begins today, a "walk-in" request will be fille and the guest will be checked in afterwards
- 

#### Notes:
- Guests pay for their reservation at check-out time

### Front-Desk Agent

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

### TESTING:
Some customers to test walk-in:
- Shirley Angos
- Mike Kaufman (588) 323-2415
Customers to test check-in:
- William Cox
- Cassandra	Reynolds
Customers to test check-out:
- Adrian Ross
- Mike Kaufman (499) 419-1417

#### Notes:
- Guests pay for their reservation at check-out time
- Reservations that have not been checked in yet have a room number of '00000'

### Housekeeping

TODO

### Addresses

Addresses are stored in the format `Street address, City, State Zip`

Example: `7005 Shady Ln Dr, Freehold, New Jersey 07728`

Date of release: December 8, 1976