/**
 * @author Jon Klein
 * Hotel California
 */

import java.sql.*; // LocalDate work as SQL timestamp objects\
import java.util.*;

public class Utilization {
    public static void main(String[] args) throws InterruptedException {
        Scanner s = new Scanner(System.in);
        final String url = "jdbc:oracle:thin:@edgar1.cse.lehigh.edu:1521:cse241";
        boolean master = true, running = true; // loop booleans

        System.out.println("Welcome. Please login below.");

        while (master) {
            final String dbUsername, dbPassword;

            System.out.print("Username: ");
            dbUsername = s.nextLine();
            System.out.print("Password: ");
            dbPassword = s.nextLine();
            
            // hide password from lurkers (caleb)
            System.out.println("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");

            System.out.print("Attempting connection");
            Thread.sleep(150); // dramatic pause
            System.out.print(".");
            Thread.sleep(150); // dramatic pause
            System.out.print(".");
            Thread.sleep(150); // dramatic pause
            System.out.print(".");

            try (
                Connection c = DriverManager.getConnection(url, dbUsername, dbPassword);
            ) {
                master = false;
                System.out.println("\nConnection successful.");

                while (running) {
                    System.out.println("\nWelcome to the Hotel California! Please select an operation.");
                    System.out.println("(1) Customer online reservation access");
                    System.out.println("(2) Front-desk agent");
                    System.out.println("(3) Housekeeping interface");
                    System.out.println("(4) Exit");
                    
                    switch (s.nextLine()) {
                        case "1":

                            // Customer Online Reservation System
                            /*
                             * Customer selects a city and range of dates
                             * Hotels in that city with available rooms in that range of dates are returned
                             * Customer logs in with their ID and no password or creates new record in DB
                             */

                            System.out.println("Customer Online Reservation System");
                            System.out.println("==================================================");
                            reservationSystem(s, c);
                            
                            break;
                    
                        case "2":

                            // Front-Desk Agent
                            /*
                             * Agent enters customer name (and phone number if necessary)
                             * Agent collects a range of dates
                             * Agent assigns that customer a room sufficing that range of dates
                             */

                            System.out.println("Front Desk Agent");
                            System.out.println("==================================================");

                            System.out.println("Welcome, Agent. Let's get started.");
                            deskAgent(s, c);

                            break;

                        case "3":

                        // Housekeeping Interface
                        /*
                         * Logs a room as cleaned in DB after a room has been cleaned in a particular hotel
                         */

                            System.out.println("Housekeeping Interface");
                            System.out.println("==================================================");

                            System.out.println("Good evening.");
                            housekeeping(s, c);

                            break;

                        case "4":
                            System.out.println("Thank you for choosing Hotel California™.\nHave a good day!");
                            running = false;
                            break;

                        default:
                            System.out.println("Invalid input. Please only enter a number.");
                    }
                }
                
                s.close();
            } catch (SQLException e) {
                if(e.getErrorCode() == 1017) {
                    // login error
                    System.err.println("\nSQL Error: Wrong username/password. Please try again.");
                } else {
                    // all other SQL errors
                    System.err.println("SQL Error: Something went wrong.\nStack trace:");
                    e.printStackTrace();
                    s.close();
                    System.exit(1);
                };
            } catch (Exception e) {
                System.err.println("Error: Something went wrong.\nStack trace:");
                e.printStackTrace();
                s.close();
                System.exit(1);
            }
        }
    }

    public static void printHotelCities(Connection c) {
        try (
            Statement listHotels = c.createStatement();
        ) {
            ResultSet res = listHotels.executeQuery("SELECT address FROM hotels");
            HashSet<String> cities = new HashSet<>(); // city, quantity
            if (!res.next()) {
                System.out.println("Oops! There are no hotels :(");
                return;
            }
            
            do {
                String city = res.getString(1).split(",")[1];
                cities.add(city);
            } while (res.next());

            for (String city : cities) {
                System.out.println("-" + city);
            }
            
        } catch (SQLException e) {
            // all other SQL errors
            System.err.println("SQL Error: Something went wrong.\nStack trace:");
            e.printStackTrace();
            System.exit(1);
        }
    }

    // mIkE -> Mike
    public static String correctCase(String s) {
        return Character.toUpperCase(s.charAt(0)) + s.substring(1).toLowerCase();
    }

