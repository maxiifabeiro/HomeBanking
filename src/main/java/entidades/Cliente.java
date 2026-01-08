package entidades;

import java.util.Date;

public class Cliente {
    
    private int clienteId;
    private String dni;
    private String cuil;
    private String nombre;
    private String apellido;
    private char sexo;
    private Date fechaNacimiento;
    private String direccion;
    private String correoElectronico;
    private String telefono;
    private boolean estado;

    private Pais pais;
    private Localidades localidad;
    private Provincias provincia;
    private Usuario usuario;
    private Pregunta pregunta_id;

    public Cliente() {}

    public Cliente(int clienteId, String dni, String cuil, String nombre, String apellido,
                   char sexo, Date fechaNacimiento, String direccion,
                   String correoElectronico, String telefono, boolean estado,
                   Pais pais, Localidades localidad, Provincias provincia,
                   Usuario usuario, Pregunta pregunta_id) {

        this.clienteId = clienteId;
        this.dni = dni;
        this.cuil = cuil;
        this.nombre = nombre;
        this.apellido = apellido;
        this.sexo = sexo;
        this.fechaNacimiento = fechaNacimiento;
        this.direccion = direccion;
        this.correoElectronico = correoElectronico;
        this.telefono = telefono;
        this.estado = estado;
        this.pais = pais;
        this.localidad = localidad;
        this.provincia = provincia;
        this.usuario = usuario;
        this.pregunta_id = pregunta_id;
    }

    // Getters y setters

    public int getClienteId() { return clienteId; }
    public void setClienteId(int clienteId) { this.clienteId = clienteId; }

    public String getDni() { return dni; }
    public void setDni(String dni) { this.dni = dni; }

    public String getCuil() { return cuil; }
    public void setCuil(String cuil) { this.cuil = cuil; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getApellido() { return apellido; }
    public void setApellido(String apellido) { this.apellido = apellido; }

    public char getSexo() { return sexo; }
    public void setSexo(char sexo) { this.sexo = sexo; }

    public Date getFechaNacimiento() { return fechaNacimiento; }
    public void setFechaNacimiento(Date fechaNacimiento) { this.fechaNacimiento = fechaNacimiento; }

    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }

    public String getCorreoElectronico() { return correoElectronico; }
    public void setCorreoElectronico(String correoElectronico) { this.correoElectronico = correoElectronico; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public boolean isEstado() { return estado; }
    public void setEstado(boolean estado) { this.estado = estado; }

    public Pais getPais() { return pais; }
    public void setPais(Pais pais) { this.pais = pais; }

    public Localidades getLocalidad() { return localidad; }
    public void setLocalidad(Localidades localidad) { this.localidad = localidad; }

    public Provincias getProvincia() { return provincia; }
    public void setProvincia(Provincias provincia) { this.provincia = provincia; }

    public Usuario getUsuario() { return usuario; }
    public void setUsuario(Usuario usuario) { this.usuario = usuario; }

    public Pregunta getPregunta_id() { return pregunta_id; }
    public void setPregunta_id(Pregunta pregunta_id) { this.pregunta_id = pregunta_id; }
}