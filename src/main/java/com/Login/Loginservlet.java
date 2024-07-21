package com.Login;

import com.Database.Dbconnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/Loginservlet")
public class Loginservlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        try {
            String qry = "select customer_id, customer_email, customer_password from userdetails where customer_email = ?";
            PreparedStatement statement = Dbconnection.prepareStatement(qry);
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            
            if (rs.next()) {
                String storedPassword = rs.getString("customer_password");
                if (password.equals(storedPassword)) {

                    int user_id = rs.getInt("customer_id");
                    String name = rs.getString("customer_email");
                    HttpSession session = request.getSession();
                    session.setAttribute("cid", user_id);
                    session.setAttribute("name", name);
                    updateLoggedInUsersCount(getServletContext(), 1);

                    response.sendRedirect("Home.jsp");
                    return;
                } else {
                    request.setAttribute("password_error", "Invalid password!");

                }
            } else {

                request.setAttribute("email_error", "User does not exist!");


            }
            RequestDispatcher dispatcher = request.getRequestDispatcher("lo.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    private void updateLoggedInUsersCount(ServletContext context, int increment) {
        Integer loggedInUsersCount = (Integer) context.getAttribute("loggedInUsersCount");
        if (loggedInUsersCount == null) {
            loggedInUsersCount = 0;
        }
        loggedInUsersCount += increment;
        context.setAttribute("loggedInUsersCount", loggedInUsersCount);
    }
}
