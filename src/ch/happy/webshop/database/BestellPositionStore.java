package ch.happy.webshop.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import ch.happy.webshop.model.BestellPosition;

public class BestellPositionStore extends DatabaseAccess<BestellPosition>{
	
	private static BestellPositionStore instance = null;
	
	protected BestellPositionStore() {}

	public static BestellPositionStore getInstance() {
		if (instance == null) {
			instance = new BestellPositionStore();
		}

		return instance;
	}
	
	public BestellPosition getBestellPositionById(int bestellPosId) {
		BestellPosition bestellPosition = null;

		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection();
					Statement statement = conn.createStatement();
					ResultSet rs = statement.executeQuery("SELECT * FROM bestellte_konfiguration WHERE bestellPos_id=" + bestellPosId)) {

				if (rs.next()) {
					bestellPosition = Map(rs);
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return bestellPosition;
	}

	public ArrayList<BestellPosition> getBestellPosition() {
		ArrayList<BestellPosition> bestellPosition = new ArrayList<BestellPosition>();

		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection();
					Statement statement = conn.createStatement();
					ResultSet rs = statement.executeQuery("SELECT * FROM bestell_position")) {
				// Extract data from result set
				while (rs.next()) {
					bestellPosition.add(Map(rs));
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return bestellPosition;
	}

	public void deleteBestellPosition(int bestellPosId) {
		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection(); Statement statement = conn.createStatement()) {
				statement.execute("DELETE FROM bestell_position WHERE id =" + bestellPosId);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	@Override
	public void save(BestellPosition entity) throws SQLException {
		String query = String.format(
				"INSERT INTO bestell_position (id, artikel_id, bestell_id) VALUE("+entity.getBestellPosId()+","+entity.getArtikelId() + ","+entity.getBestellId()+")");

		insertIntoDatabase(query);
	}

	@Override
	protected BestellPosition Map(ResultSet resultSet) throws SQLException {
		BestellPosition bestellPosition = new BestellPosition();
		bestellPosition.setBestellPosId(resultSet.getInt("bestellPosId"));
		bestellPosition.setArtikelId(resultSet.getInt("artikelId"));
		bestellPosition.setBestellId(resultSet.getInt("bestellId"));
		return bestellPosition;
	}

}
