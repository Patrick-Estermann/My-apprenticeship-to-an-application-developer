package ch.happy.webshop.controller;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ch.happy.webshop.database.ArtikelStore;
import ch.happy.webshop.model.Artikel;

/**
 * Servlet implementation class NeueArtikelController
 */
@WebServlet("/NeueArtikelController")
public class NeueArtikel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NeueArtikel() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Artikel neuerArtikel = new Artikel();
		neuerArtikel.setBezeichnung(request.getParameter("bezeichnung"));
		
		Double artikelPreis = Double.parseDouble(request.getParameter("preis"));
		neuerArtikel.setPreis(artikelPreis);
		
		neuerArtikel.setIcon(request.getParameter("image_path"));
		
		int artikelId = Integer.parseInt(request.getParameter("id"));
		neuerArtikel.setArtikelId(artikelId);
		
		try {
			ArtikelStore.getInstance().save(neuerArtikel);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		response.sendRedirect("god.jsp");
	}

}
