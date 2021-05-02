package ch.happy.webshop.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class WarenkorbEdit
 */
@WebServlet("/WarenkorbEdit")
public class WarenkorbEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WarenkorbEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Get items in Cart for the Session
	        HttpSession session = request.getSession();
	        if(session.getAttribute("wkInhaltSchachtel") != null) {
	        	List<String> wkInhaltSchachtel = (List<String>)session.getAttribute("wkInhaltSchachtel");
	        
	
		        // Remove Warenkorb Element
		        String removeSchachtel = request.getParameter("removeSchachtel");
		        if(removeSchachtel!=null) {
		        	wkInhaltSchachtel.remove(Integer.parseInt(removeSchachtel));
		        }
		        
		        String inhaltSchachtel = request.getParameter("inhaltSchachtel");
		        if(inhaltSchachtel != null) {
		            //Add item to list
		        	wkInhaltSchachtel.add(inhaltSchachtel);
		        }
	        }
	        else{
	        	List<String> wkInhaltSchachtel;
	        	wkInhaltSchachtel = new ArrayList<String>();
	            session.setAttribute("wkInhaltSchachtel", wkInhaltSchachtel);
	        }
	        
	        
	        
	        if(session.getAttribute("wkInhalt") != null) {
	        	List<String> wkInhalt = (List<String>)session.getAttribute("wkInhalt");
	
		        // Remove Warenkorb Element
		        String remove = request.getParameter("remove");
		        if(remove!=null) {
		        	wkInhalt.remove(Integer.parseInt(remove));
		        }
		        String inhaltId = request.getParameter("inhaltId");
		        if(inhaltId != null) {
		            //Add item to list
		            wkInhalt.add(inhaltId);
		        }
	        }
	        else {
	        	List<String> wkInhalt;
	        	wkInhalt = new ArrayList<String>();
	            session.setAttribute("wkInhalt", wkInhalt);
	        }
        
	    RequestDispatcher requestDispatcher = request.getRequestDispatcher("inhalt.jsp");
	    requestDispatcher.forward(request, response);
	}

}
