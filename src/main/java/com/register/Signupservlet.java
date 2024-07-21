package com.register;

import com.Database.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Signupservlet")
public class Signupservlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String userid = null;
            String username = request.getParameter("name");
            String password = request.getParameter("password");
            int age = Integer.parseInt(request.getParameter("age"));
            String email = request.getParameter("email");
            String phno = request.getParameter("phoneno");
            String address = request.getParameter("Address");
            String pcd = request.getParameter("pincode");

            String checkEmailQuery = "SELECT * FROM userdetails WHERE customer_email = ?";
            PreparedStatement checkEmailStmt = Dbconnection.prepareStatement(checkEmailQuery);
            checkEmailStmt.setString(1, email);
            ResultSet rs = checkEmailStmt.executeQuery();

            if (rs.next()) {
                request.setAttribute("email_error", "Email already exists");
                RequestDispatcher dispatcher = request.getRequestDispatcher("sig.jsp");
                dispatcher.forward(request, response);
                return;
            }

            if (phno.length() != 10) {
                request.setAttribute("phone_error", "Phone number must be 10 digits");
                RequestDispatcher dispatcher = request.getRequestDispatcher("sig.jsp");
                dispatcher.forward(request, response);
                return;
            }

            String passwordPattern = "^(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{6,}$";
            if (!password.matches(passwordPattern)) {
                request.setAttribute("password_error", "Password must be at least 6 characters long and include at least one lowercase letter, one number, and one special character");
                RequestDispatcher dispatcher = request.getRequestDispatcher("sig.jsp");
                dispatcher.forward(request, response);
                return;
            }

            String qry = "INSERT INTO userdetails(customer_id, customer_name, customer_age, customer_email, customer_phno, customer_password, customer_address, pincode) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = Dbconnection.prepareStatement(qry);
            statement.setString(1, userid);
            statement.setString(2, username);
            statement.setInt(3, age);
            statement.setString(4, email);
            statement.setString(5, phno);
            statement.setString(6, password);
            statement.setString(7, address);
            statement.setString(8, pcd);

            int check = statement.executeUpdate();

            if (check > 0) {
                response.sendRedirect("lo.jsp");
            } else {
                request.setAttribute("msg", "Signup unsuccessful");
                RequestDispatcher dispatcher = request.getRequestDispatcher("sig.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("msg", "An error occurred: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("sig.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
