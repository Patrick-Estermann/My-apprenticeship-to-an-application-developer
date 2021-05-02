package ch.happy.webshop.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import ch.happy.webshop.model.Artikel;

public class ArtikelStore extends DatabaseAccess<Artikel>{
	
	private static ArtikelStore instance = null;
	
	// den Konstruktor protected zu machen verhindern, dass die Klasse mehrmals instanzier werden kann
	protected ArtikelStore() {}

	public static ArtikelStore getInstance() {
		if (instance == null) {
			instance = new ArtikelStore();
		}

		return instance;
	}
	
	public Artikel getArtikelById(int artikelId) {
		Artikel artikel = null;

		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection();
					Statement statement = conn.createStatement();
					ResultSet rs = statement.executeQuery("SELECT * FROM artikel WHERE id=" + artikelId)) {

				if (rs.next()) {
					artikel = Map(rs);
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return artikel;
	}

	public ArrayList<Artikel> getArtikel() {
		ArrayList<Artikel> artikel = new ArrayList<Artikel>();

		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection();
					Statement statement = conn.createStatement();
					ResultSet rs = statement.executeQuery("SELECT * FROM artikel")) {
				// Extract data from result set
				while (rs.next()) {
					artikel.add(Map(rs));
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return artikel;
	}

	public void deleteArtikel(int artikelId) {
		try {
			// try-with damit conn, statement & rs automatisch geschlossen werden
			try (Connection conn = createConnection(); Statement statement = conn.createStatement()) {
				statement.execute("DELETE FROM artikel WHERE id =" + artikelId);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
	@Override
	public void save(Artikel entity) throws SQLException {
		String query = String.format(
				"INSERT INTO artikel (id, bezeichnung, preis, image_path) VALUE("+entity.getArtikelId()+",'"+entity.getBezeichnung() + "','"+entity.getPreis()+ "','"+entity.getIcon()+"')");

		insertIntoDatabase(query);
	}

	@Override
	protected Artikel Map(ResultSet resultSet) throws SQLException {
		Artikel artikel = new Artikel();
		artikel.setArtikelId(resultSet.getInt("id"));
		artikel.setBezeichnung(resultSet.getString("bezeichnung"));
		artikel.setPreis(resultSet.getDouble("preis"));
		artikel.setIcon(resultSet.getString("image_path"));

		return artikel;
	}

}
