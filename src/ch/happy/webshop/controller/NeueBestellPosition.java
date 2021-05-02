package ch.happy.webshop.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ch.happy.webshop.database.BestellPositionStore;
import ch.happy.webshop.model.BestellPosition;

/**
 * Servlet implementation class NeueBestellPosition
 */
@WebServlet("/NeueBestellPosition")
public class NeueBestellPosition extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NeueBestellPosition() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BestellPosition neueBestellPosition = new BestellPosition();
		
		int bestellPosId = Integer.parseInt(request.getParameter("bestellPosId"));
		neueBestellPosition.setBestellPosId(bestellPosId);
		
		int artikelId = Integer.parseInt(request.getParameter("artikelId"));
		neueBestellPosition.setArtikelId(artikelId);
		
		int bestellId = Integer.parseInt(request.getParameter("bestellId"));
		neueBestellPosition.setBestellId(bestellId);
		
		try {
			BestellPositionStore.getInstance().save(neueBestellPosition);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		response.sendRedirect("danke.jsp");
	}

}
