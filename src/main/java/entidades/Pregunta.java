package entidades;

public class Pregunta {
	private int pregunta_id;
	private String descripcion;
	
	public Pregunta(){
		
	}
	public Pregunta(int preg, String desc){
		preg = pregunta_id;
		desc = descripcion;
	}
	public int getPregunta_id() {
		return pregunta_id;
	}
	public void setPregunta_id(int pregunta_id) {
		this.pregunta_id = pregunta_id;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	
}
