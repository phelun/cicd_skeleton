.PHONY:all 
SHELL := /bin/sh


test-build: 
	echo "heloworld"

calc-compile: 
	source /etc/profile.d/gradle.sh 
	gradle -v 
