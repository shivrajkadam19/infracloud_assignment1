# csvserver Assignment Solution

This document provides a structured approach to deploying and configuring the `csvserver` application, ensuring proper functionality and integration with Prometheus for monitoring. All steps are clearly outlined for replication on systems equipped with Docker and Docker Compose.

## Environment Setup
Pull necessary Docker images
```sh
docker pull infracloudio/csvserver:latest
docker pull prom/prometheus:v2.45.2
```

## Part I: CSVServer Deployment
### Step 1: Run the CSVServer Container
Attempted to run the csvserver container:
```sh
docker run -d --name csvserver infracloudio/csvserver:latest
```
Check the logs if the container fails:
```sh
docker logs csvserver
```
Issue Found:
The container failed due to a missing input file (```inputFile```) with comma-separated values.
```error while reading the file "/csvserver/inputdata": open /csvserver/inputdata: no such file or directory```

### Step 2: Generating the Input File
To overcome this error Create a script ```gencsv.sh``` to generate the required ```inputFile```. The script takes two arguments: start index and end index, and generates a CSV file with random values.

Following commands are for Making the script executable and generate the file:
```sh
chmod +x gencsv.sh
./gencsv.sh 2 8
```

### Step 3: Run the Container with the Input File
Start the container with the generated ```inputFile``` by mounting it as a volume container from host to container:

here ```pwd``` will be the full absolute path to ```inputFile```
for eg. i used ```D:/infracloud_assignment/infracloud_assignment1/solution/inputFile```

as i have used windows machine to complete this task
```sh
docker run -d --name csvserver -v "$(pwd)/inputFile:/csvserver/inputdata" infracloudio/csvserver:latest
```

### Step 4: Verify Application and Port
Access the container to find the listening port:
```sh
docker exec -it csvserver sh  
netstat -tuln
```
found the application is rnning on port ```9300```

Stop and delete the container:
```sh
docker stop csvserver
docker rm csvserver
```

### Step 5: Run the Application with Environment Variables
Restarted the container with ```CSVSERVER_BORDER=Orange``` and mapped it to port 9393

```sh
docker run -d --name csvserver -v "$(pwd)/inputFile:/csvserver/inputdata" -e CSVSERVER_BORDER=Orange -p 9393:9300 infracloudio/csvserver:latest
```

Now, the application at [http://localhost:9393](http://localhost:9393).

### Step 6: Save Required Files
The following output files were generated and saved:
```bash
# creting file for Command used to run the container
echo docker run -d --name csvserver -v D:/infracloud_assignment/infracloud_assignment1/solution/inputFile:/csvserver/inputdata -p 9393:9300 -e CSVSERVER_BORDER=Orange infracloudio/csvserver:latest > part-1-cmd

# Raw application output
curl -o part-1-output http://localhost:9393/raw

# Logs
docker logs csvserver >& part-1-logs
```

### Files saved:
Soltution for Part I of task:
```gencsv.sh```
```inputFile```
```part-1-cmd```
```part-1-output```
```part-1-logs```

## Part II: Docker Compose Setup

### Step 1: Create ```docker-compose.yaml```
Create a ```docker-compose.yaml``` file for the application:
```sh
services:
  csvserver:
    image: infracloudio/csvserver:latest
    container_name: csvserver
    ports:
      - "9393:9300"
    environment:
      - CSVSERVER_BORDER=Orange
    volumes:
      - ./inputFile:/csvserver/inputdata
```
### Step 2: Run the Application
Run the setup:
```sh
docker-compose up -d
```

Verify the application at [http://localhost:9393](http://localhost:9393).
## Part III: Prometheus Integration
### Step 1: Update ```docker-compose.yaml```
Add Prometheus configuration:

```sh
  prometheus:
    image: prom/prometheus:v2.45.2
    container_name: prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
```
### Step 2: Create prometheus.yml
Create a Prometheus configuration file:

```sh
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: "csvserver"
    static_configs:
      - targets: ["csvserver:9393"]
```
### Step 3: Verify Prometheus
Run the updated setup:
```sh
docker-compose up -d
```
Access Prometheus at [http://localhost:9090](http://localhost:9090). Query csvserver_records and verify the graph.

## Files Included
The following files are present in the solution directory:

```gencsv.sh```
```inputFile```
```part-1-cmd```
```part-1-output```
```part-1-logs```
```docker-compose.yaml```
```csvserver.env```
```prometheus.yml```

## Conclusion
By following this guide, you can set up the ```csvserver``` application and integrate it with Prometheus for monitoring. Ensure all steps are executed sequentially, and all required files are in the ```solution``` directory for replication.
