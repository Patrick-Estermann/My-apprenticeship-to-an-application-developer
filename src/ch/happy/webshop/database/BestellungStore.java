package ch.happy.webshop.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import ch.happy.webshop.model.Bestellung;

public class BestellungStore extends DatabaseAccess<Bestellung> {
	
private static BestellungStore instance = null;
	
	// den Konstruktor protected zu machen verhindern, dass die Klasse mehrmals instanzier werden kann
	protected BestellungStore() {}

	public static BestellungStore getInstance() {
		if (instance == null) {
			instance = new BestellungStore();
		}

		return instance;
	}
	
	public Bestellung getBestellungById(int bestellungId) {
		Bestellung bestellung = null;

		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection();
					Statement statement = conn.createStatement();
					ResultSet rs = statement.executeQuery("SELECT * FROM bestellung WHERE id=" + bestellungId)) {

				if (rs.next()) {
					bestellung = Map(rs);
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return bestellung;
	}

	public ArrayList<Bestellung> getBestellung() {
		ArrayList<Bestellung> bestellung = new ArrayList<Bestellung>();

		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection();
					Statement statement = conn.createStatement();
					ResultSet rs = statement.executeQuery("SELECT * FROM bestellung")) {
				// Extract data from result set
				while (rs.next()) {
					bestellung.add(Map(rs));
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return bestellung;
	}

	public void deleteBestellung(int bestellungId) {
		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection(); Statement statement = conn.createStatement()) {
				statement.execute("DELETE FROM bestellung WHERE id =" + bestellungId);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	@Override
	public void save(Bestellung entity) throws SQLException {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String mysqlDateString = formatter.format(entity.getDatum());

		String query = String.format(
				"INSERT INTO bestellung (id, kunde_id, datum, bemerkungen) VALUE("+entity.getBestellungId()+","+entity.getKundeId() + ",'"+mysqlDateString+ "','"+entity.getBemerkungen()+"')");

		insertIntoDatabase(query);
	}

	@Override
	protected Bestellung Map(ResultSet resultSet) throws SQLException {
		Bestellung bestellung = new Bestellung();
		bestellung.setBestellungId(resultSet.getInt("id"));
		bestellung.setBemerkungen(resultSet.getString("bemerkungen"));
		bestellung.setDatum(resultSet.getDate("datum"));
		bestellung.setKundeId(resultSet.getInt("kunde_id"));

		return bestellung;
	}

}
