import pandas as pd
from db import get_connection
from queries.classement import GET_CLASSEMENT_QUERY

def fetch_classement():
    conn = get_connection()
    df = pd.read_sql(GET_CLASSEMENT_QUERY, conn)
    conn.close()
    return df