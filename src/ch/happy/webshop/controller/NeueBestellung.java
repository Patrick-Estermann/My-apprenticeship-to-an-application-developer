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

import ch.happy.webshop.database.BestellungStore;
import ch.happy.webshop.model.Bestellung;

/**
 * Servlet implementation class NeueBestellung
 */
@WebServlet("/NeueBestellung")
public class NeueBestellung extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NeueBestellung() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Bestellung neueBestellung = new Bestellung();
		neueBestellung.setBemerkungen(request.getParameter("bemerkungen"));
		
		DateFormat dateFormatter = java.text.DateFormat.getDateInstance();
		Date datum;
		try {
			datum = dateFormatter.parse(request.getParameter("datum"));
			neueBestellung.setDatum(datum);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int kundeId = Integer.parseInt(request.getParameter("kundeId"));
		neueBestellung.setKundeId(kundeId);
		
		int bestellungId = Integer.parseInt(request.getParameter("bestellungid"));
		neueBestellung.setBestellungId(bestellungId);
		
		try {
			BestellungStore.getInstance().save(neueBestellung);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		response.sendRedirect("god.jsp");
	}

}
