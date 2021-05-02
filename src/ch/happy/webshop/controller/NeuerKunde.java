package ch.happy.webshop.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ch.happy.webshop.database.KundeStore;
import ch.happy.webshop.model.Kunde;

/**
 * Servlet implementation class NeuerKunde
 */
@WebServlet("/NeuerKunde")
public class NeuerKunde extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NeuerKunde() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Kunde neuerKunde = new Kunde();
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
		
		
		int kundeId = Integer.parseInt(request.getParameter("id"));
		neuerKunde.setKundeId(kundeId);
		
		try {
			KundeStore.getInstance().save(neuerKunde);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		response.sendRedirect("god.jsp");
	}

}
