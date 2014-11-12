<%@page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%!String val(javax.servlet.http.HttpServletRequest request, String param) {
  String value = request.getParameter(param);
  return value == null ? "" : value;
}%>
<%
request.setCharacterEncoding("utf-8");
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>DB View</title>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<style>
body {
  padding-top: 15px;
}
</style>
<!--[if lt IE 9]>
  <script src="//oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="//oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<body>
  <div class="container-fluid">
    <div class="row">
      <form name="frm" method="post" accept-charset="utf-8">
        <input type="hidden" name="op" value="run">
        <div class="col-sm-12">
          <div class="panel panel-info">
            <div class="panel-heading">DBView - JDBC</div>
            <div class="panel-body">
              <div class="row">
                <div class="col-sm-4">
                  <div class="form-group">
                    <%String url = val(request, "url");%>
                    <input type="text" name="url" class="form-control input-sm" placeholder="URL JDBC" title="Exemplo: jdbc:derby:db;create=true" value="<%=url%>">
                  </div>
                </div>
                <div class="col-sm-4">
                  <div class="form-group">
                    <%String user = val(request, "user");%>
                    <input type="text" name="user" class="form-control input-sm" placeholder="Usuário" value="<%=user%>">
                  </div>
                </div>
                <div class="col-sm-4">
                  <div class="form-group">
                    <%String password = val(request, "password");%>
                    <input type="password" name="password" class="form-control input-sm" placeholder="Senha" value="<%=password%>">
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-sm-12">
                  <div class="form-group">
                    <%String sql = val(request, "sql");%>
                    <textarea name="sql" class="form-control" rows="4" placeholder="SQL"><%=sql%></textarea>
                  </div>
                  <button type="submit" class="btn btn-primary pull-right">Executar</button>
                </div>
              </div>
            </div>
          </div>
<%
String op = val(request, "op");
if (op.equals("run")) {
  try {
    Connection conn = DriverManager.getConnection(url, user, password);
    Statement stmt = conn.createStatement();
    boolean isResultSet = stmt.execute(sql);
    if (isResultSet) {
      ResultSet rs = stmt.getResultSet();
      if (rs.next()) {
%>
        <div class="panel panel-success" id="resultPanel">
          <div class="panel-heading">Sucesso</div>
          <table class="table table-condensed">
          <thead>
            <tr>
          <th>#</th>
          <th>First Name</th>
          <th>Last Name</th>
          <th>Username</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td>Mark</td>
          <td>Otto</td>
          <td>@mdo</td>
        </tr>
        <tr>
          <td>2</td>
          <td>Jacob</td>
          <td>Thornton</td>
          <td>@fat</td>
        </tr>
        <tr>
          <td>3</td>
          <td colspan="2">Larry the Bird</td>
          <td>@twitter</td>
        </tr>
      </tbody>
    </table><%
        ResultSetMetaData rsmd = rs.getMetaData();
        int columnCount = rsmd.getColumnCount();
        for (int i = 1; i <= columnCount; i++) {
          rsmd.getColumnName(i);
%>
<%
        }
%>
        </div>
<%
      } else {
%>
          <div class="panel panel-success" id="resultPanel">
            <div class="panel-heading">Sucesso</div>
            <div class="panel-body">
              <p>Nenhum registro encontrado.</p>
            </div>
          </div>
<%
      }
    } else {
      int updateCount = stmt.getUpdateCount();
%>
          <div class="panel panel-success" id="resultPanel">
            <div class="panel-heading">Sucesso</div>
            <div class="panel-body">
              <p>O SQL foi executado com sucesso: <mark><%=updateCount%> registro(s) alterado(s).</mark></p>
            </div>
          </div>
<%
    }
  } catch (Throwable e) {
%>
          <div class="panel panel-danger" id="resultPanel">
            <div class="panel-heading">Erro</div>
            <div class="panel-body">
              <p>A execução do SQL falhou: <mark><%=e.getClass().getName() + " - " + e.getMessage()%></mark></p>
            </div>
          </div>
<%
  }
%>
<%
} else {
%>
          <script>
            function scroll() {
            }
          </script>
<%
}
%>
        </div>
      </form>
    </div>
  </div>
  <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
  <script>
    function scroll() {
      var resultPanel = $("#resultPanel");
      if (resultPanel.length) {
        $("html, body").animate({
          scrollTop: resultPanel.offset().top
        }, 600);
      }
    }
    $(document).ready(function () {
      setTimeout(scroll, 300);
    });
  </script>
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
  <script>
      /*!
       * IE10 viewport hack for Surface/desktop Windows 8 bug
       * Copyright 2014 Twitter, Inc.
       * Licensed under the Creative Commons Attribution 3.0 Unported License. For
       * details, see http://creativecommons.org/licenses/by/3.0/.
       */

      // See the Getting Started docs for more information:
      // http://getbootstrap.com/getting-started/#support-ie10-width
      (function() {
        'use strict';
        if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
          var msViewportStyle = document.createElement('style')
          msViewportStyle.appendChild(document.createTextNode('@-ms-viewport{width:auto!important}'))
          document.querySelector('head').appendChild(msViewportStyle)
        }
      })();
  </script>
</body>
</html>