<%-- 
    Document   : view_test
    Created on : Jul 11, 2013, 5:24:00 PM
    Author     : ccarrubba
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>This Page is called from RenderRequest!</h1>
        
        <div> <form action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_INPUT"/></portlet:actionURL>" method="post">
                    <input type="submit" value="Back To Application">
                </form>
            </div>
        
    </body>
</html>
