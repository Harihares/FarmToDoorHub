package com.show;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import com.Database.*;

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession session=request.getSession();
        int customerIdStr =(int) session.getAttribute("c_id");
        int productIdStr=(int) session.getAttribute("p_id");
        


        try {
            Connection con = Dbconnection.getConnection();          
            
            PreparedStatement pstmt = con.prepareStatement("INSERT INTO feedbacck (customer_id, feedback,product_id) VALUES (?, ?,?)");
            pstmt.setInt(1, customerIdStr);
            String feedback = request.getParameter("feedback");
            pstmt.setString(2, feedback);
			pstmt.setInt(3, productIdStr);
            pstmt.executeUpdate();
            response.sendRedirect("showItem?sid="+productIdStr+"&c_id="+productIdStr+"");
        } catch(Exception e) {
            out.println(e);
        }
    }
}
