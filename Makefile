.PHONY:all 

test-build: 
	echo "heloworld"

calc-compile: 
	./etc/profile.d/gradle.sh 
	gradle -v 
