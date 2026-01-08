<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entidades.Provincias" %>
<%@ page import="entidades.Cliente" %>
<%
Cliente cliente = (Cliente) request.getAttribute("cliente");
List<Provincias> provincias = (List<Provincias>) request.getAttribute("provincias");

if (provincias != null) {
    for (Provincias p : provincias) {
        String selected = (cliente != null && cliente.getProvincia() != null 
                          && cliente.getProvincia().getProvincia_id() == p.getProvincia_id()) 
                          ? "selected" : "";
%>
    <option value="<%= p.getProvincia_id() %>" <%= selected %>><%= p.getNombre() %></option>
<%
    }
}
%>
