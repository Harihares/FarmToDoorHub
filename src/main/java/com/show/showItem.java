package com.show;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Database.Dbconnection;

import io.jsonwebtoken.io.IOException;

@WebServlet("/showItem")
public class showItem extends HttpServlet {

    private static final long serialVersionUID = 1L;
    

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, java.io.IOException {
        int p_id = Integer.parseInt(request.getParameter("sid"));
        int customer_id = Integer.parseInt(request.getParameter("c_id"));
        
        List<Feedback> fdback = new ArrayList<>();
        try {
            ResultSet rs = Dbconnection.Statement().executeQuery("SELECT i_name, i_price, i_img FROM product_details WHERE i_id = " + p_id);
            if (rs.next()) {
                byte[] item_img = rs.getBytes("i_img");
                String item_name = rs.getString("i_name");
                System.out.println(item_name);
                int item_price = Integer.parseInt(rs.getString("i_price"));
                request.setAttribute("product_id", p_id);
                request.setAttribute("namedata", item_name);
                request.setAttribute("imagedata", item_img);
                request.setAttribute("pricedata", item_price);
                rs.close();
            }
            
            ResultSet Rs = Dbconnection.Statement().executeQuery("SELECT feedback, customer_id FROM feedbacck WHERE product_id = " + p_id);
            while (Rs.next()) {
                String feedbackname = Rs.getString("feedback");
                int cid = Rs.getInt("customer_id");
                String cname = fetchname(cid);
                Feedback fb = new Feedback(cid, cname, feedbackname);
                fdback.add(fb);
            }
            Rs.close();
        } catch (SQLException sq) {
            System.out.println(sq);
        }
        
        request.setAttribute("p_id", p_id);
        request.setAttribute("c_id", customer_id);
        request.setAttribute("feedbackList", fdback);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("showItem.jsp");
        dispatcher.forward(request, response);
    }
    public String fetchname(int cid) throws SQLException {
        String name = null;
        try {
            PreparedStatement pstmt = Dbconnection.prepareStatement("SELECT customer_name FROM userdetails WHERE customer_id = ?");
            pstmt.setInt(1, cid);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                name = rs.getString("customer_name");
            }
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return name;
    }

}
