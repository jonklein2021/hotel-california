all:
	(cd Utilization && javac Utilization.java)
	(cd Utilization && jar cfmv Utilization.jar Manifest.txt Utilization.class)
	mv Utilization/Utilization.jar .
clean:
	(cd Utilization && rm -rf *.class)
	rm -rf Utilization.jar