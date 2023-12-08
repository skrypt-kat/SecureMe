#! /bin/bash

function menu {

# menu for different ubuntu types
echo "this is the function menu"
read -n1 -p "
  Press 1 for opening a PostgreSQLfile,
	press 2 for PostgreSQL security" osin
  if [ "$osin" = "1" ]; then
    openFile
  elif [ "$osin" = "2" ]; then
    postgresSec
  else 
    echo "that is not a valid input :( )"
    menu
  fi

  }

function openFile {
# Check if the filename is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <filename.sql>"
    exit 1
fi

# Assign the provided filename to a variable
sql_file="$1"

# Check if the file exists
if [ ! -f "$sql_file" ]; then
    echo "File '$sql_file' not found."
    exit 1
fi

# Prompt for PostgreSQL username and database name
read -p "Enter your PostgreSQL username: " username
read -p "Enter the database name: " dbname

# Connect to PostgreSQL and execute the SQL file
psql -U "$username" -d "$dbname" -f "$sql_file"
}
# to execute do ./execute_sql.sh your_sql_file.sql

function postgresSec {

  # Update and upgrade system
  sudo apt update
  sudo apt upgrade -y

  # PostgreSQL version
  PG_VERSION=$(ls /etc/postgresql)

  # Modify pg_hba.conf for authentication
  sudo cp /etc/postgresql/$PG_VERSION/main/pg_hba.conf /etc/postgresql/$PG_VERSION/main/pg_hba.conf.bak
  sudo sed -i 's/^\(host.*all.*all.*\)\(peer\|md5\)\(.*\)$/\1md5\3/' /etc/postgresql/$PG_VERSION/main/pg_hba.conf

  # Modify postgresql.conf for network security
  sudo cp /etc/postgresql/$PG_VERSION/main/postgresql.conf /etc/postgresql/$PG_VERSION/main/postgresql.conf.bak
  sudo sed -i "s/^#listen_addresses = 'localhost'/listen_addresses = 'localhost'/" /etc/postgresql/$PG_VERSION/main/postgresql.conf

  # Enable SSL in postgresql.conf (optional)
  sudo sed -i "s/^#ssl = off/ssl = on/" /etc/postgresql/$PG_VERSION/main/postgresql.conf

  # Restart PostgreSQL to apply changes
  sudo systemctl restart postgresql

  # Set strong password for default 'postgres' user
  # echo "Enter new password for 'postgres' user:"
  # sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'new_password';"
  
  # Firewall setup (example using UFW)
  sudo ufw disable
  sudo ufw allow 5432/tcp  # Allow PostgreSQL port
  sudo ufw enable         # Enable firewall (careful if accessing remotely)

  echo "PostgreSQL secured successfully!"

}


#actually running the script
unalias -a #Get rid of aliases
echo "unalias -a" >> /root/.bashrc # gets rid of aliases when root
cd $(dirname $(readlink -f $0))
if [ "$(id -u)" != "0" ]; then
  echo "Please run as root"
  exit
else
  menu
fi
