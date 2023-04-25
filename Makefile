all:
	(cd src && javac HotelCalifornia.java)
	(cd src && jar cfmv HotelCalifornia.jar Manifest.txt HotelCalifornia.class)
clean:
	rm -rf *.class
	rm -rf HotelCalifornia.jar