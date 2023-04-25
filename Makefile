all:
	(cd src && javac HotelCalifornia.java)
	(cd src && jar cfmv HotelCalifornia.jar Manifest.txt HotelCalifornia.class)
clean:
	(cd src && rm -rf *.class)
	(cd src && rm -rf HotelCalifornia.jar)