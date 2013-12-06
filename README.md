MongoEval READ ME FILE
=======================


Setting up the scripting Framework - 
===================================

1) Setting up the YCSB Framework : 
	git clone git://github.com/brianfrankcooper/YCSB.git
	cd YCSB
	mvn clean package
	https://github.com/brianfrankcooper/YCSB/blob/master/mongodb/README.md

2) Installing and starting Mongo DB

	Download the Mongo package from http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-1.8.3.tgz
	Unzip the package and cd into the bun folder
	./mongod --dbpath /tmp/mongodbdata


Running the scripts 
=====================

1) The runExp.sh file is the core module which takes care of the experimentations.

2) Accepts input parameters - number of threads, Operations, Connections & Fields.

3) Run this command with the necessary configurations.

4) Expects a RunConfigs directory & Workload directory - packaged herewith.

5) To Modify workloads choose one from Work Loads dir and make the changes

6) Results once got the script parsers and produces csv formatted outpur in Base/consol dir for each workload.

7) Can be easily imported into xls and can be charted


Extending YCSB Framework 
=========================

1) Import the project into Eclipse

2) CoreWorkload.java file contains the workload generation logic - can be easily extended modified.


To Increase Mongo Power 
=========================

1) Use ulimits and set file descriptor count, max_processes & MaxConns param in Mongo Configs

2) Also set TCL limits if needed for heavy workloads.


Package contains
==================

1) Script Folder - with necessary scripts + configurations for workload and run time params

2) MongoEval web Application - A prototype - web based application to automate the entire process, simply import project and start it on a server and 
   hit http://localhost:8080/MongoEval/jsps/mongoEvalHome.jsp to play around with the tool. Currently the prototype is build for RW - planned
   to be extended in the future.

3) Results Folder - contains one set of results random runs a small subset of our results - just adding some traces of our results.




GitHub Repo link : https://github.com/lokresh88/MongoMessis
==================






