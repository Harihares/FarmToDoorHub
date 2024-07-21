package com.Database;
import java.sql.*;
public class Dbconnection 
{
	 private static String username="root";
	 private static  String password="Hari@2002";
	 private static String path="jdbc:mysql://localhost/store";
	 static{
	  try
	  {
	 Class.forName("com.mysql.cj.jdbc.Driver");
	  }
	  catch(Exception e)
	  {
		  System.out.println(e);
	  }
	  }
	 public static Connection getConnection() throws SQLException {
	        return DriverManager.getConnection(path, username, password);
	    }

	    public static PreparedStatement prepareStatement(String sql)throws SQLException {
	        Connection connection = getConnection();
	        return connection.prepareStatement(sql);
	    }
	    public static Statement Statement()throws SQLException
	    {
	    	 Connection connection = getConnection();
	    	 return connection.createStatement();
	    }
	    public static ResultSet fetchallproduct() throws SQLException
	    {
	    	return Statement().executeQuery("select * from product_details");
	    }
	    public static ResultSet fetchalluserdetails()throws SQLException
	    {
	    	return Statement().executeQuery("select * from userdetails");
	    }

		public static PreparedStatement prepareStatementQuery(String checkitem) {
			// TODO Auto-generated method stub
			return null;
		}

		public static ResultSet fetchProduct_details(int p_id) {
			// TODO Auto-generated method stub
			return null;
		}

		public static ResultSet fetchFeedback(Object p_id) {
			// TODO Auto-generated method stub
			return null;
		}

		public static ResultSet fetchFeedback(int p_id) {
			// TODO Auto-generated method stub
			return null;
		}

		public static ResultSet fetchProductDetails(int p_id) {
			// TODO Auto-generated method stub
			return null;
		}
}
