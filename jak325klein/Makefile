all:
	(cd jak325 && javac jak325.java)
	(cd jak325 && jar cfmv jak325.jar Manifest.txt jak325.class)
	mv jak325/jak325.jar .
clean:
	(cd jak325 && rm -rf *.class)
	rm -rf jak325.jar