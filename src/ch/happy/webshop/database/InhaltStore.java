package ch.happy.webshop.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import ch.happy.webshop.model.Inhalt;

public class InhaltStore extends DatabaseAccess<Inhalt> {
	
	private static InhaltStore instance = null;
	
	// den Konstruktor protected zu machen verhindern, dass die Klasse mehrmals instanzier werden kann
	protected InhaltStore() {}

	public static InhaltStore getInstance() {
		if (instance == null) {
			instance = new InhaltStore();
		}

		return instance;
	}
	
	public Inhalt getInhaltById(int inhaltId) {
		Inhalt inhalt = null;

		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection();
					Statement statement = conn.createStatement();
					ResultSet rs = statement.executeQuery("SELECT * FROM inhalt WHERE id=" + inhaltId)) {

				if (rs.next()) {
					inhalt = Map(rs);
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return inhalt;
	}
	//********************************************************************************************************
	public ArrayList<Inhalt> getInhaltExceptSchere() {
		ArrayList<Inhalt> inhalt = new ArrayList<Inhalt>();

		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection();
					Statement statement = conn.createStatement();
					ResultSet rs = statement.executeQuery("SELECT * FROM inhalt EXCEPT SELECT * FROM inhalt WHERE id=2")) {
				// Extract data from result set
				while (rs.next()) {
					inhalt.add(Map(rs));
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return inhalt;
	}
	//***********************************************************************************************************
	public ArrayList<Inhalt> getInhalt() {
		ArrayList<Inhalt> inhalt = new ArrayList<Inhalt>();

		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection();
					Statement statement = conn.createStatement();
					ResultSet rs = statement.executeQuery("SELECT * FROM inhalt")) {
				// Extract data from result set
				while (rs.next()) {
					inhalt.add(Map(rs));
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return inhalt;
	}

	public void deleteInhalt(int inhaltId) {
		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection(); Statement statement = conn.createStatement()) {
				statement.execute("DELETE FROM inhalt WHERE id =" + inhaltId);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	@Override
	public void save(Inhalt entity) throws SQLException {
		String query = String.format(
				"INSERT INTO inhalt (id, bezeichnung, preis, image_path) VALUE("+entity.getInhaltId()+",'"+entity.getBezeichnung() + "','"+entity.getPreis()+ "','"+entity.getIconPath()+"')");

		insertIntoDatabase(query);
		
	}

	@Override
	protected Inhalt Map(ResultSet resultSet) throws SQLException {
		Inhalt inhalt = new Inhalt();
		inhalt.setInhaltId(resultSet.getInt("id"));
		inhalt.setBezeichnung(resultSet.getString("bezeichnung"));
		inhalt.setPreis(resultSet.getDouble("preis"));
		inhalt.setIconPath(resultSet.getString("image_path"));

		return inhalt;
	}

}
