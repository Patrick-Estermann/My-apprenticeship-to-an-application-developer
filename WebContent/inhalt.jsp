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
	ArrayList<Inhalt> inhaltExceptSchere = InhaltStore.getInstance().getInhaltExceptSchere();
	ArrayList<Kunde> kunde = KundeStore.getInstance().getKunde();
%>
<!DOCTYPE html>
<html lang="de-ch">
<head>
<meta charset="utf-8">
<title>Inhalt definieren</title>
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
	</header>
	<nav>	
		<form class="form" name="backHomeForm" method="post" action="index.jsp">
			<button class="backHomeBtn btn" type="submit">zurück nach Home</button>
		</form>
	</nav>
	<main>
		<div class="artikelImg">
		<%
		if(request.getParameter("artikelId") != null){
			Artikel artikelById = ArtikelStore.getInstance().getArtikelById(Integer.parseInt(request.getParameter("artikelId")));
		%>
			<img src="content/img/<%=artikelById.getIcon() %>">
		<%
		}
		else{
			Artikel artikelById = ArtikelStore.getInstance().getArtikelById(Integer.parseInt(request.getParameter("artikelIdSchachtel")));
		%>
			<img src="content/img/<%=artikelById.getIcon() %>">
		<%
		}
		%>
		</div>
		<div id="shop-content">
		<%
			// durch Artikelliste iterieren und Inhalte ausgeben 
			if(request.getParameter("artikelIdSchachtel") != null) {
				Artikel artikelByIdSchachtel = ArtikelStore.getInstance().getArtikelById(Integer.parseInt(request.getParameter("artikelIdSchachtel")));
				for (int i = 0; i < inhaltExceptSchere.size(); i++) {
					Inhalt printInhaltExceptSchere = (Inhalt) inhaltExceptSchere.get(i);
		%>
			<form class="form" action="WarenkorbEdit" method="post">
				<div class="shopImage-content">
					<img src="content/img/<%=printInhaltExceptSchere.getIconPath()%>">
				</div>
				<div class="shopDetail-content">
					<p><%=printInhaltExceptSchere.getBezeichnung()%></p>
				</div>
				<div class="shopPreis-content">
					<p>Preis: <%=printInhaltExceptSchere.getPreis()%> sFr.</p>
				</div>
				<div class="shopAdd-content">
					<input type="hidden" name="artikelIdSchachtel" value="<%=Integer.parseInt(request.getParameter("artikelIdSchachtel"))%>"/>
					<input type="hidden" name="inhaltSchachtel" value="<%=printInhaltExceptSchere.getInhaltId()%>"/>
					<button class="btn" type="submit">Add Warenkorb</button>
				</div>
			</form>
		<%		
				}
		%>
			<div class="cllfx"></div>
			<div class="warenkorb"><h2>Warenkorb</h2></div>
			<div id="warenkorb-content">
				<table>
					<tr>
						<th></th>
						<th>Bezeichnung</th>
						<th>Anzahl</th>
						<th>Preis in sFr.</th>
					</tr>
		<%
					if(session.getAttribute("wkInhaltSchachtel")!=null && ((List<String>)session.getAttribute("wkInhaltSchachtel")).size()>0) {
						List<String> wkInhaltSchachtel = (List<String>)session.getAttribute("wkInhaltSchachtel");
						Double summe = 0.00;
		%>
					<tr>
						<td></td>
						<td><%=artikelByIdSchachtel.getBezeichnung() %></td>
						<td>1</td>
						<td><%=artikelByIdSchachtel.getPreis() %></td>
					</tr>
		<%
						summe += artikelByIdSchachtel.getPreis();
						for(String inhaltId : wkInhaltSchachtel){
							int wkId = Integer.parseInt(inhaltId);
							Inhalt inhaltById = InhaltStore.getInstance().getInhaltById(wkId);
							int rmIndex = wkInhaltSchachtel.indexOf(inhaltId);
		%>
					<tr>
						<td>
							<form action="WarenkorbEdit" method="post">
								<input type="hidden" name="artikelIdSchachtel" value="<%=Integer.parseInt(request.getParameter("artikelIdSchachtel"))%>"/>
								<input type="hidden" name="removeSchachtel" value="<%=rmIndex%>">
								<button class="btn" type="submit" class="wahrenkorbDelete-button">X</button>
							</form>
						</td>
						<td><%=inhaltById.getBezeichnung() %></td>
						<td>1</td>
						<td><%=inhaltById.getPreis() %></td>
					</tr>
		<%
					summe += inhaltById.getPreis();
					}
					
					summe *= 1.025;
					summe = Math.round((Math.round(summe / 0.05) * 0.05) * 100.00) / 100.00;
		%>
					<tr>
						<td></td>
						<td>Gesamttotal inkl</td>
						<td>2.5% MWST</td>
						<td><%=summe%></td>
					</tr>
		<% 
					}
		%>
				</table>
				<div>
				<%
					if(session.getAttribute("wkInhaltSchachtel")!=null && ((List<String>)session.getAttribute("wkInhaltSchachtel")).size()>0) {
				%>
					<form class="form" name="bezahlungform" method="post" action="bezahlung.jsp">
						<input type="hidden" name="artikelIdSchachtel" value="<%=Integer.parseInt(request.getParameter("artikelIdSchachtel"))%>"/>
						<input type="hidden" name="wkInhaltSchachtel" value="<%=session.getAttribute("wkInhaltSchachtel")%>"/>
						<button class="bezahlBtn btn" type="submit">Kasse</button>
					</form>
				<%
					}
					else{
				%>
					<button class="bezahlBtn btn" type="button" disabled>Kasse</button>
				<%
					}
				%>
				</div>
			</div>
		<%
			}
			else{
				Artikel artikelById = ArtikelStore.getInstance().getArtikelById(Integer.parseInt(request.getParameter("artikelId")));
				for (int i = 0; i < inhalt.size(); i++) {
					Inhalt printInhalt = (Inhalt) inhalt.get(i);
		%>
			<form class="form" action="WarenkorbEdit" method="post">
				<div class="shopImage-content">
					<img src="content/img/<%=printInhalt.getIconPath()%>">
				</div>
				<div class="shopDetail-content">
					<p><%=printInhalt.getBezeichnung()%></p>
				</div>
				<div class="shopPreis-content">
					<p>Preis: <%=printInhalt.getPreis()%> sFr.</p>
				</div>
				<div class="shopAdd-content">
					<input type="hidden" name="artikelId" value="<%=Integer.parseInt(request.getParameter("artikelId"))%>"/>
					<input type="hidden" name="inhaltId" value="<%=printInhalt.getInhaltId()%>"/>
					<button class="btn" type="submit">Add Warenkorb</button>
				</div>
			</form>
		<%
				}
		%>
			<div class="cllfx"></div>
			<div class="warenkorb"><h2>Warenkorb</h2></div>
			<div id="warenkorb-content">
				<table>
					<tr>
						<th></th>
						<th>Bezeichnung</th>
						<th>Anzahl</th>
						<th>Preis in sFr.</th>
					</tr>
		<%
			//List<String> wkInhalt = (List<String>)session.getAttribute("wkInhalt");
				if(session.getAttribute("wkInhalt") != null && ((List<String>)session.getAttribute("wkInhalt")).size()>0) {
					List<String> wkInhalt = (List<String>)session.getAttribute("wkInhalt");
					Double summe = 0.00;
		%>
					<tr>
						<td></td>
						<td><%=artikelById.getBezeichnung() %></td>
						<td>1</td>
						<td><%=artikelById.getPreis() %></td>
					</tr>
		<%
					summe += artikelById.getPreis();
					for(String inhaltId : wkInhalt){
						int wkId = Integer.parseInt(inhaltId);
						Inhalt inhaltById = InhaltStore.getInstance().getInhaltById(wkId);
						int rmIndex = wkInhalt.indexOf(inhaltId);
		%>
					<tr>
						<td>
							<form action="WarenkorbEdit" method="post">
								<input type="hidden" name="artikelId" value="<%=Integer.parseInt(request.getParameter("artikelId"))%>"/>
								<input type="hidden" name="remove" value="<%=rmIndex%>">
								<button class="btn" type="submit" class="wahrenkorbDelete-button">X</button>
							</form>
						</td>
						<td><%=inhaltById.getBezeichnung() %></td>
						<td>1</td>
						<td><%=inhaltById.getPreis() %></td>
					</tr>
		<%
					summe += inhaltById.getPreis();
					}
					
					summe *= 1.025;
					summe = Math.round((Math.round(summe / 0.05) * 0.05) * 100.00) / 100.00;
		%>
					<tr>
						<td></td>
						<td>Gesamttotal inkl</td>
						<td>2.5% MWST</td>
						<td><%=summe%></td>
					</tr>
		<%
				}
		%>
				</table>
				<div>
					<%
						if(session.getAttribute("wkInhalt")!=null && ((List<String>)session.getAttribute("wkInhalt")).size()>0) {
					%>
						<form name="bezahlungform" method="post" action="bezahlung.jsp">
							<input type="hidden" name="artikelId" value="<%=Integer.parseInt(request.getParameter("artikelId"))%>"/>
							<input type="hidden" name="wkInhalt" value="<%=session.getAttribute("wkInhalt")%>"/>
							<button class="bezahlBtn btn" type="submit">Kasse</button>
						</form>
					<%
						}
						else{
					%>
						<button class="bezahlBtn btn" type="button" disabled>Kasse</button>
					<%
						}
					%>
				</div>
			</div>
		<%
			}
		%>
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
					<%
						if(request.getParameter("artikelIdSchachtel") != null) {
					%>
					<input type="hidden" name="artikelIdSchachtel" value="<%=Integer.parseInt(request.getParameter("artikelIdSchachtel"))%>">
					<%
						}
						else{
					%>
					<input type="hidden" name="artikelId" value="<%=Integer.parseInt(request.getParameter("artikelId"))%>">
					<%
						}
					%>
						<button class="loginBtn btn" type="submit">Login</button>
					</div>
				</fieldset>
			</form>
		</div>
	</main>
	<footer>
		<div id="footer-content">
		</div>
	</footer>
	<script src="content/js/user_pwd.js" charset="utf-8"></script>
</body>
</html>