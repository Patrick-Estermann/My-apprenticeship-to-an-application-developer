package ch.happy.webshop.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ch.happy.webshop.database.BestellungStore;

/**
 * Servlet implementation class BestellungEntfernen
 */
@WebServlet("/BestellungEntfernen")
public class BestellungEntfernen extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
     * @see HttpServlet#HttpServlet()
     */
    public BestellungEntfernen() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bestellungId = Integer.parseInt(request.getParameter("id"));
		BestellungStore.getInstance().deleteBestellung(bestellungId);
		
		response.sendRedirect("god.jsp");
	}
}
