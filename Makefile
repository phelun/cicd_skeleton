.PHONY:all 

test-build: 
	echo "heloworld"

calc-compile: 
	source /etc/profile.d/gradle.sh 
	gradle -v 
