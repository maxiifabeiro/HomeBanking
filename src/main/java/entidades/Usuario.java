package entidades;

public class Usuario {
	private int usuarioId;
    private String nombreUsuario;
    private String clave;
    private String repetirClave;
    private String respuesta;
    private boolean estado;
    private Pregunta pregunta_id;
    private TipoUsuario tipoUsuario;

    public Usuario() {
    }

    public Usuario(int usuarioId, String nombreUsuario, String clave, String repetirClave,
                   TipoUsuario tipoUsuario, String respuesta, boolean estado, Pregunta pregunta_id) {
        this.usuarioId = usuarioId;
        this.nombreUsuario = nombreUsuario;
        this.clave = clave;
        this.repetirClave = repetirClave;
        this.tipoUsuario = tipoUsuario;
        this.respuesta = respuesta;
        this.estado = estado;
        this.pregunta_id = pregunta_id;
    }

    public int getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(int usuarioId) {
        this.usuarioId = usuarioId;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getRepetirClave() {
        return repetirClave;
    }

    public void setRepetirClave(String repetirClave) {
        this.repetirClave = repetirClave;
    }

    public TipoUsuario getTipoUsuario() {
        return tipoUsuario;
    }

    public void setTipoUsuario(TipoUsuario tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }

    public String getRespuesta() {
        return respuesta;
    }

    public void setRespuesta(String respuesta) {
        this.respuesta = respuesta;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

	public Pregunta getPregunta_id() {
		return pregunta_id;
	}

	public void setPregunta_id(Pregunta pregunta_id) {
		this.pregunta_id = pregunta_id;
	}
    
}
