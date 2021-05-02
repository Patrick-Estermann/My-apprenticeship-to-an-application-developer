package ch.happy.webshop.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import ch.happy.webshop.model.Kunde;

public class KundeStore extends DatabaseAccess<Kunde> {
	
	private static KundeStore instance = null;
	
	// den Konstruktor protected zu machen verhindern, dass die Klasse mehrmals instanzier werden kann
	protected KundeStore() {}

	public static KundeStore getInstance() {
		if (instance == null) {
			instance = new KundeStore();
		}

		return instance;
	}
	
	public Kunde getKundeById(int kundeId) {
		Kunde kunde = null;

		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection();
					Statement statement = conn.createStatement();
					ResultSet rs = statement.executeQuery("SELECT * FROM kunde WHERE id=" + kundeId)) {

				if (rs.next()) {
					kunde = Map(rs);
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return kunde;
	}
	//********************************************
	public Kunde getKundeByAdress(String vorname, String nachname, String strasse) {
		Kunde kunde = null;

		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection();
					Statement statement = conn.createStatement();
					ResultSet rs = statement.executeQuery("SELECT * FROM kunde WHERE vorname='"+vorname+"' AND nachname='" + nachname+"' AND strasse='"+strasse+"'")) {

				if (rs.next()) {
					kunde = Map(rs);
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return kunde;
	}
	//********************************************

	public ArrayList<Kunde> getKunde() {
		ArrayList<Kunde> kunde = new ArrayList<Kunde>();

		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection();
					Statement statement = conn.createStatement();
					ResultSet rs = statement.executeQuery("SELECT * FROM kunde")) {
				// Extract data from result set
				while (rs.next()) {
					kunde.add(Map(rs));
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return kunde;
	}

	public void deleteKunde(int kundeId) {
		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection(); Statement statement = conn.createStatement()) {
				statement.execute("DELETE FROM kunde WHERE id =" + kundeId);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	

	@Override
	public void save(Kunde entity) throws SQLException {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String mysqlDateString = formatter.format(entity.getKundeSeit());
		
		String query = String.format(
				"INSERT INTO kunde (id, vorname, nachname, strasse, plz, ort, tel, kunde_seit) VALUE("+entity.getKundeId()+",'"+entity.getVorname() + "','"+entity.getNachname()+ "','"+entity.getStrasse()+"','"+entity.getPlz()+"','"+entity.getOrt()+"','"+entity.getTelefon()+"','"+mysqlDateString+"')");

		insertIntoDatabase(query);
		
	}

	@Override
	protected Kunde Map(ResultSet resultSet) throws SQLException {
		Kunde kunde = new Kunde();
		kunde.setKundeId(resultSet.getInt("id"));
		kunde.setVorname(resultSet.getString("vorname"));
		kunde.setNachname(resultSet.getString("nachname"));
		kunde.setStrasse(resultSet.getString("strasse"));
		kunde.setPlz(resultSet.getString("plz"));
		kunde.setOrt(resultSet.getString("ort"));
		kunde.setTelefon(resultSet.getString("tel"));
		kunde.setKundeSeit(resultSet.getDate("kunde_seit"));

		return kunde;
	}

}
