import pandas as pd
from db.connection import get_connection
from queries.classement import GET_CLASSEMENT_QUERY

def fetch_classement() -> pd.DataFrame:
    """Récupère le classement des équipes sous forme de DataFrame."""
    conn = get_connection()
    df = pd.read_sql(GET_CLASSEMENT_QUERY, conn)
    conn.close()
    return df