    public static void reservationSystem(Scanner s, Connection c) {
        
        /*
            * reservation system:
            * login or register
            * get hotel via city
            * get dates of reservation
            * get type of room
            * assign reservation to customer
            */

        try (
            PreparedStatement performRegistration = c.prepareCall("{call handleNewGuest(?, ?, ?, ?, ?, ?, ?)}");
            PreparedStatement findHotels = c.prepareStatement("SELECT * FROM hotels WHERE address LIKE ?");
            PreparedStatement findAvailableRooms = c.prepareStatement("SELECT r_type type, count(*) num_available FROM contains NATURAL JOIN rooms WHERE h_id = ? AND is_vacant = 1 AND is_clean = 1 GROUP BY r_type ORDER BY num_available DESC");
            PreparedStatement findGuestByName = c.prepareStatement("SELECT * FROM guests WHERE fname = ? AND lname = ?");
            PreparedStatement findGuestByNameAndPhone = c.prepareStatement("SELECT * FROM guests WHERE fname = ? AND lname = ? AND phone_number = ?");
            CallableStatement performWalkIn = c.prepareCall("{? = call handleWalkin(?, ?, ?, ?, ?)}");
            CallableStatement performReservation = c.prepareCall("{call handleReservation(?, ?, ?, ?, ?)}");
        ) {

            boolean signOut = true;
            while (signOut) {
                System.out.println("Please select an option below:");
                System.out.println("(1) Create an account");
                System.out.println("(2) Login to an existing account");
                System.out.println("(3) Return to main menu");
                switch (s.nextLine()) {
                    case "1":
                        // create an account
                        // collect fname, lname, address, phoneNumber, cc_number
                        // ask to make frequent guest

                        String fname = "", lname = "", address = "", email = "", phoneNumber = "", ccNumber = "";
                        int points = -1;

                        boolean tryAgain = true;
                        while (tryAgain) {
                            System.out.print("Please enter your first and last name separated by a space (ex: \"Mike Kaufman\"): ");
                            String names = s.nextLine();
                            if (names.strip().matches("[A-Za-z]+ [A-Za-z]+")) {
                                // format matches; convert to correct case
                                tryAgain = false;
                                fname = correctCase(names.split(" ")[0]);
                                lname = correctCase(names.split(" ")[1]);
                            } else {
                                System.err.println("Input error: Please enter names with proper formatting.");
                            }
                        }

                        System.out.print("Please enter your city: ");
                        address = s.nextLine();

                        tryAgain = true;
                        while (tryAgain) {
                            System.out.print("Please enter your phone number in the format \"(###) ###-####\": ");
                            String phoneNum = s.nextLine();
                            if (phoneNum.matches("\\(\\d{3}\\) \\d{3}-\\d{4}")) {
                                tryAgain = false;
                                phoneNumber = phoneNum;
                            } else {
                                System.err.println("Input Error: Improper format.");
                            }
                        }

                        tryAgain = true;
                        while (tryAgain) {
                            System.out.print("Please enter a valid email: ");
                            String emailAdd = s.nextLine();
                            // reference: https://regexr.com/2rhq7
                            if (emailAdd.matches("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")) {
                                tryAgain = false;
                                email = emailAdd;
                            } else {
                                System.err.println("Input Error: Email is invalid.");
                            }
                        }

                        tryAgain = true;
                        while (tryAgain) {
                            System.out.print("Please enter your credit card number in the format \"#### #### #### ####\": ");
                            String ccNum = s.nextLine();
                            if (ccNum.matches("\\d{4} \\d{4} \\d{4} \\d{4}")) {
                                tryAgain = false;
                                ccNumber = ccNum;
                            } else {
                                System.err.println("Input Error: Please enter your credit card number in the proper format.");
                            }
                        }

                        System.out.print("Would you like to join our frequent guest program? Type Y to accept and anything else to reject: ");
                        if (s.nextLine().toLowerCase().equals("y")) {
                            points = 0;
                            System.out.println("Success! You are now a part of our frequent guest program!");
                        }

                        System.out.printf("\n%-15s%-15s%-40s\n", "First Name", "Last Name", "Address");
                        System.out.printf("%-15s%-15s%-40s\n", fname, lname, address);
                        System.out.printf("\n%-15s%-20s%-20s\n", "Phone Number", "CC Number", "Frequent Guest");
                        System.out.printf("%-15s%-20s%-20s\n", phoneNumber, ccNumber, (points == 0) ? "Yes" : "No");
                        
                        System.out.print("Please confirm the information above. Type Y if all is correct and anything else if something is wrong: ");
                        if (s.nextLine().toLowerCase().equals("y")) {
                            // create new guest w PL/SQL
                            performRegistration.setString(1, fname);
                            performRegistration.setString(2, lname);
                            performRegistration.setString(3, phoneNumber);
                            performRegistration.setString(4, address);
                            performRegistration.setString(5, email);
                            performRegistration.setString(6, ccNumber);
                            performRegistration.setInt(7, points);
                            performRegistration.executeUpdate();

                            System.out.println("Registration successful!");

                        } else {
                            System.out.println("Registration cancelled successfully.\nReturning to menu...\n");
                            break;
                        }
                        
                        break;
                    case "2":
                        // login to account
                        // get gID using fname/lname and phone number if need be
                        // ask for their starting date and their duration of stay
                        // ask for preferred type of room
                        // assign room to guest
                        // ask to make frequent guest

                        HashMap<Integer, String> roomsTable = new HashMap<>(); // (index, roomType)
                        String hotelID = "000", guestId = "00000";
                        fname = ""; lname = "";
                        int guestPoints = 0, guestCount = 0;
                        Timestamp now = new Timestamp(218926800000L); // 12/08/1976 @ 4pm EST
                        ArrayList<String> hotels = new ArrayList<>(); // store h_ids in here
                        int index = 0;

                        // log guest in
                        tryAgain = true;
                        while (tryAgain) {
                            System.out.print("\nPlease enter your first name: ");
                            fname = correctCase(s.nextLine());
                            System.out.print("Please enter your last name: ");
                            lname = correctCase(s.nextLine());
            
                            System.out.printf("Searching for %s %s...\n", fname, lname);
                            findGuestByName.setString(1, fname);
                            findGuestByName.setString(2, lname);
                            ResultSet res1 = findGuestByName.executeQuery();
            
                            if (!res1.next()) {
                                System.err.printf("No guests found under the name \"%s %s\".\nType Q to return to reservation menu and type anything else to try again.\n", fname, lname);
                                if (s.nextLine().toLowerCase().equals("q")) {
                                    // jump back a menu
                                    break;
                                }
                            } else {
                                tryAgain = false;
                                System.out.println("Found!\n");
                                System.out.printf("%-10s%-15s%-15s%-20s%-10s\n", "Guest ID", "First Name", "Last Name", "Phone Number", "Points");
                                do {
                                    guestId = res1.getString("g_id");
                                    guestPoints = res1.getInt("points");
                                    System.out.printf("%-10s%-15s%-15s%-20s%-10s\n", guestId, res1.getString("fname"), res1.getString("lname"), res1.getString("phone_number"), guestPoints);
                                    guestCount++;
                                } while (res1.next());
                            }
                        }
            
                        if (guestCount > 1) { // there exist multiple guests with the same first and last name (only happens for Mike Kaufman)
                            tryAgain = true;
                            while (tryAgain) {   
                                System.out.printf("\nWhich %s %s would you like to select?\nEnter a phone number in the format \"(###) ###-####\": ", fname, lname);
                                phoneNumber = s.nextLine();
                                if (phoneNumber.matches("\\(\\d{3}\\) \\d{3}-\\d{4}")) {
                                    System.out.printf("Searching for %s %s with phone number %s...\n", fname, lname, phoneNumber);
                                    findGuestByNameAndPhone.setString(1, fname);
                                    findGuestByNameAndPhone.setString(2, lname);
                                    findGuestByNameAndPhone.setString(3, phoneNumber);
                                    ResultSet res2 = findGuestByNameAndPhone.executeQuery();
            
                                    if (!res2.next()) {
                                        System.err.printf("No guests found under the name \"%s %s\" with phone number %s.\nType Q to return to reservation menu and type anything else to try again.\n", fname, lname, phoneNumber);
                                        if (s.nextLine().toLowerCase().equals("q")) {
                                            // jump back a menu
                                            break;
                                        }
                                    } else {
                                        tryAgain = false;
                                        System.out.println("Found!\n");
                                        System.out.printf("%-10s%-15s%-15s%-20s%-10s\n", "Guest ID", "First Name", "Last Name", "Phone Number", "Points");
                                        do {
                                            guestId = res2.getString("g_id");
                                            guestPoints = res2.getInt("points");
                                            System.out.printf("%-10s%-15s%-15s%-20s%-10s\n\n", guestId, res2.getString("fname"), res2.getString("lname"), res2.getString("phone_number"), guestPoints);
                                        } while (res2.next());
                                    }
                                } else {
                                    System.out.println("Invalid format. Please try again.\n");
                                }
                            }
                        }

                        // select a hotel
                        tryAgain = true;
                        while (tryAgain) {
                            System.out.println("We have hotels in the following cities:");
                            printHotelCities(c);
                            System.out.print("Please enter your hotel's city: ");
                            String city = correctCase(s.nextLine());
                            findHotels.setString(1, "%, " + city + ", %");
            
                            ResultSet res1 = findHotels.executeQuery();
                            if (!res1.next() || city.equals("%")) {
                                System.err.printf("No hotels in city \"%s\" found.\nType Q to return to reservation menu and type anything else to try again.\n", city);
                                if (s.nextLine().toLowerCase().equals("q")) {
                                    // jump back a menu
                                    break;
                                }
                            } else {
                                tryAgain = false;
                                System.out.println("Found!");
                                System.out.printf("\n%-7s%-10s%-10s\n", "Index", "Hotel ID", "Hotel Address");
                                do {
                                    hotels.add(res1.getString("h_id"));
                                    hotelID = res1.getString("h_id");
                                    System.out.printf("%-7s%-10s%-10s\n", ++index, hotels.get(index-1), res1.getString("address"));
                                } while (res1.next());
                            }
                        }
            
                        // select the correct hotel using index if there are multiple with the same city name (happens for Portland)
                        if (index > 1) {
                            tryAgain = true;
                            while (tryAgain) {
                                System.out.print("\nPlease enter the index of the hotel you would like to select: ");
                                try {
                                    int i = Integer.valueOf(s.nextLine());
                                    if (i > 0 && i <= index) { // ensure that index is in range
                                        hotelID = hotels.get(i-1); // select this hotel
                                        tryAgain = false;
                                    } else {                    
                                        throw new NumberFormatException(); // jump to catch
                                    }
                                } catch (NumberFormatException e) {
                                    System.err.println("Input error: Please enter a valid index");
                                }
                            }
                        }

                        int roomIndex = 0;

                        // get type of room
                        findAvailableRooms.setString(1, hotelID);
                        ResultSet res5 = findAvailableRooms.executeQuery();

                        if (!res5.next()) {
                            System.err.println("Sorry, there are no available rooms at this location.");
                            break;
                        } else {
                            System.out.printf("\n%-7s%-20s%-10s\n", "Index", "Room Type", "Num. Available Rooms");
                            do {
                                roomsTable.put(++roomIndex, res5.getString(1)); // add to table
                                System.out.printf("%-7s%-20s%-10d\n", roomIndex, res5.getString(1), res5.getInt(2));
                            } while (res5.next());
                        }

                        String roomType = "";
                        boolean tryAgainRType = true;
                        while (tryAgainRType) {
                            System.out.println("\nPlease type the index of the type of room you would like.");
                            try {
                                int i = Integer.valueOf(s.nextLine());
                                if (i > 0 && i <= roomIndex) { // ensure that index is in range
                                    roomType = roomsTable.get(i); // select this room type
                                    tryAgainRType = false;
                                } else {                    
                                    throw new NumberFormatException();
                                }
                            } catch (NumberFormatException e) {
                                System.err.println("Input error: Please enter a valid index");
                            }
                        }

                        Timestamp startTime = null;

                        tryAgain = true;
                        while (tryAgain) {
                            System.out.printf("The date today is %s and the time now is %s\n", now.toString().split(" ")[0], now.toString().split(" ")[1]);
                            System.out.println("What date would you like to make a reservation for?\nPlease enter in the form \"MM/DD/YYYY\":");
                            String input = s.nextLine();
                            if (input.matches("\\d{1,2}/\\d{1,2}/\\d{4}")) {
                                int month = Integer.parseInt(input.split("/")[0]);
                                int day = Integer.parseInt(input.split("/")[1]);
                                int year = Integer.parseInt(input.split("/")[2]);

                                if (month >= 1 && month <= 12 && day >= 1 && day <= 31 && year >= 1970) {
                                    Calendar cal = new GregorianCalendar(year, month-1, day, 16, 0);
                                    startTime = new Timestamp(cal.getTimeInMillis()); // 4pm - 8*60*60*1000

                                    if (now.after(startTime)) {
                                        System.err.println("Input Error: This date is in the past");
                                    } else {
                                        // validate that date is not in the past
                                        tryAgain = false;
                                    }
                                } else {
                                    System.err.println("Input Error: This date is invalid");
                                }
                                
                            } else {
                                System.err.println("Input Error: Invalid format");
                            }
                        }

                        int duration = 0;
                        tryAgain = true;
                        while (tryAgain) {
                            System.out.println("How many days would you like to stay for?");
                            try {
                                duration = Integer.valueOf(s.nextLine());
                                if (duration > 0 && duration <= 14) {
                                    tryAgain = false;
                                } else {
                                    throw new NumberFormatException();
                                }
                            } catch (NumberFormatException e) {
                                System.err.println("Input Error: Please enter a valid positive integer in the range [1, 14]");
                            }                                        
                        }

                        Timestamp endTime = new Timestamp(startTime.getTime() + duration*1000*60*60*24);

                        // call PL/SQL procedure to create this reservation
                        // if startTime == now, call handleWalkin()
                        // else, call handleReservation()

                        if (now.equals(startTime)) {
                            performWalkIn.registerOutParameter(1, Types.VARCHAR);
                            performWalkIn.setString(2, guestId);
                            performWalkIn.setTimestamp(3, startTime);
                            performWalkIn.setTimestamp(4, endTime);
                            performWalkIn.setString(5, roomType);
                            performWalkIn.setString(6, hotelID);
                            performWalkIn.execute();
                            String roomNumber = performWalkIn.getString(1);

                            System.out.println("\nWalk-in request successful! You will be staying in room " + roomNumber);
                        } else {
                            performReservation.setString(1, guestId);
                            performReservation.setTimestamp(2, startTime);
                            performReservation.setTimestamp(3, endTime);
                            performReservation.setString(4, roomType);
                            performReservation.setString(5, hotelID);
                            performReservation.execute();
                            System.out.println("Reservation request completed successfully!");
                        }

                        break;

                    case "3":
                        return;
                    default:
                        System.err.println("Input Error: Please select a valid option.");
                        break;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error: Something went wrong.\nStack trace:");
            e.printStackTrace();
            System.exit(1);
        }
    }

    public static void deskAgent(Scanner s, Connection c) {
        try (
            PreparedStatement findHotels = c.prepareStatement("SELECT * FROM hotels WHERE city LIKE ?");
            PreparedStatement findAvailableRooms = c.prepareStatement("SELECT r_type type, count(*) num_available FROM contains NATURAL JOIN rooms WHERE h_id = ? AND is_vacant = 1 AND is_clean = 1 GROUP BY r_type ORDER BY num_available DESC");
            PreparedStatement findGuestByName = c.prepareStatement("SELECT * FROM guests WHERE fname = ? AND lname = ?");
            PreparedStatement findGuestByNameAndPhone = c.prepareStatement("SELECT * FROM guests WHERE fname = ? AND lname = ? AND phone_number = ?");
            PreparedStatement findReservationByGuest = c.prepareStatement("SELECT * FROM reserves NATURAL JOIN reservations WHERE in_time <= ? AND out_time >= ? AND g_id = ? AND r_number = '00000'");
            CallableStatement performCheckIn = c.prepareCall("{? = call handleCheckin(?, ?, ?, ?)}");
            CallableStatement performWalkIn = c.prepareCall("{? = call handleWalkin(?, ?, ?, ?, ?)}");
            CallableStatement getCost = c.prepareCall("{? = call determinePrice(?, ?)}");
            CallableStatement performCheckOut = c.prepareCall("{call handleCheckout(?, ?, ?, ?, ?, ?)}");
        ) {
            HashMap<Integer, String> roomsTable = new HashMap<>(); // (index, roomType)
            String hotelID = "000", guestId = "00000", fname = "", lname = "";
            int guestPoints = 0, guestCount = 0;
            ArrayList<String> hotels = new ArrayList<>(); // store h_ids in here
            int index = 0;
            Timestamp now = new Timestamp(218926800000L); // 12/08/1976 @ 4pm EST
            boolean tryAgain = true; // to loop for inputs

            System.out.printf("The date today is %s and the time now is %s\n", now.toString().split(" ")[0], now.toString().split(" ")[1]);

            while (tryAgain) {
                System.out.println("\nWe have hotels in the following cities:");
                printHotelCities(c);
                System.out.print("Please enter your hotel's city: ");
                String city = correctCase(s.nextLine());
                findHotels.setString(1, "%, " + city + ", %");

                ResultSet res1 = findHotels.executeQuery();
                if (!res1.next() || city.equals("%")) {
                    System.err.printf("No hotels in city \"%s\" found. Please try again.\n", city);
                } else {
                    tryAgain = false;
                    System.out.println("Found!\n");
                    System.out.printf("\n%-7s%-10s%-10s\n", "Index", "Hotel ID", "Hotel Address");
                    do {
                        hotels.add(res1.getString("h_id"));
                        hotelID = res1.getString("h_id");
                        System.out.printf("%-7s%-10s%-10s\n", ++index, hotels.get(index-1), res1.getString("city"));
                    } while (res1.next());
                }
            }

            // select the correct hotel using index if there are multiple with the same city name
            if (index > 1) {
                tryAgain = true;
                while (tryAgain) {
                    System.out.print("\nPlease enter the index of the hotel you would like to select: ");
                    try {
                        int i = Integer.valueOf(s.nextLine());
                        if (i > 0 && i <= index) { // ensure that index is in range
                            hotelID = hotels.get(i-1); // select this hotel
                            tryAgain = false;
                        } else {                    
                            throw new NumberFormatException(); // jump to catch
                        }
                    } catch (NumberFormatException e) {
                        System.err.println("Input error: Please enter a valid index");
                    }
                }
            }

            tryAgain = true;
            while (tryAgain) {
                System.out.print("\nPlease enter guest's first name: ");
                fname = correctCase(s.nextLine());
                System.out.print("Please enter guest's last name: ");
                lname = correctCase(s.nextLine());

                System.out.printf("Searching for %s %s...\n", fname, lname);
                findGuestByName.setString(1, fname);
                findGuestByName.setString(2, lname);
                ResultSet res1 = findGuestByName.executeQuery();

                if (!res1.next()) {
                    System.err.printf("No guests found under the name \"%s %s\". Please try again\n", fname, lname);
                } else {
                    tryAgain = false;
                    System.out.println("Found!\n");
                    System.out.printf("\n%-10s%-15s%-15s%-20s%-10s\n", "Guest ID", "First Name", "Last Name", "Phone Number", "Points");
                    do {
                        guestId = res1.getString("g_id");
                        guestPoints = res1.getInt("points");
                        System.out.printf("%-10s%-15s%-15s%-20s%-10s\n", guestId, res1.getString("fname"), res1.getString("lname"), res1.getString("phone_number"), guestPoints);
                        guestCount++;
                    } while (res1.next());
                }
            }

            if (guestCount > 1) { // there exist multiple guests with the same first and last name (so far only happens for Mike Kaufman)
                tryAgain = true;
                while (tryAgain) {   
                    System.out.printf("Which %s %s would you like to select?\nEnter a phone number in the format \"(###) ###-####\": ", fname, lname);
                    String phoneNumber = s.nextLine();
                    if (phoneNumber.matches("\\(\\d{3}\\) \\d{3}-\\d{4}")) {
                        System.out.printf("Searching for %s %s with phone number %s...\n", fname, lname, phoneNumber);
                        findGuestByNameAndPhone.setString(1, fname);
                        findGuestByNameAndPhone.setString(2, lname);
                        findGuestByNameAndPhone.setString(3, phoneNumber);
                        ResultSet res2 = findGuestByNameAndPhone.executeQuery();

                        if (!res2.next()) {
                            System.err.printf("No guests found under the name \"%s %s\" with phone number %s. Please try again", fname, lname, phoneNumber);
                        } else {
                            tryAgain = false;
                            System.out.println("Found!\n");
                            System.out.printf("%-10s%-15s%-15s%-20s%-10s\n", "Guest ID", "First Name", "Last Name", "Phone Number", "Points");
                            do {
                                guestId = res2.getString("g_id");
                                guestPoints = res2.getInt("points");
                                System.out.printf("%-10s%-15s%-15s%-20s%-10s\n", guestId, res2.getString("fname"), res2.getString("lname"), res2.getString("phone_number"), guestPoints);
                            } while (res2.next());
                        }
                    } else {
                        System.out.println("Invalid format. Please try again.\n");
                    }
                }
            }

            tryAgain = true;
            while (tryAgain) {
                roomsTable.clear();
                System.out.println("\nPlease select an option below:");
                System.out.println("(1) Check in");
                System.out.println("(2) Check out");
                System.out.println("(3) Back to main menu");

                switch (s.nextLine()) {
                    case "1":
                        // check in
                        /* 
                         * find reservation under this guest which begins today
                         * call PL/SQL procedure to check guest in (assign room of proper room_type to that guest and mark as occupied)
                         */
                        
                        System.out.println("Searching for currently active reservations...");
                        findReservationByGuest.setTimestamp(1, now);
                        findReservationByGuest.setTimestamp(2, now);
                        findReservationByGuest.setString(3, guestId);

                        ResultSet res3 = findReservationByGuest.executeQuery();
                        if (!res3.next()) {
                            // no current reservations under this guest
                            System.out.print("There are no current reservations under this guest.\nWould you like to create a walk-in reservation? If so, type Y and otherwise, type anything else: ");
                            switch (s.nextLine().toLowerCase()) {
                                case "y":
                                    // create walk-in reservation
                                    /*
                                     * walk in:
                                     * collect duration of stay and regular check in parameters
                                     * 
                                     * within the selected hotel, find a room that is vacant and clean
                                     * then, set this room to occupied and unclean, signifying that the guest has checked in
                                     */

                                    int roomIndex = 0;

                                    // get type of room
                                    findAvailableRooms.setString(1, hotelID);
                                    ResultSet res5 = findAvailableRooms.executeQuery();
 
                                    if (!res5.next()) {
                                        System.err.println("Sorry, there are no available rooms at this location.");
                                        break;
                                    } else {
                                        System.out.printf("%-7s%-20s%-10s\n", "Index", "Room Type", "Num. Available Rooms");
                                        do {
                                            roomsTable.put(++roomIndex, res5.getString(1)); // add to table
                                            System.out.printf("%-7s%-20s%-10d\n", roomIndex, res5.getString(1), res5.getInt(2));
                                        } while (res5.next());
                                    }

                                    String roomType = "";
                                    boolean tryAgainRType = true;
                                    while (tryAgainRType) {
                                        System.out.println("\nPlease type the index of the type of room you would like.");
                                        try {
                                            int i = Integer.valueOf(s.nextLine());
                                            if (i > 0 && i <= roomIndex) { // ensure that index is in range
                                                roomType = roomsTable.get(i); // select this room type
                                                tryAgainRType = false;
                                            } else {                    
                                                throw new NumberFormatException();
                                            }
                                        } catch (NumberFormatException e) {
                                            System.err.println("Input error: Please enter a valid index");
                                        }
                                    }

                                    int duration = 0;
                                    boolean tryAgainDuration = true;
                                    while (tryAgainDuration) {
                                        System.out.println("How many days would you like to stay for?");
                                        try {
                                            duration = Integer.valueOf(s.nextLine());
                                            if (duration > 0 && duration <= 14) {
                                                tryAgainDuration = false;
                                            } else {
                                                throw new NumberFormatException();
                                            }
                                        } catch (NumberFormatException e) {
                                            System.err.println("Input Error: Please enter a valid positive integer in the range [1, 14]");
                                        }                                        
                                    }

                                    Timestamp inTime = now;
                                    Timestamp outTime = new Timestamp(inTime.getTime() + duration*1000*60*60*24);

                                    performWalkIn.registerOutParameter(1, Types.VARCHAR);
                                    performWalkIn.setString(2, guestId);
                                    performWalkIn.setTimestamp(3, inTime);
                                    performWalkIn.setTimestamp(4, outTime);
                                    performWalkIn.setString(5, roomType);
                                    performWalkIn.setString(6, hotelID);
                                    performWalkIn.execute();
                                    String roomNumber = performWalkIn.getString(1);

                                    System.out.println("\nWalk-in request successful! You will be staying in room " + roomNumber);

                                    break;
                            
                                default:
                                    System.out.println("Returning to main menu...");
                                    break;
                            }

                        } else {
                            String res_id = res3.getString("res_id");
                            Timestamp inTime = res3.getTimestamp("in_time", null);
                            Timestamp outTime = res3.getTimestamp("out_time", null);
                            int duration = (int) (outTime.getTime()-inTime.getTime())/(1000*60*60*24);

                            System.out.println("Found!\n");

                            // send reservation to stdout
                            System.out.printf("%-15s%-15s%-10s\n", "Start Date", "End Date", "Duration");
                            System.out.printf("%-15s%-15s%-10s\n", inTime.toString().split(" ")[0], outTime.toString().split(" ")[0], duration + " days");

                            System.out.print("\nType Y to confirm the check-in for reservation above and type anything else to cancel: ");
                            switch (s.nextLine().toLowerCase()) {
                                case "y":
                                    tryAgain = false;

                                    int roomIndex = 0;

                                    // get type of room
                                    findAvailableRooms.setString(1, hotelID);
                                    ResultSet res5 = findAvailableRooms.executeQuery();

                                    if (!res5.next()) {
                                        System.err.println("Sorry, there are no available rooms at this location.");
                                        break;
                                    } else {
                                        System.out.printf("%-7s%-20s%-10s\n", "Index", "Room Type", "Num. Available Rooms");
                                        do {
                                            roomsTable.put(++roomIndex, res5.getString(1)); // add to table
                                            System.out.printf("%-7s%-20s%-10d\n", roomIndex, res5.getString(1), res5.getInt(2));
                                        } while (res5.next());
                                    }
                                    String roomType = "";
                                    boolean tryAgainRType = true;
                                    while (tryAgainRType) {
                                        System.out.println("\nPlease type the index of the type of room you would like.");
                                        try {
                                            int i = Integer.valueOf(s.nextLine());
                                            if (i > 0 && i <= roomIndex) { // ensure that index is in range
                                                roomType = roomsTable.get(i); // select this room type
                                                tryAgainRType = false;
                                            } else {                    
                                                throw new NumberFormatException();
                                            }
                                        } catch (NumberFormatException e) {
                                            System.err.println("Input error: Please enter a valid index");
                                        }
                                    }

                                    /*
                                     * check in (PL/SQL):
                                     * within the selected hotel, find a room that is vacant and clean
                                     * then, set this room to occupied and unclean, signifying that the guest has checked in
                                     */

                                    performCheckIn.registerOutParameter(1, Types.VARCHAR);
                                    performCheckIn.setString(2, guestId);
                                    performCheckIn.setString(3, res_id);
                                    performCheckIn.setString(4, roomType);
                                    performCheckIn.setString(5, hotelID);
                                    performCheckIn.execute();
                                    String roomNumber = performCheckIn.getString(1);
                                    
                                    System.out.println("\nCheck-in request successful! You will be staying in room " + roomNumber);
                                    
                                    return;

                                default:
                                    // return to agent menu
                                    System.out.println("Check-in request cancelled successfully.");
                                    break;
                            }
                        }
                        break;
                        
                    case "2":
                        // check out
                        System.out.println("Searching for currently active reservations...\n");
                        findReservationByGuest.setTimestamp(1, now);
                        findReservationByGuest.setTimestamp(2, now);
                        findReservationByGuest.setString(3, guestId);

                        ResultSet res4 = findReservationByGuest.executeQuery();
                        if (!res4.next()) {
                            // no current reservations under this guest
                            System.err.println("There are no current reservations under this guest.");
                        } else {
                            String res_id = res4.getString("res_id");
                            Timestamp inTime = res4.getTimestamp("in_time", null);
                            Timestamp outTime = res4.getTimestamp("out_time", null);
                            int duration = (int) (outTime.getTime()-inTime.getTime())/(1000*60*60*24);
                            
                            // calculate cost of stay

                            getCost.registerOutParameter(1, Types.INTEGER);
                            getCost.setString(2, res_id);
                            getCost.setTimestamp(3, inTime);
                            getCost.execute();
                            float usdCost = getCost.getFloat(1);
                            int pointsCost = (int) usdCost*100;

                            // send reservation to stdout
                            System.out.printf("%-15s%-15s%-10s%-10s%-10s\n", "Start Date", "End Date", "Duration", "USD", "Points");
                            System.out.printf("%-15s%-15s%-10s%-10.2f%-10d\n", inTime.toString().split(" ")[0], outTime.toString().split(" ")[0], duration + " days", "$"+usdCost, pointsCost);

                            System.out.print("\nType Y to confirm the check-out for reservation above and type anything else to cancel: ");
                            switch (s.nextLine().toLowerCase()) {
                                case "y":
                                    tryAgain = false;

                                    float usdPaid = usdCost;
                                    int pointsPaid = 0;
                                    
                                    if (guestPoints > 0) {
                                        // ask if guest would like to use points
                                        System.out.printf("You have %d points. Type Y to use them to pay for today's reservation and type anything else to continue with usd: ", guestPoints);
                                        switch (s.nextLine().toLowerCase()) {
                                            case "y":
                                                boolean tryAgainPoints = true;
                                                while (tryAgainPoints) {
                                                    try {
                                                        System.out.print("Please enter the number of points you would like to use: ");
                                                        pointsPaid = Integer.valueOf(s.nextLine());
                                                        if (pointsPaid > 0 && pointsPaid <= guestPoints && pointsPaid <= pointsCost) {
                                                            // input is valid
                                                            tryAgainPoints = false;
                                                            usdPaid -= ((float) pointsPaid/100); // remaining usd to pay
                                                        } else {
                                                            throw new NumberFormatException();
                                                        }
                                                        
                                                    } catch (NumberFormatException e) {
                                                        System.err.printf("Input Error: Please enter a valid number in the range [%d, %d]\n", 0, Math.max(guestPoints, pointsPaid));
                                                    }
                                                }

                                                break;

                                            default:
                                                // pay with usd
                                                break;
                                        }

                                        // perform checkout procedure
                                        performCheckOut.setString(1, res_id);
                                        performCheckOut.setTimestamp(2, inTime);
                                        performCheckOut.setTimestamp(3, outTime);
                                        performCheckOut.setFloat(4, usdPaid);
                                        performCheckOut.setInt(5, pointsPaid);
                                        performCheckOut.setString(6, guestId);
                                        performCheckOut.execute();
                                        System.out.println("Checkout successful.");

                                        return;
                                    }
                                    break;
                            
                                default:
                                    // return to agent menu
                                    System.out.println("Check-out request cancelled successfully.");
                                    break;
                            }
                            
                        }
                        
                        break;

                    case "3":
                        return;
                    
                    default:
                        System.out.println("Invalid option. Please try again.");
                        break;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("SQL Error: Something went wrong.\nStack trace:");
            e.printStackTrace();
            s.close();
            System.exit(1);
        } catch (Exception e) {
            System.err.println("Error: Something went wrong.\nStack trace:");
            e.printStackTrace();
            System.exit(1);
        }
    }

    public static void housekeeping(Scanner s, Connection c) {
        try (
            PreparedStatement findHotels = c.prepareStatement("SELECT * FROM hotels WHERE address LIKE ?");
            PreparedStatement checkRoom = c.prepareStatement("SELECT * FROM rooms WHERE r_number = ?");
            PreparedStatement cleanRooms = c.prepareStatement("UPDATE rooms SET is_clean = 1 WHERE r_number = ?");
        ) {
            ArrayList<String> hotels = new ArrayList<>(); // store h_ids of results in here
            String myHotel = "000"; // hotel id to clean within

            ArrayList<String> roomsToClean; // store input rooms here
            ArrayList<String> badRooms = new ArrayList<>(); // store clean rooms, occupied rooms, and rooms not in this hotel in here

            int index = 0;
            boolean tryAgain = true; // to loop for inputs
            while (tryAgain) {
                System.out.println("\nWe have hotels in the following cities:");
                printHotelCities(c);
                System.out.print("Please enter your hotel's city: ");
                String city = correctCase(s.nextLine());
                findHotels.setString(1, "%, " + city + ", %");

                ResultSet res1 = findHotels.executeQuery();
                if (!res1.next() || city.equals("%")) {
                    System.err.printf("No hotels in city \"%s\" found. Please try again.\n", city);
                } else {
                    tryAgain = false;
                    System.out.printf("\n%-7s%-10s%-10s\n", "Index", "Hotel ID", "Hotel Address");
                    do {
                        hotels.add(res1.getString("h_id"));
                        myHotel = res1.getString("h_id");
                        System.out.printf("%-7s%-10s%-10s\n", ++index, hotels.get(index-1), res1.getString("address"));
                    } while (res1.next());
                }
            }

            // select the correct hotel using index if there are multiple with the same city name
            if (index > 1) {
                tryAgain = true;
                while (tryAgain) {
                    System.out.print("\nPlease enter the index of the hotel you would like to select: ");
                    try {
                        int i = Integer.valueOf(s.nextLine());
                        if (i > 0 && i <= index) { // ensure that index is in range
                            myHotel = hotels.get(i-1); // clean rooms in this hotel only
                            tryAgain = false;
                        } else {                    
                            throw new NumberFormatException();
                        }
                    } catch (NumberFormatException e) {
                        System.err.println("Input error: Please enter a valid index");
                    }
                }
            }

            System.out.println("\nPlease enter the room numbers that you have cleaned separated by a space (ex: \"40129 40130 40131\")\nNote: Invalid rooms will not be altered");
            String rooms = s.nextLine();

            roomsToClean = new ArrayList<>(Arrays.asList(rooms.split(" ")));
            for (int i = 0; i < roomsToClean.size(); i++) {
                String room = roomsToClean.get(i).strip();
                if (room.length() < 5 || !(room.substring(0, 2).equals(myHotel.substring(1)))) {
                    //  && Integer.valueOf(room.substring(2)) >= 100 && Integer.valueOf(room.substring(2)) < 200)
                    System.out.println("1 " + room);
                    System.out.println(room.substring(0, 2));
                    System.out.println(myHotel.substring(1));
                    System.out.println(myHotel);
                    badRooms.add(room); // is the room inside the proper hotel?
                } else { // is it occupied or clean? is it a valid room number at all?
                    checkRoom.setString(1, room);
                    ResultSet res2 = checkRoom.executeQuery();
                    if (!res2.next()) {
                        System.out.println("2 " + room);
                        badRooms.add(room); // not in rooms table
                    } else {
                        do {
                            if (res2.getInt("is_vacant") == 0 || res2.getInt("is_clean") == 1) {
                                System.out.println("3 " + room);
                                badRooms.add(room); // room is occupied and/or already cleaned
                            }
                        } while (res2.next());
                    }
                }
            }

            // remove room from list
            for (String room : badRooms) {
                roomsToClean.remove(room);
            }

            if (roomsToClean.size() > 0) {
                System.out.println("\nCleaning the following rooms:");
                // set is_clean column in roomsToClean to 1 for all rooms
                for (String room : roomsToClean) {
                    System.out.print(room + " ");
                    cleanRooms.setString(1, room);
                    cleanRooms.executeUpdate();
                }
                System.out.println("\nRooms cleaned successfully!\n");
            }

            if (badRooms.size() > 0) {
                System.out.println("WARNING: The following rooms are either invalid, clean, or occupied and will not be altered:");
                for (String room : badRooms) {
                    System.out.print(room + " ");
                }
                System.out.println("\n");
            }
            
        } catch (SQLException e) {
            System.err.println("Error: Something went wrong.\nStack trace:");
            e.printStackTrace();
            System.exit(1);
        }        
    }
}
