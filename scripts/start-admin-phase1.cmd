@echo off
cd /d M:\0NUIST\class\bysj\Medical-platform-master
mvn -Dmaven.repo.local=M:/0NUIST/class/bysj/Medical-platform-master/.m2repo -pl system -am -DskipTests install >> logs\phase1-admin.out 2>> logs\phase1-admin.err
mvn -Dmaven.repo.local=M:/0NUIST/class/bysj/Medical-platform-master/.m2repo -f admin/pom.xml -DskipTests spring-boot:run -Dspring-boot.run.arguments=--server.port=8081 >> logs\phase1-admin.out 2>> logs\phase1-admin.err
