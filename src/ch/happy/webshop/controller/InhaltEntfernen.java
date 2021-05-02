package ch.happy.webshop.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ch.happy.webshop.database.InhaltStore;

/**
 * Servlet implementation class InhaltEntfernen
 */
@WebServlet("/InhaltEntfernen")
public class InhaltEntfernen extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
     * @see HttpServlet#HttpServlet()
     */
    public InhaltEntfernen() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int inhaltId = Integer.parseInt(request.getParameter("id"));
		InhaltStore.getInstance().deleteInhalt(inhaltId);
		
		response.sendRedirect("god.jsp");
	}

}
