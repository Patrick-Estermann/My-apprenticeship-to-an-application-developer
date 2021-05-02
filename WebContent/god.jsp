<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page session = "true" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import="ch.happy.webshop.controller.NeueArtikel"%>
<%@ page import="ch.happy.webshop.controller.ArtikelEntfernen"%>
<%@ page import="ch.happy.webshop.controller.NeuerInhalt"%>
<%@ page import="ch.happy.webshop.controller.InhaltEntfernen"%>
<%@ page import="ch.happy.webshop.controller.NeuerKunde"%>
<%@ page import="ch.happy.webshop.controller.KundeEntfernen"%>
<%@ page import="ch.happy.webshop.controller.NeueBestellung"%>
<%@ page import="ch.happy.webshop.controller.NeueBestellPosition"%>
<%@ page import="ch.happy.webshop.controller.NeueBestellungKonfiguration"%>
<%@ page import="ch.happy.webshop.controller.BestellungEntfernen"%>
<%@ page import="ch.happy.webshop.controller.BestellPositionEntfernen"%>
<%@ page import="ch.happy.webshop.controller.BestellungKonfigurationEntfernen"%>
<%@ page import="ch.happy.webshop.model.Artikel"%>
<%@ page import="ch.happy.webshop.model.Inhalt"%>
<%@ page import="ch.happy.webshop.model.Kunde"%>
<%@ page import="ch.happy.webshop.model.Bestellung"%>
<%@ page import="ch.happy.webshop.model.BestellPosition"%>
<%@ page import="ch.happy.webshop.model.BestellKonfiguration"%>
<%@ page import="ch.happy.webshop.database.ArtikelStore"%>
<%@ page import="ch.happy.webshop.database.InhaltStore"%>
<%@ page import="ch.happy.webshop.database.KundeStore"%>
<%@ page import="ch.happy.webshop.database.BestellungStore"%>
<%@ page import="ch.happy.webshop.database.BestellPositionStore"%>
<%@ page import="ch.happy.webshop.database.BestellKonfigurationStore"%>
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
	ArrayList<BestellPosition> bestellPosition = BestellPositionStore.getInstance().getBestellPosition();
	ArrayList<BestellKonfiguration> bestellKonfiguration = BestellKonfigurationStore.getInstance().getBestellKonfiguration();
