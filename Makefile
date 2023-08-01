all:
	(cd src && javac Main.java)
	(cd src && jar cfmv Main.jar Manifest.txt Main.class)
	mv src/Main.jar .
clean:
	(cd src && rm -rf *.class)
	rm -rf Main.jar