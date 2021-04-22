FROM rocker/r-ver:latest

# Required system libraries
RUN apt-get update && apt-get install -y \
	unixodbc \
	unixodbc-dev \
	curl \
	gnupg
    
# Install R packages
RUN R -e "install.packages(c('tidyverse', 'shiny', 'rmarkdown', 'DT', 'formattable', 'kableExtra', 'networkD3', 'plotly', 'RODBC', 'shinydashboard', 'shinyjs', 'writexl'), repos='https://cloud.r-project.org/')"

# Install mssql odbc drivers
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/20.10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql17

# Copy odbc driver configs
COPY configs/odbc/odbcinst.ini /etc/odbcinst.ini
COPY configs/odbc/odbc.ini /etc/odbc.ini

# Copy file that contains R app network data
# This sets shiny.port = 3838 and shiny.host = "0.0.0.0"
COPY Rprofile.site /usr/local/lib/R/etc/

