package com.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Database.Dbconnection;

/**
 * Servlet implementation class editproductservlet
 */
@WebServlet("/editproductservlet")
public class editproductservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String productName = request.getParameter("productName");
        double productPrice = Double.parseDouble(request.getParameter("productPrice"));
        int productQuantity = Integer.parseInt(request.getParameter("productQuantity"));
      try {
            Connection conn = Dbconnection.getConnection();
            String sql = "UPDATE product_details SET i_name=?, i_price=?, i_available=? WHERE i_id=?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, productName);
            statement.setDouble(2, productPrice);
            statement.setInt(3, productQuantity);
            statement.setInt(4,productId);
            
            if(statement.executeUpdate()>0)
            {
            	response.sendRedirect("admindashboard.jsp");
            }
            
            statement.close();
            conn.close();
        } catch (Exception ex) {
            ex.printStackTrace();
            response.getWriter().println("Error updating product.");
        }
    }

}
