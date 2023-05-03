/**
 * @author Jon Klein
 * Hotel California
 */

import java.sql.*; // LocalDate work as SQL timestamp objects
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

import javax.swing.Popup;

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
            Thread.sleep(200); // dramatic pause
            System.out.print(".");
            Thread.sleep(200); // dramatic pause
            System.out.print(".");
            Thread.sleep(200); // dramatic pause
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
                            
                            System.out.println("Please provide your customer ID below:");
            
                            
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
                System.exit(1);
            }
        }
    }

    public static void deskAgent(Scanner s, Connection c) {
        try (
            PreparedStatement findGuestByName = c.prepareStatement("SELECT * FROM guests WHERE fname = ? AND lname = ?");
            PreparedStatement findGuestByNameAndPhone = c.prepareStatement("SELECT * FROM guests WHERE fname = ? AND lname = ? AND phone_number = ?");
            PreparedStatement findReservationByGuest = c.prepareStatement("SELECT * FROM reserves NATURAL JOIN reservations WHERE in_time <= ? AND out_time >= ? AND g_id = ?");
            CallableStatement getCost = c.prepareCall("{? = call determineCostUsd(?, ?)}");
            CallableStatement performCheckOut = c.prepareCall("{call checkOutGuest(?, ?, ?, ?, ?, ?)}");
        ) {
            String guestId = "00000", fname = "", lname = "";
            int guestPoints = 0;
            Timestamp now = new Timestamp(218908800000L); // 12/08/1976 @ 4pm
            int guestCount = 0;
            boolean tryAgain = true;

            while (tryAgain) {
                System.out.print("Please enter guest's first name: ");
                fname = s.nextLine();
                System.out.print("Please enter guest's last name: ");
                lname = s.nextLine();

                System.out.printf("Searching for %s %s...\n", fname, lname);
                findGuestByName.setString(1, fname);
                findGuestByName.setString(2, lname);
                ResultSet res1 = findGuestByName.executeQuery();

                if (!res1.next()) {
                    System.err.printf("No guests found under the name \"%s %s\". Please try again\n", fname, lname);
                } else {
                    tryAgain = false;
                    System.out.printf("\n%-10s%-15s%-15s%-20s%-10s\n", "Guest ID", "First Name", "Last Name", "Phone Number", "Points");
                    do {
                        guestId = res1.getString("g_id");
                        guestPoints = res1.getInt("points");
                        System.out.printf("%-10s%-15s%-15s%-20s%-10s\n", guestId, res1.getString("fname"), res1.getString("lname"), res1.getString("phone_number"), guestPoints);
                        guestCount++;
                    } while (res1.next());
                }
            }

            System.out.println("");

            if (guestCount > 1) { // there exist multiple guests with the same first and last name (only happens for Mike Kaufman)
                tryAgain = true;
                while (tryAgain) {   
                    System.out.printf("Which %s %s would you like to select?\nEnter a phone number in the format \"(###) ###-####\": ", fname, lname);
                    String phone = s.nextLine();
                    if (phone.matches("\\(\\d{3}\\) \\d{3}-\\d{4}")) {
                        System.out.printf("Searching for %s %s with phone number %s...\n", fname, lname, phone);
                        findGuestByNameAndPhone.setString(1, fname);
                        findGuestByNameAndPhone.setString(2, lname);
                        findGuestByNameAndPhone.setString(3, phone);
                        ResultSet res2 = findGuestByNameAndPhone.executeQuery();

                        if (!res2.next()) {
                            System.err.printf("No guests found under the name \"%s %s\" with phone number %s. Please try again", fname, lname, phone);
                        } else {
                            tryAgain = false;
                            System.out.printf("\n%-10s%-15s%-15s%-20s%-10s\n", "Guest ID", "First Name", "Last Name", "Phone Number", "Points");
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
                System.out.println("\nPlease select an option below:");
                System.out.println("(1) Check in");
                System.out.println("(2) Check out");
                System.out.println("(3) Back to main menu");

                switch (s.nextLine()) {
                    case "1":
                        // check in
                        /* TODO:
                            * collect start and end date for reservation
                            * call PL/SQL procedure to check guest in (assign room of proper room_type to that guest and mark as occupied)
                            */
                        tryAgain = false;
                        break;
                        
                    case "2":
                        // check out
                        System.out.println("Searching for currently active reservations...\n");
                        findReservationByGuest.setTimestamp(1, now);
                        findReservationByGuest.setTimestamp(2, now);
                        findReservationByGuest.setString(3, guestId);

                        ResultSet res3 = findReservationByGuest.executeQuery();
                        if (!res3.next()) {
                            // no current reservations under this guest
                            System.err.println("There are no current reservations under this guest.");
                        } else {
                            String res_id = res3.getString("res_id");
                            Timestamp inTime = res3.getTimestamp("in_time", null);
                            Timestamp outTime = res3.getTimestamp("out_time", null);
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
                            System.out.printf("%-15s%-15s%-10s%-10.2f%-10d\n", inTime.toString().split(" ")[0], "$"+outTime.toString().split(" ")[0], duration + " days", usdCost, pointsCost);

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
                                                        System.err.printf("Input Error: Please enter a valid number in the range [%d, %d]\n", guestPoints, pointsCost);
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
                System.out.print("Please enter your hotel's city: ");
                String city = s.nextLine();
                findHotels.setString(1, "%, " + city + ", %");

                ResultSet res1 = findHotels.executeQuery();
                if (!res1.next() || city.equals("%")) {
                    System.err.printf("No hotels in city \"%s\" found. Please try again.\n", city);
                } else {
                    tryAgain = false;
                    System.out.printf("\n%-7s%-10s%-10s\n", "Index", "Hotel ID", "Hotel Address");
                    do {
                        hotels.add(res1.getString("h_id"));
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
                            System.err.println("Input error: Please enter a valid index");
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
                String room = roomsToClean.get(i);
                if (room.length() < 5 || !room.substring(0, 2).equals(myHotel.substring(1))) {
                    badRooms.add(room); // is the room inside the proper hotel?
                    roomsToClean.remove(i);
                } else { // is it occupied or clean? is it a valid room number at all?
                    checkRoom.setString(1, room);
                    ResultSet res2 = checkRoom.executeQuery();
                    if (!res2.next()) {
                        badRooms.add(room); // not in rooms table
                        roomsToClean.remove(i);
                    } else {
                        do {
                            if (res2.getInt("is_vacant") == 0 || res2.getInt("is_clean") == 1) {
                                badRooms.add(room); // room is occupied and/or already cleaned
                                roomsToClean.remove(i);
                            }
                        } while (res2.next());
                    }
                }
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
