package ch.happy.webshop.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import ch.happy.webshop.model.BestellKonfiguration;

public class BestellKonfigurationStore extends DatabaseAccess<BestellKonfiguration> {
	
	private static BestellKonfigurationStore instance = null;
	
	// den Konstruktor protected zu machen verhindern, dass die Klasse mehrmals instanzier werden kann
	protected BestellKonfigurationStore() {}

	public static BestellKonfigurationStore getInstance() {
		if (instance == null) {
			instance = new BestellKonfigurationStore();
		}

		return instance;
	}
	
	public BestellKonfiguration getBestellKonfigurationById(int bestellPosId) {
		BestellKonfiguration bestellKonfiguration = null;

		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection();
					Statement statement = conn.createStatement();
					ResultSet rs = statement.executeQuery("SELECT * FROM bestellte_konfiguration WHERE bestellPos_id=" + bestellPosId)) {

				if (rs.next()) {
					bestellKonfiguration = Map(rs);
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return bestellKonfiguration;
	}

	public ArrayList<BestellKonfiguration> getBestellKonfiguration() {
		ArrayList<BestellKonfiguration> bestellKonfiguration = new ArrayList<BestellKonfiguration>();

		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection();
					Statement statement = conn.createStatement();
					ResultSet rs = statement.executeQuery("SELECT * FROM bestellte_konfiguration")) {
				// Extract data from result set
				while (rs.next()) {
					bestellKonfiguration.add(Map(rs));
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return bestellKonfiguration;
	}

	public void deleteBestellKonfiguration(int bestellPosId) {
		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection(); Statement statement = conn.createStatement()) {
				statement.execute("DELETE FROM bestellte_konfiguration WHERE bestellPos_id =" + bestellPosId);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	@Override
	public void save(BestellKonfiguration entity) throws SQLException {
		String query = String.format(
				"INSERT INTO bestellte_konfiguration (bestellPos_id, inhalt_id) VALUE("+entity.getBestellPosId()+","+entity.getInhaltId()+")");

		insertIntoDatabase(query);
	}

	@Override
	protected BestellKonfiguration Map(ResultSet resultSet) throws SQLException {
		BestellKonfiguration bestellKonfiguration = new BestellKonfiguration();
		bestellKonfiguration.setBestellPosId(resultSet.getInt("bestellPosId"));
		bestellKonfiguration.setInhaltId(resultSet.getInt("inhaltId"));
		return bestellKonfiguration;
	}
}
