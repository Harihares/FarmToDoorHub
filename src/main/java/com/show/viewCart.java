package com.show;

import java.beans.Statement;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.Database.Dbconnection;

@WebServlet("/viewcart")
public class viewCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		 int customer_id=Integer.parseInt(request.getParameter("c_id"));
		int product_id=Integer.parseInt(request.getParameter("p_id"));
		if(product_id!=0||customer_id!=0)
		{
			int price;
			int original_price=0;
			int original_quantity=0;
			 int quantity = Integer.parseInt(request.getParameter("quantity"));
			try {
			   original_price=fetchOriginalPrice(product_id);
			   original_quantity=fetchoriginalquantity(product_id);
			} catch (SQLException e) {
				e.printStackTrace();				
			}
			if(quantity>original_quantity) {
				response.setContentType("text/plain");
				PrintWriter out=response.getWriter();
				out.print("Sorry only"+original_quantity+"available");
				out.close();
				return;
			}
			else
			{
			price=original_price*quantity;
			int updatequantity=original_quantity-quantity;
			try {
				updateproduct_details(updatequantity,product_id);
				Add_to_cart(price,updatequantity,customer_id,product_id);
				response.setContentType("text/plain");
				PrintWriter out=response.getWriter();
				out.print("1 item added to cart!");
				out.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			}
		}
		else
		{
			response.sendRedirect("lo.jsp");
		}
	}
	public int fetchOriginalPrice(int p_id) throws SQLException {
	    int original_price = 0; // Initialize original_price variable outside the if block

	    try {
	        java.sql.Statement st = Dbconnection.Statement();
	        ResultSet rs = st.executeQuery("SELECT i_price FROM product_details WHERE i_id = "+p_id+"");

	        if (rs.next()) {
	            original_price = rs.getInt("i_price"); // Use getInt() directly to retrieve integer values
	        }

	        rs.close(); // Close the ResultSet
	        st.close(); // Close the Statement
	    } catch (SQLException ex) {
	        ex.printStackTrace(); // Handle or log the exception appropriately
	    }
	    return original_price;
	}

	public int fetchoriginalquantity(int p_id)throws SQLException
	{
		int original_quantity=0; 
		java.sql.Statement st = Dbconnection.Statement();
	     ResultSet rs = st.executeQuery("SELECT i_available FROM product_details WHERE i_id="+p_id+"");
	     if(rs.next())
	     {
	     original_quantity=rs.getInt("i_available");
	     }
		return original_quantity;
	}
	public void  updateproduct_details(int updatequantity,int product_id)throws SQLException
	{
		PreparedStatement ps=Dbconnection.prepareStatement("update product_details set i_available=? where i_id=?");
		ps.setInt(1,updatequantity);
		ps.setInt(2, product_id);
		ps.executeUpdate();
	}
	public void Add_to_cart(int price,int updatequantity,int customer_id,int product_id)throws SQLException
	{
		String item_name=null;
		java.sql.Statement st=Dbconnection.Statement();
		ResultSet rs=st.executeQuery("Select i_name,i_img from product_details where i_id="+product_id+"");
		if(rs.next())
		{
	    item_name=rs.getString("i_name");
	    InputStream imagestream=rs.getBinaryStream("i_img");
		PreparedStatement ps=Dbconnection.prepareStatement("Insert into "
				+ "cart(item_name,item_quantity,item_price,customer_id,item_image)values(?,?,?,?,?)");
		ps.setString(1, item_name);
		ps.setInt(2,updatequantity);
		ps.setInt(3,price);
		ps.setInt(4,customer_id);
		ps.setBinaryStream(5, imagestream);
		ps.executeUpdate();
		}
	}
	
}