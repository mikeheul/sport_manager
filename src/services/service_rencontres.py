import pandas as pd
from db import get_connection
from queries.query_rencontres import GET_RENCONTRES_QUERY

def fetch_rencontres():
    conn = get_connection()
    df = pd.read_sql(GET_RENCONTRES_QUERY, conn)
    conn.close()
    return df