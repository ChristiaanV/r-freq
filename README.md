# r-freq
Docker image with R, frequently used R packages and SQL Server drivers.

Notable packages:
* tidyverse
* shiny
* shinydashboard
* plotly
* RODBC

## Building the image
```bash
docker build -t r-freq .
```

## Config
Shiny apps will run on port 3838 by default.

SQL Server driver description: "Microsoft ODBC Driver 17 for SQL Server"


## Running a shiny app
1) Create a folder containing a shiny app (app.R).
2) Add a Dockerfile to the folder
```Dockerfile
FROM christiaanv/r-freq:latest

RUN mkdir /root/App
COPY app.R /root/App

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/root/App')"]
```
3) Build the Dockerfile
```bash
docker build -t basic-app .
```
4) Run the app in a container
```bash
docker run --rm -d -p 3838:3838 basic-app
```

The app should now be running on http://localhost:3838/

### Useful commands
View active containers
```bash
docker container ls
```
Stop a container
```bash
docker container stop <container name>
```
Container shell
```bash
docker exec -it <container name> /bin/bash
```
