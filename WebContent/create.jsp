<%@ page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Create Contact</title>
</head>

<body>
  <%@ include file="header.jsp" %>

  <div class="container">
    <div class="row">
      <div class="col-6">
        <h2>Contact Form</h2>
        
        <c:set var="recordID" value='<%=request.getParameter("record")%>'/>
        
        <sql:query var="result" dataSource="jdbc/contactbook">
          SELECT * FROM contact where urlsafe=?
          <sql:param value="${recordID}" />
        </sql:query>
        
        <c:set var="row" value="${result.rows[0]}"/>
        
        <form action="/contactbook/Create" method="post">
          <div class="form-group">
            <input hidden type="text" name="recordID" id="recordID" 
              class="form-control" value="${row.urlsafe}"/>
          </div>
          <div class="form-group">
            <label for="name">Name</label>
            <input type="text" name="name" id="name" 
              class="form-control" value="${row.name}"/>
          </div>
          <div class="form-group">
            <label for="name">Email</label> 
            <input type="text" name="email" id="email" 
              class="form-control" value="${row.email}"/>
          </div>
          <div class="form-group">
            <label for="name">Phone</label>
            <input type="text" name="phone" id="phone" 
              class="form-control" value="${row.phone}"/>
          </div>
          <input type="submit" value="Save Contact" class="btn btn-primary"/>
        </form>
      </div>
      <div class="col-6">
      </div>
    </div>
  </div>
</body>
</html>