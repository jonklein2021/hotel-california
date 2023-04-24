all:
	javac src/HotelCalifornia.java
	jar cfmv src/HotelCalifornia.jar src/Manifest.txt src/HotelCalifornia.class
	java -jar src/HotelCalifornia.jar
clean:
	rm -rf src/*.class
	rm -rf src/HotelCalifornia.jar