<%
/**
 * Copyright (c) 2000-2011 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
%>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<portlet:defineObjects />
<%//
  // Application Submission page
  //
  //
  // The portlet code assigns the jobIdentifier as input parameter for this jsp file
  //
%>
<jsp:useBean id="inputValue" class="java.lang.String" scope="request"/>

<%
// Below the submission web form
//
// It only have a button that will show the input form again for a new job submission
%>
<table>
<tr>
  <td valign="top"><img align="left" style="padding:10px 10px;" src="<%=renderRequest.getContextPath()%>/images/AppLogo.png" width="80%"/></td>
  <td>
  My value is <b><%= inputValue%></b> 
  
  
  </td>
</tr>
<tr>
<td align="center"><form action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_INPUT"/></portlet:actionURL>" method="post">
<input type="submit" value="Go to the first jsp page"></form></td>

</tr>
</table>

