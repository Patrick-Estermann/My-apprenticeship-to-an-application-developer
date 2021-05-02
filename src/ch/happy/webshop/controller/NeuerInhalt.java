package ch.happy.webshop.controller;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ch.happy.webshop.database.InhaltStore;
import ch.happy.webshop.model.Inhalt;

/**
 * Servlet implementation class NeuerInhalt
 */
@WebServlet("/NeuerInhalt")
public class NeuerInhalt extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NeuerInhalt() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Inhalt neuerInhalt = new Inhalt();
		neuerInhalt.setBezeichnung(request.getParameter("bezeichnung"));
		
		Double inhaltPreis = Double.parseDouble(request.getParameter("preis"));
		neuerInhalt.setPreis(inhaltPreis);
		
		neuerInhalt.setIconPath(request.getParameter("image_path"));
		
		int inhaltId = Integer.parseInt(request.getParameter("id"));
		neuerInhalt.setInhaltId(inhaltId);
		
		try {
			InhaltStore.getInstance().save(neuerInhalt);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		response.sendRedirect("god.jsp");
	}

}
