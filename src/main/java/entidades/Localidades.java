package entidades;

public class Localidades {
	
	private int localidad_id;
    private String nombre;
    private int provincia_id;

    public Localidades() {}
    public Localidades(int loc_id, String nomb, int prov_id) {
        loc_id = localidad_id;
        nomb = nombre;
        prov_id = provincia_id;
    }
    public int getLocalidad_id() {
        return localidad_id;
    }
    public void setLocalidad_id(int localidad_id) {
        this.localidad_id = localidad_id;
    }
    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public int getProvincia_id() {
        return provincia_id;
    }
    public void setProvincia_id(int provincia_id) {
        this.provincia_id = provincia_id;
    }

}
