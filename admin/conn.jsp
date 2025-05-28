<%-- 
    Document   : conn
    Created on : Feb 1, 2025, 6:34:06 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    Connection con=null;
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/truehealth","root","");
//        out.println("Connected");
    }
    catch(Exception e){
        
    }
%>
