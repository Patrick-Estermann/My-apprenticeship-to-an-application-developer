<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page session = "true" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "java.time.LocalDateTime" %>
<%@ page import = "java.text.DateFormat" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.time.format.DateTimeFormatter" %>
<%@ page import = "java.util.Date" %>
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
<title>Kasse</title>
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
		<div id="filter-content">
		</div>
	</nav>
	<main>
	<%
		if(request.getParameter("artikelIdSchachtel") != null) {
	%>
		<form class="form" name="abbrechenForm" method="post" action="inhalt.jsp">
			<input type="hidden" name="artikelIdSchachtel" value="<%=request.getParameter("artikelIdSchachtel")%>">
			<button class="abbrechenBtn btn" type="submit">Kauf abbrechen</button>
		</form>
	<%
		}
		else{
	%>
		<form class="form" name="abbrechenForm" method="post" action="inhalt.jsp">
			<input type="hidden" name="artikelId" value="<%=request.getParameter("artikelId")%>">
			<button class="abbrechenBtn btn" type="submit">Kauf abbrechen</button>
		</form>
	<%
		}
	%>
		<div id="kundeRechnungsadresse">
			<form class="form" id="rechnungAdrForm" name="rechnungAdrForm" method="post" action="BezahlungRegistry" onsubmit="return checkForm()" novalidate>
				<fieldset>
					<legend>Rechnungsadresse</legend>
					<label for="vorname">Vorname*</label>
					<input type="text" name="vorname" autofocus required><label id="checkvorname"></label><br>
					<label for="nachname">Nachname*</label>
					<input type="text" name="nachname" required><label id="checknachname"></label><br>
					<label for="strasse">Strasse*</label>
					<input type="text" name="strasse" required><label id="checkstrasse"></label><br>
					<label for="plz">PLZ*</label>
					<input type="text" name="plz" required><label id="checkplz"></label><br>
					<label for="ort">Ort*</label>
					<input type="text" name="ort" required><label id="checkort"></label><br>
					<label for="tel">Telefonnummer*</label>
					<input type="text" name="tel" placeholder="+41 79 777 77 77" required><label id="checktel"></label><br>
					<label for="bemerkungen">Bemerkungen</label>
					<input type="text" name="bemerkungen">
					<%
						final DateFormat ddmmyyyy = new SimpleDateFormat("dd.MM.yyyy");
						Date date = new Date();
					%>	
					<input type="hidden" name="kunde_seit" value="<%=ddmmyyyy.format(date)%>">
					<input type="hidden" name="datum" value="<%=ddmmyyyy.format(date)%>">
					<%
					if(session.getAttribute("wkInhaltSchachtel")!=null && ((List<String>)session.getAttribute("wkInhaltSchachtel")).size()>0) {
						List<String> wkInhaltSchachtel = (List<String>)session.getAttribute("wkInhaltSchachtel");
						for(String inhaltId : wkInhaltSchachtel){
							int wkId = Integer.parseInt(inhaltId);
							Inhalt inhaltById = InhaltStore.getInstance().getInhaltById(wkId);
					%>
					<input type="hidden" name="inhaltId" value="<%=inhaltById.getInhaltId()%>">
					<%
						}
					}
					%>
					<%
					if(session.getAttribute("wkInhalt")!=null && ((List<String>)session.getAttribute("wkInhalt")).size()>0) {
						List<String> wkInhalt = (List<String>)session.getAttribute("wkInhalt");
						for(String inhaltId : wkInhalt){
							int wkId = Integer.parseInt(inhaltId);
							Inhalt inhaltById = InhaltStore.getInstance().getInhaltById(wkId);
					%>
					<input type="hidden" name="inhaltId" value="<%=inhaltById.getInhaltId()%>">
					<%
						}
					}
						if(request.getParameter("artikelIdSchachtel") != null) {
					%>
							<input type="hidden" name="artikelIdSchachtel" value="<%=request.getParameter("artikelIdSchachtel")%>">
					<%
						}
						else{
					%>
							<input type="hidden" name="artikelId" value="<%=request.getParameter("artikelId")%>">
					<%
						}
					%>
					<div id="shop-content">
						<table>
						<%
							if(request.getParameter("artikelIdSchachtel") != null) {
						%>
							<tr>
								<th>Bezeichnung</th>
								<th>Anzahl</th>
								<th>Preis in sFr.</th>
								<th>Bild</th>
							</tr>
						<%
								Artikel artikelByIdSchachtel = ArtikelStore.getInstance().getArtikelById(Integer.parseInt(request.getParameter("artikelIdSchachtel")));
								if(session.getAttribute("wkInhaltSchachtel")!=null && ((List<String>)session.getAttribute("wkInhaltSchachtel")).size()>0) {
									List<String> wkInhaltSchachtel = (List<String>)session.getAttribute("wkInhaltSchachtel");
									Double summe = 0.00;
						%>
							<tr>
								<td><%=artikelByIdSchachtel.getBezeichnung() %></td>
								<td>1</td>
								<td><%=artikelByIdSchachtel.getPreis() %></td>
								<td><img class="artikelWkImg" src="content/img/<%=artikelByIdSchachtel.getIcon()%>"></td>
							</tr>
						<%
									summe += artikelByIdSchachtel.getPreis();
									for(String inhaltId : wkInhaltSchachtel){
										int wkId = Integer.parseInt(inhaltId);
										Inhalt inhaltById = InhaltStore.getInstance().getInhaltById(wkId);
										int rmIndex = wkInhaltSchachtel.indexOf(inhaltId);
						%>
							<tr>
								<td><%=inhaltById.getBezeichnung() %></td>
								<td>1</td>
								<td><%=inhaltById.getPreis() %></td>
								<td><img class="inhaltWkImg" src="content/img/<%=inhaltById.getIconPath() %>"></td>
							</tr>
						<%
										summe += inhaltById.getPreis();
									}
							
									summe *= 1.025;
									summe = Math.round((Math.round(summe / 0.05) * 0.05) * 100.00) / 100.00;
						%>
							<tr>
								<td></td>
								<td></td>
								<td><%=summe%></td>
								<td>Gesamttotal inkl. 2.5% MWST</td>
							</tr>
						<% 
								}
							}
						%>
						<%
							if(request.getParameter("artikelId") != null) {
						%>
							<tr>
								<th>Bezeichnung</th>
								<th>Anzahl</th>
								<th>Preis in sFr.</th>
								<th>Bild</th>
							</tr>
						<%
								Artikel artikelById = ArtikelStore.getInstance().getArtikelById(Integer.parseInt(request.getParameter("artikelId")));
								if(session.getAttribute("wkInhalt")!=null && ((List<String>)session.getAttribute("wkInhalt")).size()>0) {
									List<String> wkInhalt = (List<String>)session.getAttribute("wkInhalt");
									Double summe = 0.00;
						%>
							<tr>
								<td><%=artikelById.getBezeichnung() %></td>
								<td>1</td>
								<td><%=artikelById.getPreis() %></td>
								<td><img class="artikelWkImg" src="content/img/<%=artikelById.getIcon()%>"></td>
							</tr>
						<%
									summe += artikelById.getPreis();
									for(String inhaltId : wkInhalt){
										int wkId = Integer.parseInt(inhaltId);
										Inhalt inhaltById = InhaltStore.getInstance().getInhaltById(wkId);
										int rmIndex = wkInhalt.indexOf(inhaltId);
						%>
							<tr>
								<td><%=inhaltById.getBezeichnung() %></td>
								<td>1</td>
								<td><%=inhaltById.getPreis() %></td>
								<td><img class="inhaltWkImg" src="content/img/<%=inhaltById.getIconPath() %>"></td>
							</tr>
						<%
										summe += inhaltById.getPreis();
									}
							
									summe *= 1.025;
									summe = Math.round((Math.round(summe / 0.05) * 0.05) * 100.00) / 100.00;
						%>
							<tr>
								<td></td>
								<td></td>
								<td><%=summe%></td>
								<td>Gesamttotal inkl. 2.5% MWST</td>
							</tr>
						<% 
								}
							}
						%>
						</table>
					</div>
					<button class="bezahlBtn btn" type="submit">Bezahlen</button>
				</fieldset>
			</form>
		</div>
	</main>
	<footer>
		<div id="footer-content">
			<a href="impressum.html"></a>
		</div>
	</footer>
	<script src="content/js/validator.js" charset="utf-8"></script>
</body>
</html>