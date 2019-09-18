            MySqlCommand SpSimple;
            SpSimple = new MySqlCommand("sp_simple", myConnection);
            SpSimple.CommandType = CommandType.StoredProcedure;
            SpSimple.ExecuteNonQuery();
