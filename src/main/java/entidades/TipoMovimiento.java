package entidades;

public class TipoMovimiento {
	private int tipoMovimiento_id;
    private String descripcion;
    
    public TipoMovimiento() {
    	
    }

	public TipoMovimiento(int tipoMovimiento_id, String descripcion) {
		super();
		this.tipoMovimiento_id = tipoMovimiento_id;
		this.descripcion = descripcion;
	}

	public int getTipoMovimiento_id() {
		return tipoMovimiento_id;
	}

	public void setTipoMovimiento_id(int tipoMovimiento_id) {
		this.tipoMovimiento_id = tipoMovimiento_id;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
    
}
