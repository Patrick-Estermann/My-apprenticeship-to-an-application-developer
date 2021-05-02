package ch.happy.webshop.controller;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ch.happy.webshop.database.BestellKonfigurationStore;
import ch.happy.webshop.model.BestellKonfiguration;

/**
 * Servlet implementation class NeueBestellungKonfiguration
 */
@WebServlet("/NeueBestellungKonfiguration")
public class NeueBestellungKonfiguration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NeueBestellungKonfiguration() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BestellKonfiguration neueBestellungKonfiguration = new BestellKonfiguration();
		
		int bestellPosId = Integer.parseInt(request.getParameter("bestellPosId"));
		neueBestellungKonfiguration.setBestellPosId(bestellPosId);
		
		int bestellungId = Integer.parseInt(request.getParameter("inhaltId"));
		neueBestellungKonfiguration.setInhaltId(bestellungId);
		
		try {
			BestellKonfigurationStore.getInstance().save(neueBestellungKonfiguration);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		response.sendRedirect("danke.jsp");
	}

}
