package ch.happy.webshop.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ch.happy.webshop.database.BestellKonfigurationStore;
import ch.happy.webshop.database.BestellPositionStore;
import ch.happy.webshop.database.BestellungStore;
import ch.happy.webshop.database.InhaltStore;
import ch.happy.webshop.database.KundeStore;
import ch.happy.webshop.model.BestellKonfiguration;
import ch.happy.webshop.model.BestellPosition;
import ch.happy.webshop.model.Bestellung;
import ch.happy.webshop.model.Inhalt;
import ch.happy.webshop.model.Kunde;

/**
 * Servlet implementation class BezahlungRegistry
 */
@WebServlet("/BezahlungRegistry")
public class BezahlungRegistry extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BezahlungRegistry() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/**
		 * Definierung neuer Kunden / Rechnungsadressen
		 */
		Kunde neuerKunde = new Kunde();
		
		ArrayList<Kunde> kunde = KundeStore.getInstance().getKunde();
		int newKundeId = kunde.size() + 1;
		neuerKunde.setKundeId(newKundeId);
		
		neuerKunde.setVorname(request.getParameter("vorname"));
		
		neuerKunde.setNachname(request.getParameter("nachname"));
		
		neuerKunde.setStrasse(request.getParameter("strasse"));
		
		neuerKunde.setPlz(request.getParameter("plz"));
		
		neuerKunde.setOrt(request.getParameter("ort"));
		
		neuerKunde.setTelefon(request.getParameter("tel"));
		
		DateFormat dateFormatter = java.text.DateFormat.getDateInstance();
		Date kundeSeit;
		try {
			kundeSeit = dateFormatter.parse(request.getParameter("kunde_seit"));
			neuerKunde.setKundeSeit(kundeSeit);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Bestellung neueBestellung = new Bestellung();
		
		if(KundeStore.getInstance().getKundeByAdress(request.getParameter("vorname"), request.getParameter("nachname"), request.getParameter("strasse")) == null) {
			try {
				KundeStore.getInstance().save(neuerKunde);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			neueBestellung.setKundeId(newKundeId);
		}
		else {
			Kunde savedKunde = KundeStore.getInstance().getKundeByAdress(request.getParameter("vorname"), request.getParameter("nachname"), request.getParameter("strasse"));
			int kundeId = savedKunde.getKundeId();
			neueBestellung.setKundeId(kundeId);
		}
		/**
		 * definierung neuer Bestellung
		 */
		ArrayList<Bestellung> bestellung = BestellungStore.getInstance().getBestellung();
		int newBestellungId = bestellung.size() + 1;
		neueBestellung.setBestellungId(newBestellungId);
			
		Date datum;
		try {
			datum = dateFormatter.parse(request.getParameter("datum"));
			neueBestellung.setDatum(datum);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		neueBestellung.setBemerkungen(request.getParameter("bemerkungen"));
		
		try {
			BestellungStore.getInstance().save(neueBestellung);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		/**
		 * Definieren neuer BestellPosition
		 */
		BestellPosition neueBestellPosition = new BestellPosition();
		
		//ArrayList<BestellPosition> bestellPosition = BestellPositionStore.getInstance().getBestellPosition();
		//int neueBestellPositionId = bestellPosition.size() + 1;
		neueBestellPosition.setBestellPosId(newBestellungId);
		
		if(request.getParameter("artikelId") != null) {
		int artikelId = Integer.parseInt(request.getParameter("artikelId"));
		neueBestellPosition.setArtikelId(artikelId);
		}
		else {
			int artikelId = Integer.parseInt(request.getParameter("artikelIdSchachtel"));
			neueBestellPosition.setArtikelId(artikelId);
		}
		neueBestellPosition.setBestellId(newBestellungId);
		
		try {
			BestellPositionStore.getInstance().save(neueBestellPosition);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		/**
		 * Definieren neuer Bestellte Konfiguration
		 */
		
		BestellKonfiguration neueBestellungKonfiguration = new BestellKonfiguration();

		if(request.getSession().getAttribute("wkInhaltSchachtel")!=null && ((List<String>)request.getSession().getAttribute("wkInhaltSchachtel")).size()>0) {
			List<String> wkInhaltSchachtel = (List<String>)request.getSession().getAttribute("wkInhaltSchachtel");
			for(String inhaltId : wkInhaltSchachtel){
				int wkId = Integer.parseInt(inhaltId);
				Inhalt inhaltById = InhaltStore.getInstance().getInhaltById(wkId);
				
				neueBestellungKonfiguration.setBestellPosId(newBestellungId);
				
				BestellKonfiguration bestellteKonfigurationInhaltById = BestellKonfigurationStore.getInstance().getBestellKonfigurationById(wkId);
				if(bestellteKonfigurationInhaltById != null) {
					int inhaltWkId = inhaltById.getInhaltId();
					neueBestellungKonfiguration.setInhaltId(inhaltWkId);
					
					try {
						BestellKonfigurationStore.getInstance().save(neueBestellungKonfiguration);
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		else {
			List<String> wkInhalt = (List<String>)request.getSession().getAttribute("wkInhalt");
			for(String inhaltId : wkInhalt){
				int wkId = Integer.parseInt(inhaltId);
				Inhalt inhaltById = InhaltStore.getInstance().getInhaltById(wkId);
				
				neueBestellungKonfiguration.setBestellPosId(newBestellungId);
				
				int inhaltWkId = inhaltById.getInhaltId();
				neueBestellungKonfiguration.setInhaltId(inhaltWkId);
				
				
				try {
					BestellKonfigurationStore.getInstance().save(neueBestellungKonfiguration);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		response.sendRedirect("danke.jsp");
	}

}
