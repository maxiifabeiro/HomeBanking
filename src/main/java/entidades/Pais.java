package entidades;

public class Pais {
	
	private int pais_id;
    private String nombre;

    public Pais() {

    }

    public Pais(int id, String nomb) {
        id = pais_id;
        nomb = nombre;
    }

    public int getPais_id() {
        return pais_id;
    }

    public void setPais_id(int pais_id) {
        this.pais_id = pais_id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

}
