chmod +x gencsv.sh
./gencsv.sh 2 8



docker pull infracloudio/csvserver:latest
docker pull prom/prometheus:v2.45.2


error find 
2024-11-21 20:14:38 2024/11/21 14:44:38 error while reading the file "/csvserver/inputdata": open /csvserver/inputdata: no such file or directory



docker run -d --name csvserver -v D:/infracloud_assignment/solution/inputdata:/csvserver/inputdata infracloudio/csvserver:latest

final command with env and port 
docker run -d --name csvserver -v D:/infracloud_assignment/solution/inputdata:/csvserver/inputdata -p 9393:9393 -e CSVSERVER_BORDER=Orange infracloudio/csvserver:latest


docker compose up -d 
docker compose down
