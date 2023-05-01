/**
 * @author Jon Klein
 * Hotel California
 */

import java.sql.*;
import java.util.Scanner;

public class Utilization {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        final String url = "jdbc:oracle:thin:@edgar1.cse.lehigh.edu:1521:cse241";
        boolean master = true, running = true; // loop booleans

        System.out.println("\nWelcome. Please login below.");

        while (master) {
            final String dbUsername, dbPassword;

            System.out.print("Username: ");
            dbUsername = s.nextLine();
            System.out.print("Password: ");
            dbPassword = s.nextLine();

            System.out.println("\nAttempting connection...");

            try (
                Connection c = DriverManager.getConnection(url, dbUsername, dbPassword);
            ) {
                master = false;
                System.out.println("Connection successful.\n");

                while (running) {
                    System.out.println("Welcome to the Hotel California! Please select an operation.");
                    System.out.println("(1) Customer online reservation access");
                    System.out.println("(2) Front-desk agent");
                    System.out.println("(3) Exit");
                    
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
                            System.out.println("Thank you for choosing Hotel California™.\nHave a good day!");
                            running = false;
                            break;

                        default:
                            System.out.println("Invalid input. Please select 1 or 2.");
                    }
                }
                
                s.close();
                c.close();
            } catch (SQLException e) {
                if(e.getErrorCode() == 1017) {
                    // login error
                    System.err.println("Error: Wrong username/password. Please try again.");
                } else {
                    // all other errors
                    System.err.println("Error: Something went wrong.\nStack trace:");
                    e.printStackTrace();
                };
                System.exit(1);
            }
        }

    }
}