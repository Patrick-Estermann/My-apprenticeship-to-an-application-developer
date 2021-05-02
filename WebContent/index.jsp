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
<%
	ArrayList<Artikel> artikel = ArtikelStore.getInstance().getArtikel();
	ArrayList<Inhalt> inhalt = InhaltStore.getInstance().getInhalt();
	ArrayList<Kunde> kunde = KundeStore.getInstance().getKunde();
	ArrayList<Bestellung> bestellung = BestellungStore.getInstance().getBestellung();
	Artikel artikelSession = new Artikel();
%>

<!DOCTYPE html>
<html lang="de-ch">
<head>
<meta charset="utf-8">
<title>Übersicht</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="content/css/bootstrap.css">
<link rel="stylesheet" href="content/css/style.css">
</head>
<body>
	<header>
		<div id="logo-content">
			<a href="index.jsp">
			<img src="content/img/logo.jpg">
			</a>
		</div>
		<h1>Herzlich Willkommen im Happy Writer Webshop</h1>
	</header>
	<main>
		<div id="shop-content">
			<%
				// durch Artikelliste iterieren und Inhalte ausgeben 
				for (int i = 0; i < artikel.size(); i++) {
				Artikel printArtikel = (Artikel) artikel.get(i);
					if(printArtikel.getArtikelId() == 2)
					{
			%>
				<form class="artikelForm form" action="WarenkorbEdit" method="post">
					<div class="shopImage-content">
							<img src="content/img/<%=printArtikel.getIcon()%>">
					</div>
					<div class="shopDetail-content">
						<p><%=printArtikel.getBezeichnung()%></p>
					</div>
					<div class="shopPreis-content">
						<p>Preis: <%=printArtikel.getPreis()%> sFr.</p>
					</div>
					<div class="submit">
						<input type="hidden" name="artikelIdSchachtel" value="<%=printArtikel.getArtikelId()%>"/>
						<button class="btn" type="submit">Inhalt definieren</button>
					</div>
				</form>
			<%
					}
					else{
			%>
				<form class="artikelForm form" action="WarenkorbEdit" method="post">
					<div class="shopImage-content">
							<img src="content/img/<%=printArtikel.getIcon()%>">
					</div>
					<div class="shopDetail-content">
						<p><%=printArtikel.getBezeichnung()%></p>
					</div>
					<div class="shopPreis-content">
						<p>Preis: <%=printArtikel.getPreis()%> sFr.</p>
					</div>
					<div class="submit">
						<input type="hidden" name="artikelId" value="<%=printArtikel.getArtikelId()%>"/>
						<button class="btn" type="submit">Inhalt definieren</button>
					</div>
				</form>
			<%
					}
				}
			%>
		</div>
		<div class="cllfx"></div>
		<div class="user-content">
			<form id="userform" class="form" name="userform" action="god.jsp" method="post" onsubmit="return check()" novalidate>
				<fieldset>
					<legend>Einloggen</legend>
					<div class="username-content">
						<label>Benutzername</label>
						<input class="username" type="text" name="username" autofocus required><label id="checkusername"></label>
					</div>
					<div class="password-content">
						<label>Passwort</label>
						<input class="password" type="password" name="password" required><label id="checkpassword"></label>
					</div>
					<div id="login-content">
						<button class="loginBtn btn" type="submit">Login</button>
					</div>
				</fieldset>
			</form>
		</div>
	</main>
	<footer>
		<div id="footer-content">
			<a href="impressum.html"></a>
		</div>
	</footer>
	<script src="content/js/user_pwd.js" charset="utf-8"></script>
</body>
</html>