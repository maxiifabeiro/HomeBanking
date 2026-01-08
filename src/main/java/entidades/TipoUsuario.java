package entidades;

public class TipoUsuario {
	private int tipoUsuarioId;
    private String descripcion;

    public TipoUsuario() {
    }

    public TipoUsuario(int tipoUsuarioId, String descripcion) {
        this.tipoUsuarioId = tipoUsuarioId;
        this.descripcion = descripcion;
    }

    public int getTipoUsuarioId() {
        return tipoUsuarioId;
    }

    public void setTipoUsuarioId(int tipoUsuarioId) {
        this.tipoUsuarioId = tipoUsuarioId;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

}
