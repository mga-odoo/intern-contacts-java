<%@ page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>Contact Book</title>
</head>

<body>
  <%@ include file="header.jsp" %>
  <div class="container">
    <div class="row">
      <div class="col-4">
        
        <c:set var="searchName" value='<%=request.getParameter("q")%>'/>

        <sql:query var="result" dataSource="jdbc/contactbook">
          SELECT * FROM contact WHERE name ilike ?
          <sql:param value="%${searchName}%" />
        </sql:query>
		
        <form action="/contactbook/index.jsp" method="get">
          <div class="input-group mb-4">
            <input type="text" name="q" id="q" class="form-control" placeholder="Search contact" />
            <div class="input-group-append">
              <input type="submit" value="Search" class="btn btn-primary"/>
            </div>
          </div>
        </form>
      </div>
    </div>
    
    <div class="row">
      <div class="col">
        <table class="table table-striped">
          <tr>
            <th width="10">Operation</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
          </tr>
          <c:forEach var="row" items="${result.rows}">
            <tr>
              <td>
                <a href="/contactbook/Delete?record=${row.urlsafe}">
                  <i class="fas fa-trash-alt"></i>
                </a>&nbsp;&nbsp;
                <a href="/contactbook/create.jsp?record=${row.urlsafe}">
                  <i class="fas fa-edit"></i>
                </a> 
              </td>
              <td><c:out value="${row.name}" /></td>
              <td><c:out value="${row.phone}" /></td>
              <td><c:out value="${row.email}" /></td>
            </tr>
          </c:forEach>
        </table>
      </div>
    </div>
  </div>
</body>
</html>