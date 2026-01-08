package daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
	private static final String URL = "jdbc:mysql://localhost:3306/homebanking?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "root";

    // Cargar el driver una sola vez
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("Driver cargado correctamente.");
        } catch (ClassNotFoundException e) {
            System.out.println("Error al cargar el driver:");
            e.printStackTrace();
        }
    }

    // Devuelve una nueva conexión en cada llamada
    public static Connection getSQLConexion() throws SQLException {
        Connection conn = DriverManager.getConnection(URL, USER, PASS);
        conn.setAutoCommit(false);
        System.out.println("Conexión establecida correctamente.");
        return conn;
    }

	
}
