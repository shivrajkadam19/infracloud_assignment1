chmod +x gencsv.sh
./gencsv.sh 2 8



docker pull infracloudio/csvserver:latest
docker pull prom/prometheus:v2.45.2


error find 
2024-11-21 20:14:38 2024/11/21 14:44:38 error while reading the file "/csvserver/inputdata": open /csvserver/inputdata: no such file or directory



docker run -d --name csvserver -v D:/infracloud_assignment/infracloud_assignment1/solution/inputdata:/csvserver/inputdata infracloudio/csvserver:latest

final command with env and port 
docker run -d --name csvserver -v D:/infracloud_assignment/infracloud_assignment1/solution/inputFile:/csvserver/inputdata -p 9393:9300 -e CSVSERVER_BORDER=Orange infracloudio/csvserver:latest


docker compose up -d 
docker compose down



<? >

# CSVServer Solution

This repository contains the solution to the CSVServer assignment. Follow the steps outlined below to replicate the solution.

---

## Part I: Running CSVServer

### Steps Performed

1. Pulled the CSVServer container image:
   ```bash
   docker pull infracloudio/csvserver:latest
2. Determined that the container required an input file (inputFile) to function correctly.