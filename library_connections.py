import pandas as pd
import numpy as np
import psycopg2
from psycopg2 import Error
import configparser


# Function to create a connection to the PostgreSQL database
def create_connection():

    # Read the config.ini file
    config = configparser.ConfigParser()
    config.read('config.ini')
    section = 'db library credentials'

    try:
        connection = psycopg2.connect(
            user=config.get(section, 'user'),
            password=config.get(section, 'password'),
            host=config.get(section, 'host'),
            port=config.get(section, 'port'),
            database=config.get(section, 'database'),
        )
        return connection
    except Error as e:
        print(f"Error connecting to PostgreSQL: {e}")
        return None
    

# Function return a PostgreSQL database string URI
def create_postgres_uri():

    config = configparser.ConfigParser()
    config.read('config.ini')
    section = 'db library credentials'

    user        = config.get(section, 'user')
    password    = config.get(section, 'password')
    host        = config.get(section, 'host')
    port        = config.get(section, 'port')
    database    = config.get(section, 'database')

    uri = f"postgresql://{user}:{password}@{host}:{port}/{database}"
    return uri


# Function to execute query
def execute_query(query):

    # Create a connection to the PostgreSQL database
    connection = create_connection()

    if connection:
            
        try:
            with connection.cursor() as cursor:
                cursor.execute(query)
            connection.commit()
        except Error as e:
            print(f"Error creating tables: {e}")

        # Close the database connection
        connection.close()
