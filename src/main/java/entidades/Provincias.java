package entidades;

public class Provincias {

	private int provincia_id;
    private String nombre;
    private int pais_id;

    public Provincias() {

    }

    public Provincias(int prov_id, String nomb, int pa_id) {
        prov_id = provincia_id;
        nomb = nombre;
        pa_id = pais_id;
    }

    public int getProvincia_id() {
        return provincia_id;
    }

    public void setProvincia_id(int provincia_id) {
        this.provincia_id = provincia_id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getPais_id() {
        return pais_id;
    }

    public void setPais_id(int pais_id) {
        this.pais_id = pais_id;
    }
}
