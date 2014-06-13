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

<%//
  // Application peference Form
  //
  // This form defines values for the GirdEngine interaction
  // These parameters are:
  //	o 	bdiiHost - Hostname of the VO' top BDII
  //	o	pxServerHost - Hostname of the Proxy Robot server
  // 	o	pxRobotId - Proxy Robot Identifier
  //	o	RobotVO - Proxy Robot Virtual Organization
  // 	o	pxRobotRole - Proxy Robot Role
  //	o	pxUserProxy - A complete path to an user proxy
  //	o	pxRobotRenewalFlag - Proxy Robot renewal flag;
  //	 	(When specified it overrides the use of robot proxy) 
%>

<jsp:useBean id="pref_value" class="java.lang.String" scope="request"/>

<portlet:defineObjects />

<table>
    <tr>
        <td align="left" valign="top">
            <img align="left" style="padding:10px 10px;" src="<%=renderRequest.getContextPath()%>/images/AppLogo.png" width="80%"/>
        </td>


    <tr>
</table>
<%
// Below the edit submission web form 

%>
<table>

    <tr>

    <form id="<portlet:namespace/>Preferences" action="<portlet:actionURL portletMode="edit"></portlet:actionURL>" method="post">


        <td>

            <b>Preference Value</b></td>
        <td><input type="text" style="width: 320px; padding: 2px" name="pref_value" id="prefValueID" value="<%=pref_value%>"></td>
        <td><input type="submit" id="setPreferences" value="Set preferences"></td>
    </form>
</tr>
</table>    
<center>
    <table>   
        <tr>
            <td> <form action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_INPUT"/></portlet:actionURL>" method="post">
                    <input type="submit" value="Back To Application">
                </form>
            </td>
            <td>
                <input type="reset" value="Reset" onclick="resetForm()"/></td>
        </tr>
    </table>
</center>

<%
// Below the javascript functions used by the edit web form 
%>
<script type="text/javascript" >
    

    // This function is responsible to enable all textareas
    // when the user press the 'reset' form button
    function resetForm() {
        // Get components
       
        var prefValue=document.getElementById("prefValueID");
        prefValue.value="<%=pref_value%>";
	                
    }
	
</script>


