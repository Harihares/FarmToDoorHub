package com.chatbot;import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class chatbot extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");

        String userMessage = request.getParameter("message");

        
        String chatbotResponse = processUserMessage(userMessage);

        
        response.getWriter().write(chatbotResponse);
    }

    
    private String processUserMessage(String userMessage) {
       
    	    String message = userMessage.toLowerCase();

    	
    	    if (message.equals("hello")) {
    	        return "Hello! How can I assist you today?";
    	    } else if (message.contains("thank you")) {
    	        return "You're welcome!";
    	    } else if (message.contains("price")) {
    	        return "Please specify the product you're interested in for pricing information.";
    	    } else {
    	        
    	        return "I'm sorry, I didn't understand your request.";
    	    }
    	

    }
}
