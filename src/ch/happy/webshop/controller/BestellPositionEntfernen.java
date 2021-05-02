package ch.happy.webshop.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ch.happy.webshop.database.BestellungStore;

/**
 * Servlet implementation class BestellPositionEntfernen
 */
@WebServlet("/BestellPositionEntfernen")
public class BestellPositionEntfernen extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BestellPositionEntfernen() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bestellungPosId = Integer.parseInt(request.getParameter("bestellPosId"));
		BestellungStore.getInstance().deleteBestellung(bestellungPosId);
		
		response.sendRedirect("danke.jsp");
	}

}
