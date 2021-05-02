package ch.happy.webshop.database;

import java.sql.*;

public abstract class DatabaseAccess<T> {
	// JDBC driver name and database URL
	final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	final String DB_URL = "jdbc:mysql://localhost/happy";

	// Database credentials
	final String USER = "happy";
	final String PASS = "happy";

	protected Connection createConnection() throws ClassNotFoundException, SQLException {
		// Register JDBC driver
		Class.forName(JDBC_DRIVER);

		// Open a connection
		return DriverManager.getConnection(DB_URL, USER, PASS);
	}

	protected void insertIntoDatabase(String query) {
		try {
			// try-with damit con & statement automatisch geschlossen werden
			try (Connection conn = createConnection(); Statement statement = conn.createStatement()) {
				statement.execute(query);
			}
		} catch (Exception e) {
			System.out.print(e);
		}
	}

	/**
	 * Allgemeine Save Methode
	 * 
	 * @param entity Objekt das abgespeichert werden soll
	 * @throws SQLException
	 */
	public abstract void save(T entity) throws SQLException;

	/**
	 * Allgemeine Mapping Methode
	 * 
	 * @param resultSet ResultSet dass gemappt werden soll
	 * @return Gibt ein Mapping des Typs T zurück
	 * @throws SQLException
	 */
	protected abstract T Map(ResultSet resultSet) throws SQLException;
}