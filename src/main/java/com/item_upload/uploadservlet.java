package com.item_upload;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import com.Database.*;
@WebServlet(name = "uploadservlet", urlPatterns = {"/uploadservlet"})
@MultipartConfig


public class uploadservlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out=response.getWriter();
	try
	{
		String is=null;
		InputStream inputstream=null;
		String itemname=request.getParameter("itemname");
		int  itemprice=Integer.parseInt(request.getParameter("price"));
		int available=Integer.parseInt(request.getParameter("item"));
		Part filepath=request.getPart("img");
		inputstream=filepath.getInputStream();
		String qry="Insert into product_details(i_id,i_name,i_price,i_img,i_available)values(?,?,?,?,?)";
		PreparedStatement statement=Dbconnection.prepareStatement(qry);
		statement.setString(1,is);
		statement.setString(2,itemname);
		statement.setInt(3,itemprice);
		statement.setBlob(4,inputstream);
		statement.setInt(5, available);
		int check=statement.executeUpdate();
		if(check>0)
		{
		 out.print("sucess");
		}
		else
		{
			out.println("failed");
		}
    }
     catch(Exception eh)
     {
         System.out.println(eh);
     }
	}
}
