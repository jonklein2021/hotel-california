/**
 * @author Jon Klein
 * Hotel California
 */

import java.sql.*;
import java.time.*; // LocalDate work as SQL timestamp objects
import java.util.ArrayList;
import java.util.Arrays;
import java.util.InputMismatchException;
import java.util.Scanner;

public class Utilization {
    public static void main(String[] args) {
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

            System.out.println("Attempting connection...");

            try (
                Connection c = DriverManager.getConnection(url, dbUsername, dbPassword);
            ) {
                master = false;
                System.out.println("Connection successful.\n");
                Thread.sleep(500); // dramatic pause

                while (running) {
                    System.out.println("Welcome to the Hotel California! Please select an operation.");
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

                            // Front-Desk agent
                            /*
                             * Agent enters customer name (and phone number if necessary)
                             * Agent collects a range of dates
                             * Agent assigns that customer a room sufficing that range of dates
                             */

                            System.out.println("Front Desk Agent");
                            System.out.println("==================================================");

                            System.out.println("Welcome, Agent. Let's get started.");


                            break;
                        case "3":

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
                    System.err.println("SQL Error: Wrong username/password. Please try again.");
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
                    System.out.printf("%-7s%-10s%-10s\n", "Index", "Hotel ID", "Hotel Address");
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

            System.out.println("Please enter the room numbers that you have cleaned separated by a space (ex: \"40129 40130 40131\")\nNote: Invalid rooms will not be altered");
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

            System.out.println("\nCleaning...");

            // set is_clean column in roomsToClean to 1 for all rooms
            for (String room : roomsToClean) {
                cleanRooms.setString(1, room);
                cleanRooms.executeQuery();
            }

            System.out.println("Rooms cleaned successfully!");

            if (badRooms.size() > 0) {
                System.out.println("\nWARNING: The following rooms are either invalid, clean, or occupied and will not be altered:");
                for (String room : badRooms) {
                    System.out.print(room + " ");
                }
                System.out.println("");
            }
            
        } catch (SQLException e) {
            System.err.println("Error: Something went wrong.\nStack trace:");
            e.printStackTrace();
            System.exit(1);
        }        
    }
}