%>
<!DOCTYPE html>
<html lang="de-ch">
<head>
<meta charset="ISO-8859-1">
<title>GodMode</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="content/css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<header>
		<div id="logo-content">
		</div>
	</header>
	<h1>Sie sind als Admin eingeloggt</h1>
	<div id="logout">
		<form name="logoutform" method="post" action="index.jsp">
			<button class="logoutBtn prev" type="submit">Logout</button>
		</form>
	</div>
	<div id="artikel">
		<div id="neuerArtikel">
			<form id="newArtForm" name="newArtForm" method="get" action="NeueArtikel">
				<fieldset>
					<legend>Neuer Artikel hinzufügen</legend>
					<label>Kunden Id</label>
					<%
						ArrayList<Artikel> bestArtikel = ArtikelStore.getInstance().getArtikel();
						int newArtikelId = bestArtikel.size() + 1;
					%>
					<input type="hidden" name="id" value="<%=newArtikelId %>"><br>
					<label>Bezeichnung</label>
					<input type="text" name="bezeichnung"><br>
					<label>Preis</label>
					<input type="text" name="preis" placeholder="z.B. '12.15'"><br>
					<label>Image Path</label>
					<input type="text" name="image_path" placeholder="z.B. 'rucksack.jpg'"><br>
					<input type="hidden" name="username" value="admin">
					<input type="hidden" name="password" value="klapp42stuhl">
					<button type="submit">Hinzufügen</button>
				</fieldset>
			</form>
		</div>
		<div id="artikelListe">
			<table>
				<tr>
					<th></th>
					<th>Artikel Id</th>
					<th>Bezeichnung</th>
					<th>Preis</th>
					<th>Image Path</th>
				</tr>
				<%
					for (int i = 0; i < artikel.size(); i++) {
						Artikel printArtikel = (Artikel) artikel.get(i);
				%>
				<tr>
					<td>
						<form action="ArtikelEntfernen" method="get">
							<input type="hidden" name="username" value="admin">
							<input type="hidden" name="password" value="klapp42stuhl">
							<input type="hidden" name="id" value="<%=printArtikel.getArtikelId()%>">
							<button type="submit" class="ArtikelDeleteBtn">X</button>
						</form>
					</td>
					<td><%=printArtikel.getArtikelId()%></td>
					<td><%=printArtikel.getBezeichnung()%></td>
					<td><%=printArtikel.getPreis() %></td>
					<td><%=printArtikel.getIcon() %></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
	</div>
	<div id="inhalt">
		<div id="neuerInhalt">
			<form id="newInhForm" name="newInhForm" method="get" action="NeuerInhalt">
				<fieldset>
					<legend>Neuer Inhalt hinzufügen</legend>
					<label>Inhalt Id</label>
					<%
						ArrayList<Inhalt> bestInhalt = InhaltStore.getInstance().getInhalt();
						int newInhaltId = bestInhalt.size() + 1;
					%>
					<input type="hidden" name="id" value="<%=newInhaltId %>"><br>
					<label>Bezeichnung</label>
					<input type="text" name="bezeichnung"><br>
					<label>Preis</label>
					<input type="text" name="preis" placeholder="z.B. '0.55'"><br>
					<label>Image Path</label>
					<input type="text" name="image_path" placeholder="z.B. 'Stift.jpg'"><br>
					<input type="hidden" name="username" value="admin">
					<input type="hidden" name="password" value="klapp42stuhl">
					<button type="submit">Hinzufügen</button>
				</fieldset>
			</form>
		</div>
		<div id="inhaltListe">
			<table>
				<tr>
					<th></th>
					<th>Inhalt Id</th>
					<th>Bezeichnung</th>
					<th>Preis</th>
					<th>Image Path</th>
				</tr>
				<%
					for (int i = 0; i < inhalt.size(); i++) {
						Inhalt printInhalt = (Inhalt) inhalt.get(i);
				%>
				<tr>
					<td>
						<form action="InhaltEntfernen" method="get">
							<input type="hidden" name="username" value="admin">
							<input type="hidden" name="password" value="klapp42stuhl">
							<input type="hidden" name="id" value="<%=printInhalt.getInhaltId()%>">
							<button type="submit" class="InhaltDeleteBtn">X</button>
						</form>
					</td>
					<td><%=printInhalt.getInhaltId()%></td>
					<td><%=printInhalt.getBezeichnung()%></td>
					<td><%=printInhalt.getPreis() %></td>
					<td><%=printInhalt.getIconPath() %></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
	</div>
	<div id="kunde">
		<div id="neuerKunde">
			<form id="newKunForm" name="newKunForm" method="get" action="NeuerKunde">
				<fieldset>
					<legend>Neuer Kunde hinzufügen</legend>
					<label>Kunde Id = </label>
					<%
						ArrayList<Kunde> bestKunde = KundeStore.getInstance().getKunde();
						int newKundeId = bestKunde.size() + 1;
					%>
					<input type="hidden" name="id" value="<%=newKundeId%>">
					<label><%= newKundeId%></label><br>
					<label>Vorname</label>
					<input type="text" name="vorname"><br>
					<label>Nachname</label>
					<input type="text" name="nachname"><br>
					<label>Strasse</label>
					<input type="text" name="strasse"><br>
					<label>PLZ</label>
					<input type="text" name="plz"><br>
					<label>Ort</label>
					<input type="text" name="ort"><br>
					<label>Telefonnummer</label>
					<input type="text" name="tel" placeholder="+41 79 777 77 77"><br>
					<label>Kunde seit</label>
					<input type="text" name="kunde_seit" placeholder="DD.MM.YYYY"><br>
					<input type="hidden" name="username" value="admin">
					<input type="hidden" name="password" value="klapp42stuhl">
					<button type="submit">Hinzufügen</button>
				</fieldset>
			</form>
		</div>
		<div id="kundeListe">
			<table>
				<tr>
					<th></th>
					<th>Kunde Id</th>
					<th>Vorname</th>
					<th>Nachname</th>
					<th>Strasse</th>
					<th>PLZ</th>
					<th>Ort</th>
					<th>Telefonnummer</th>
					<th>Kunde seit</th>
				</tr>
				<%
					for (int i = 0; i < kunde.size(); i++) {
						Kunde printKunde = (Kunde) kunde.get(i);
				%>
				<tr>
					<td>
						<form action="KundeEntfernen" method="get">
							<input type="hidden" name="username" value="admin">
							<input type="hidden" name="password" value="klapp42stuhl">
							<input type="hidden" name="id" value="<%=printKunde.getKundeId()%>">
							<button type="submit" class="InhaltDeleteBtn">X</button>
						</form>
					</td>
					<td><%=printKunde.getKundeId()%></td>
					<td><%=printKunde.getVorname()%></td>
					<td><%=printKunde.getNachname()%></td>
					<td><%=printKunde.getStrasse()%></td>
					<td><%=printKunde.getPlz()%></td>
					<td><%=printKunde.getOrt()%></td>
					<td><%=printKunde.getTelefon()%></td>
					<td><%=printKunde.getKundeSeit()%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
	</div>
	<div id="bestellung">
		<div id="neueBestellung">
			<form id="newBestForm" name="newBestForm" method="get" action="NeueBestellung">
				<fieldset>
					<legend>Neue Bestellung hinzufügen</legend>
					<label>Bestellung Id = </label>
					<%
						ArrayList<Bestellung> bestBestellung = BestellungStore.getInstance().getBestellung();
						int newBestellungId = bestBestellung.size() + 1;
					%>
					<input type="hidden" name="id" value="<%=newBestellungId%>">
					<label><%=newBestellungId %></label><br>
					<label>Kunde Id</label>
					<input type="number" name="kunde_id"><br>
					<label>Datum</label>
					<input type="text" name="datum" placeholder="DD.MM.YYYY"><br>
					<label>Bemerkungen</label>
					<input type="text" name="bemerkungen"><br>
					<input type="hidden" name="username" value="admin">
					<input type="hidden" name="password" value="klapp42stuhl">
					<button type="submit">Hinzufügen</button>
				</fieldset>
			</form>
		</div>
		<div id="bestellungListe">
			<table>
				<tr>
					<th></th>
					<th>Bestellung Id</th>
					<th>Kunde Id</th>
					<th>Datum</th>
					<th>Bemerkungen</th>
				</tr>
				<%
					for (int i = 0; i < bestellung.size(); i++) {
						Bestellung printBestellung = (Bestellung) bestellung.get(i);
				%>
				<tr>
					<td>
						<form action="BestellungEntfernen" method="get">
							<input type="hidden" name="username" value="admin">
							<input type="hidden" name="password" value="klapp42stuhl">
							<input type="hidden" name="id" value="<%=printBestellung.getBestellungId()%>">
							<button type="submit" class="InhaltDeleteBtn">X</button>
						</form>
					</td>
					<td><%=printBestellung.getBestellungId()%></td>
					<td><%=printBestellung.getKundeId()%></td>
					<td><%=printBestellung.getDatum()%></td>
					<td><%=printBestellung.getBemerkungen()%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
	</div>
	<div id="bestellPosition">
		<div id="neueBestellPosition">
			<form id="newBestForm" name="newBestForm" method="get" action="NeueBestellPosition">
				<fieldset>
					<legend>Neue BestellPosition hinzufügen</legend>
					<label>BestellPosition Id = </label>
					<%
						ArrayList<BestellPosition> bestBestellPosition = BestellPositionStore.getInstance().getBestellPosition();
						int newBestellPositionId = bestBestellPosition.size() + 1;
					%>
					<input type="hidden" name="id" value="<%=newBestellPositionId%>">
					<label><%=newBestellPositionId %></label><br>
					<label>Artikel Id</label>
					<input type="number" name="artikelId"><br>
					<label>Bestellung Id</label>
					<input type="number" name="bestellId"><br>
					<input type="hidden" name="username" value="admin">
					<input type="hidden" name="password" value="klapp42stuhl">
					<button type="submit">Hinzufügen</button>
				</fieldset>
			</form>
		</div>
		<div id="bestellungListe">
			<table>
				<tr>
					<th></th>
					<th>BestellPosition Id</th>
					<th>Artikel Id</th>
					<th>Bestellung Id</th>
				</tr>
				<%
					for (int i = 0; i < bestellPosition.size(); i++) {
						BestellPosition printBestellPosition = (BestellPosition) bestellPosition.get(i);
				%>
				<tr>
					<td>
						<form action="BestellPositionEntfernen" method="get">
							<input type="hidden" name="username" value="admin">
							<input type="hidden" name="password" value="klapp42stuhl">
							<input type="hidden" name="id" value="<%=printBestellPosition.getBestellPosId()%>">
							<button type="submit" class="InhaltDeleteBtn">X</button>
						</form>
					</td>
					<td><%=printBestellPosition.getBestellPosId()%></td>
					<td><%=printBestellPosition.getArtikelId()%></td>
					<td><%=printBestellPosition.getBestellId()%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
	</div>
	<div id="bestellKonfiguration">
		<div id="neueBestellKonfiguration">
			<form id="newBestForm" name="newBestForm" method="get" action="NeueBestellungKonfiguration">
				<fieldset>
					<legend>Neue Bestellte Konfiguration hinzufügen</legend>
					<label>BestellPosition Id</label>
					<input type="number" name="bestellPosId"><br>
					<label>Inhalt Id</label>
					<input type="number" name="inhaltId"><br>
					<input type="hidden" name="username" value="admin">
					<input type="hidden" name="password" value="klapp42stuhl">
					<button type="submit">Hinzufügen</button>
				</fieldset>
			</form>
		</div>
		<div id="bestellungListe">
			<table>
				<tr>
					<th></th>
					<th>BestellPosition Id</th>
					<th>Inhalt Id</th>
				</tr>
				<%
					for (int i = 0; i < bestellKonfiguration.size(); i++) {
						BestellKonfiguration printBestellKonfiguration = (BestellKonfiguration) bestellKonfiguration.get(i);
				%>
				<tr>
					<td>
						<form action="BestellungEntfernen" method="get">
							<input type="hidden" name="username" value="admin">
							<input type="hidden" name="password" value="klapp42stuhl">
							<input type="hidden" name="id" value="<%=printBestellKonfiguration.getInhaltId()%>">
							<button type="submit" class="InhaltDeleteBtn">X</button>
						</form>
					</td>
					<td><%=printBestellKonfiguration.getBestellPosId()%></td>
					<td><%=printBestellKonfiguration.getInhaltId()%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
	</div>
</body>
</html>