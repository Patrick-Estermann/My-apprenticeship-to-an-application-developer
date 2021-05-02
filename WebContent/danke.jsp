<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page session = "true" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import="ch.happy.webshop.model.Artikel"%>
<%@ page import="ch.happy.webshop.model.Inhalt"%>
<%@ page import="ch.happy.webshop.model.Kunde"%>
<%@ page import="ch.happy.webshop.model.Bestellung"%>
<%@page import="ch.happy.webshop.model.Warenkorb"%>
<%@ page import="ch.happy.webshop.database.ArtikelStore"%>
<%@ page import="ch.happy.webshop.database.InhaltStore"%>
<%@ page import="ch.happy.webshop.database.KundeStore"%>
<%@ page import="ch.happy.webshop.database.BestellungStore"%>
<%@ page import="ch.happy.webshop.database.DatabaseAccess"%>
    <%
	// Get session creation time.
   Date createTime = new Date(session.getCreationTime());
   
   // Get last access time of this Webpage.
   Date lastAccessTime = new Date(session.getLastAccessedTime());

   String title = "Welcome Back to my website";
   Integer visitCount = new Integer(0);
   String visitCountKey = new String("visitCount");
   String userIDKey = new String("userID");
   String userID = new String("ABCD");

   // Check if this is new comer on your Webpage.
   if (session.isNew() ){
      title = "Welcome to my website";
      session.setAttribute(userIDKey, userID);
      session.setAttribute(visitCountKey,  visitCount);
   } 
   visitCount = (Integer)session.getAttribute(visitCountKey);
   visitCount = visitCount + 1;
   userID = (String)session.getAttribute(userIDKey);
   session.setAttribute(visitCountKey,  visitCount);
%>
<!DOCTYPE html>
<html lang="de-ch">
<head>
<meta charset="utf-8">
<title>Danke</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="content/css/bootstrap.css">
<link rel="stylesheet" href="content/css/style.css">
</head>
<body>
	<div id="logo-content">
		<a href="index.jsp">
			<img src="content/img/logo.jpg">
		</a>
	</div>
	<form name="backHomeForm" method="post" action="index.jsp">
		<button class="backHomeBtn" type="submit">zurück nach Home</button>
	</form>
	<h1>Danke für Ihren Einkauf</h1>
	<h2>Die Bestellung wurde in Auftrag gegeben.</h2>
	<%
	session.removeAttribute("wkInhaltSchachtel");
	session.removeAttribute("wkInhalt");
	%>
</body>
</html>