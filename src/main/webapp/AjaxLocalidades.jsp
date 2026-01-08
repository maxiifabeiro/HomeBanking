<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entidades.Localidades" %>
<%@ page import="entidades.Cliente" %>
<%
Cliente cliente = (Cliente) request.getAttribute("cliente");
List<Localidades> localidades = (List<Localidades>) request.getAttribute("localidades");

if (localidades != null) {
    for (Localidades l : localidades) {
        String selected = (cliente != null && cliente.getLocalidad() != null 
                          && cliente.getLocalidad().getLocalidad_id() == l.getLocalidad_id()) 
                          ? "selected" : "";
%>
    <option value="<%= l.getLocalidad_id() %>" <%= selected %>><%= l.getNombre() %></option>
<%
    }
}
%>
