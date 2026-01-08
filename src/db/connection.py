import mysql.connector
from mysql.connector.connection import MySQLConnection

def get_connection (
    host: str = "localhost",
    user: str = "root",
    password: str = "",
    database: str = "sport_manager"
) -> MySQLConnection:
    return mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        database=database
    )