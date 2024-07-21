package com.Login;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int enteredCode = Integer.parseInt(request.getParameter("code"));
        HttpSession session = request.getSession();
        int resetCode = (int) session.getAttribute("reset_code");

        if (enteredCode == resetCode) {
            response.sendRedirect("reset-assword.jsp");
        } else {
            String error = "Invalid reset code!";
            request.setAttribute("msg", error);
            RequestDispatcher dispatcher = request.getRequestDispatcher("verify-code.jsp");
            dispatcher.forward(request, response);
        }
    }
}
