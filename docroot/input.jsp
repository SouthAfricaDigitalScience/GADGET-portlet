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
  // GATE 6.0.0 Submission Form
  //
  // The form has 3 input textareas respectively for:
  //    * Macro file
  //    * Material DB
  //    * ROOT Analysis C file
  // Beside each text area a upolad button takes as input the 
  // file name related to one of the above fields.
  // The forth submission buttons is related to the file 'phsp.root' file
  // A default phsp.root file will be used if no files will be uploaded by the user.
  // The ohter three buttons of the form are used for:
  //    o Demo:          Used to fill with demo values the text areas
  //    o SUBMIT:        Used to execute the job on the eInfrastructure
  //    o Reset values:  Used to reset input fields
  //
  
  // Gets the current timestamp
  java.util.Date date = new java.util.Date();
%>

<%
// Below the descriptive area of the GATE web form 
%>
<table>
    <tr>
        <td valign="top">
            <img align="left" style="padding:10px 10px;" src="<%=renderRequest.getContextPath()%>/images/AppLogo.jpg" width="80%"/>
        </td>
        <td>
           <!--This is an example portlet!
            <p><b>Exchange data between jsp page and java codeeee</b></p>-->
           
           <p style="font-size: small"> 
               GADGET is a freely available code for cosmological N-body/SPH simulations <br> 
               on massively parallel computers with distributed memory.<br> 
               GADGET uses an explicit communication model that is implemented<br>
               with the standardized MPI communication interface. <br>
               The code can be run on essentially all supercomputer systems presently in use,<br>
               including clusters of workstations or individual PCs.  
           </p>
        </td>
    <tr>
</table>
            
<form enctype="multipart/form-data" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_SUBMIT_FILE"/></portlet:actionURL>" method="post">
<div style="text-align: center;">
    <dl>	
	<!-- This block contains: label, file input and textarea for GATE Macro file -->
	<dd>		
 		<p><b>Application' input file</b> <input type="file" name="file_inputFile" id="upload_inputFileId" accept="*.*" onchange="uploadInputFile()"/></p>
                <div hidden="yes">
                    <textarea id="inputFileId" rows="20" cols="100%" name="inputFile">Insert here your text file, or upload a file</textarea>
                </div>
        </dd>
        <div hidden="yes">
            <!-- This block contains the experiment name -->
            <dd>
        	<p>Insert below your <b>job identifyer</b></p>
            	<textarea id="jobIdentifierId" rows="1" cols="60%" name="JobIdentifier">multi-infrastructure job description</textarea>
            </dd>	
            <!-- This block contains form buttons: Demo, SUBMIT and Reset values -->
            <dd>
  		<td><input type="button" value="Demo" onClick="addDemo()"></td>
  		<td><input type="button" value="Submit" onClick="preSubmit()"></td> 
  		<td><input type="reset" value="Reset values" onClick="resetForm()"></td>
            </dd>
        </div>
    </dl>
    <br/><br/>
</div>    
</form>            

          
            
<%
// Below the application submission web form 
//
// The <form> tag contains a portlet parameter value called 'PortletStatus' the value of this item
// will be read by the processAction portlet method which then assigns a proper view mode before
// the call to the doView method.
// PortletStatus values can range accordingly to values defined into Enum type: Actions
// The processAction method will assign a view mode accordingly to the values defined into
// the Enum type: Views. This value will be assigned calling the function: setRenderParameter
//
%>

<!-- <div>
     <form  action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_SUBMIT"/></portlet:actionURL>" method="post">

             <b>Input value</b> 
             <input type="text" id="inputValueId" name="inputValue" />

             <input type="submit" value="GO">

     </form>
 </div>
 <br>
 <div>
     <form  action="<portlet:renderURL portletMode="view"><portlet:param name="PortletStatus" value="VIEW_NO_ACTION"/></portlet:renderURL>" method="post">

             <b>Go a new JSP page without Action</b> 
             <input type="submit" value="GO">

     </form>
 </div>
 
-->

<script src="<%=renderRequest.getContextPath()%>/js/jquery-1.3.2.min.js" type="text/javascript"></script>
<form  action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_SUBMIT"/></portlet:actionURL>" method="post">



<div id="container">
    <table>
        <tr>

            <td>
                <!-- <div id="gadget2_setup1">Click to add the setup value</div>-->
                <div id="gadget2_s">
                    <center>
                        <fieldset class="gadget2_fieldset">

                            <legend class="gadget2_legend"> SETUP Value </legend>
                            <table >
                                <tr>
                                    <td id="td_left">   
                                        <label id="gadget2_label">Boxlength </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="boxlengthID" name="boxlength" type="text"  />
                                    </td>
                                </tr>


                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label" > Zstart </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="zstartID" name="zstart" type="text" value=""/>
                                    </td>
                                </tr>


                                <tr >
                                    <td id="td_left">
                                        <label id="gadget2_label">Levelmin</label> 
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input  class="gadget2_textbox" id="levelminID" name="levelmin" type="text" value=""/></dt>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">Levelmin_TF</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="levelmin_TFID" name="levelmin_TF" type="text" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">Levelmax</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input  class="gadget2_textbox" id="levelmaxID" name="levelmax" type="text" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">Padding</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="paddingID" name="padding" type="text" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">overlap</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input  class="gadget2_textbox" id="overlapID" name="overlap" type="text" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">ref_center</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="ref_centerID" name="ref_center" type="text" value=""/>
                                    </td>
                                </tr>

                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">ref_extent</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="ref_extentID" name="ref_extent" type="text" value=""/>
                                    </td>
                                </tr>




                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">align_top</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="align_top" id="align_top_Y_ID" value="Y"> Y 
                                        <input type="radio" name="align_top" id="align_top_N_ID" value="N"> N
                                    </td>
                                </tr>


                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">baryons</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="baryons" id="baryons_Y_ID" value="Y"> Y 
                                        <input type="radio" name="baryons" id="baryons_N_ID" value="N"> N
                                    </td>
                                </tr>

                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">use_2LPT</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="use_2LPT" id="use_2LPT_Y_ID" value="Y"> Y 
                                        <input type="radio" name="use_2LPT" id="use_2LPT_N_ID" value="N"> N
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">use_LLA</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="use_LLA" id="use_LLA_Y_ID" value="Y"> Y
                                        <input type="radio" name="use_LLA" id="use_LLA_N_ID" value="N"> N
                                    </td>
                                </tr>

                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">periodic_TF</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="periodic_TF" id="periodic_TF_Y_ID" value="Y"> Y
                                        <input type="radio" name="periodic_TF" id="periodic_TF_N_ID" value="N"> N
                                    </td>
                                </tr>
                                <tr>

                                    <td colspan="3" align="center">
                                        <input type="button" value="Demo" onclick="SetDemoSetupValue()">
                                        <input type="button" value="Reset" onclick="ResetDemoSetupValue()">
                                    </td>
                                </tr>
                                <tr>
                                <br>
                                <td colspan="3" align="center">
                                    <input type="button" value="Validate Setup" onclick="ValidateSetupValue()"></td>
                                </tr>
                            </table>






                        </fieldset>
                    </center>
                </div>
            </td>
            <td style="vertical-align: top;">
                <div id="gadget2_cosmology">
                    <center>
                        <fieldset class="gadget2_fieldset">

                            <legend class="gadget2_legend"> COSMOLOGY Value </legend>
                            <table >
                                <tr>
                                    <td id="td_left">   
                                        <label id="gadget2_label">Omega_m </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="Omega_mID" name="Omega_m" type="text"  />
                                    </td>
                                </tr>


                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label" > Omega_L </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="Omega_LID" name="Omega_L" type="text" value=""/>
                                    </td>
                                </tr>


                                <tr >
                                    <td id="td_left">
                                        <label id="gadget2_label">Omega_b</label> 
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input  class="gadget2_textbox" id="Omega_bID" name="Omega_b" type="text" value=""/></dt>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">H0</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="H0ID" name="H0" type="text" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">sigma_8</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input  class="gadget2_textbox" id="sigma_8ID" name="sigma_8" type="text" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">nspec</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="nspecID" name="nspec" type="text" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">transfer</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input  class="gadget2_textbox" id="transferID" name="transfer" type="text" value=""/>
                                    </td>
                                </tr>






                                <tr>
                                    <td colspan="3" align="center">
                                        <input type="button" value="Demo" onclick="DemoCosmologyValues()">
                                        <input type="button" value="Reset" onclick="ResetCosmologyValues()">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="center">
                                        <input type="button" value="Validate Cosmology" onclick="ValidateCosmologyValues()">
                                    </td>
                                </tr>
                            </table>






                        </fieldset>
                    </center>

                </div>
            </td>
            <td style="vertical-align: top;">
                <div id="gadget2_random">
                    <center>
                        <fieldset class="gadget2_fieldset">

                            <legend class="gadget2_legend"> RANDOM Value </legend>
                            <table >
                                <tr>
                                    <td id="td_left">   
                                        <label id="gadget2_label">seed[7] </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="seed7ID" name="seed7" type="text"  />
                                    </td>
                                </tr>


                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label" > seed[8] </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="seed8ID" name="seed8" type="text" value=""/>
                                    </td>
                                </tr>


                                <tr >
                                    <td id="td_left">
                                        <label id="gadget2_label">seed[9]</label> 
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input  class="gadget2_textbox" id="seed9ID" name="seed9" type="text" value=""/></dt>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">seed[10]</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="seed10ID" name="seed10" type="text" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">seed[11]</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input  class="gadget2_textbox" id="seed11ID" name="seed11" type="text" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">seed[12]</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="seed12ID" name="seed12" type="text" value=""/>
                                    </td>
                                </tr>



                                <tr>
                                    <td colspan="3" align="center"><input type="button" value="Demo" onclick="DemoRandomValues()">
                                        <input type="button" value="Reset" onclick="ResetRandomValues()"></td>
                                </tr>
                                <tr>
                                    <td colspan="3"  align="center"><input type="button" value="Validate Random" onclick="ValidateRandomValues()"></td>
                                </tr>
                            </table>






                        </fieldset>
                    </center>
                </div>
            </td>

        </tr>
        <tr>
            <td style="vertical-align: top;">
                <div id="gadget2_poisson">
                    <center>
                        <fieldset class="gadget2_poisson">



                            <legend class="gadget2_legend"> POISSON Value </legend>

                            <table>

                                <tr>

                                    <td id="td_left">   
                                        <label id="gadget2_label">fft_fine </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>

                                    <td id="td_right">
                                        <input  type="radio" name="fft_fine" id="fft_fineID" value="Y"> Y 
                                        <input type="radio" name="fft_fine" id="fft_fineID" value="N"> N
                                    </td>


                                </tr>


                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label" > accuracy </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="accuracyID" name="accuracy" type="text" value=""/>
                                    </td>
                                </tr>


                                <tr >
                                    <td id="td_left">
                                        <label id="gadget2_label">pre_smooth</label> 
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input  class="gadget2_textbox" id="pre_smoothID" name="pre_smooth" type="text" value=""/></dt>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">post_smooth</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="post_smoothID" name="post_smooth" type="text" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">smoother</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input  class="gadget2_textbox" id="smootherID" name="smoother" type="text" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">laplace_order</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="laplace_orderID" name="laplace_order" type="text" value=""/>
                                    </td>
                                </tr>

                                <tr>
                                    <td id="td_left">
                                        <label id="gadget2_label">grad_order</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="grad_orderID" name="grad_order" type="text" value=""/>
                                    </td>
                                </tr>


                                <tr>
                                    <td colspan="3" align="center"><input type="button" value="Demo" onclick="DemoPoissonValues()">
                                        <input type="button" value="Reset" onclick="ResetPoissonValues()"></td>
                                </tr>
                                <tr>
                                    <td colspan="3"  align="center"><input type="button" value="Validate Random" onclick="ValidatePoissonValues()"></td>
                                </tr>
                            </table>






                        </fieldset>
                    </center>
                </div>
            </td>





        </tr>
    </table>
</div>





</form>




<script>
    
 
    
    function SetDemoSetupValue(){
        document.getElementById("boxlengthID").value="100";
        document.getElementById("zstartID").value="50";
        document.getElementById("levelminID").value="7";
        document.getElementById("levelmin_TFID").value="8";
        document.getElementById("levelmaxID").value="9";
        document.getElementById("paddingID").value="4";
        document.getElementById("overlapID").value="8";
        
        document.getElementById("ref_centerID").value="0.5,0.5,0.5";
        document.getElementById("ref_extentID").value="0.2,0.2,0.2";
        
        
        if(document.getElementById("align_top_N_ID").value=="N")
            document.getElementById("align_top_N_ID").checked=true;
      
        
       
       
       
        if(document.getElementById("use_2LPT_N_ID").value=="N")
            document.getElementById("use_2LPT_N_ID").checked=true;
        
    
       
        if(document.getElementById("baryons_N_ID").value=="N")
            document.getElementById("baryons_N_ID").checked=true;
       
        if(document.getElementById("use_LLA_N_ID").value=="N")
            document.getElementById("use_LLA_N_ID").checked=true;
       
       
        if(document.getElementById("periodic_TF_Y_ID").value=="Y")
            document.getElementById("periodic_TF_Y_ID").checked=true;
        var y=document.getElementById("periodic_TF_Y_ID").value;
        

        
      
    }
    function ResetDemoSetupValue(){
        document.getElementById("boxlengthID").value="";
        document.getElementById("zstartID").value="";
        document.getElementById("levelminID").value="";
        document.getElementById("levelmaxID").value="";
        document.getElementById("paddingID").value="";
        document.getElementById("overlapID").value="";
        document.getElementById("levelmin_TFID").value="";
        document.getElementById("ref_centerID").value="";
        document.getElementById("ref_extentID").value="";
        

        
        if(document.getElementById("align_top_N_ID").checked)
            document.getElementById("align_top_N_ID").checked=false;
        if(document.getElementById("align_top_Y_ID").checked)
            document.getElementById("align_top_Y_ID").checked=false;
        
       
        if(document.getElementById("use_2LPT_N_ID").checked)
            document.getElementById("use_2LPT_N_ID").checked=false;
        if(document.getElementById("use_2LPT_Y_ID").checked)
            document.getElementById("use_2LPT_Y_ID").checked=false;
        
       
        if(document.getElementById("baryons_N_ID").checked)
            document.getElementById("baryons_N_ID").checked=false;
        if(document.getElementById("baryons_Y_ID").checked)
            document.getElementById("baryons_Y_ID").checked=false;
        
       
        if(document.getElementById("use_LLA_N_ID").checked)
            document.getElementById("use_LLA_N_ID").checked=false;
        if(document.getElementById("use_LLA_Y_ID").checked)
            document.getElementById("use_LLA_Y_ID").checked=false;
        
        if(document.getElementById("periodic_TF_N_ID").checked) 
            document.getElementById("periodic_TF_N_ID").checked=false;
        if(document.getElementById("periodic_TF_Y_ID").checked) 
            document.getElementById("periodic_TF_Y_ID").checked=false;
        
    }
    function ValidateSetupvalue(){
        alert("Controllare i parametri!");
    }
    
    
   
    
    function DemoCosmologyValues(){
        document.getElementById("Omega_mID").value="0.276";
        document.getElementById("Omega_LID").value="0.724";
        document.getElementById("Omega_bID").value="0.045";
        document.getElementById("H0ID").value="70.3";
        document.getElementById("sigma_8ID").value="0.811";
        document.getElementById("nspecID").value="0.961";
        document.getElementById("transferID").value="eisenstein";  
        
    }
    function ResetCosmologyValues(){
        document.getElementById("Omega_mID").value="";
        document.getElementById("Omega_LID").value="";
        document.getElementById("Omega_bID").value="";
        document.getElementById("H0ID").value="";
        document.getElementById("sigma_8ID").value="";
        document.getElementById("nspecID").value="";
        document.getElementById("transferID").value="";  
    }
    function ValidateCosmologyValues(){
        alert("Controllare i parametri!");
    }


    function DemoRandomValues(){
        document.getElementById("seed7ID").value="12345";
        document.getElementById("seed8ID").value="23456";
        document.getElementById("seed9ID").value="34567";
        document.getElementById("seed10ID").value="45678";
        document.getElementById("seed11ID").value="56789";
        document.getElementById("seed12ID").value="67890";
         
        
    }
    function ResetRandomValues(){
        document.getElementById("seed7ID").value="";
        document.getElementById("seed8ID").value="";
        document.getElementById("seed9ID").value="";
        document.getElementById("seed10ID").value="";
        document.getElementById("seed11ID").value="";
        document.getElementById("seed12ID").value=""; 
    }
    function ValidateRandomValues(){
        alert("Controllare i parametri!");
    }
    

    
    function DemoPoissonValues(){
       
        if(document.getElementById("fft_fineID").value=="Y")
            document.getElementById("fft_fineID").checked=true;
        document.getElementById("accuracyID").value="1e-5";
        document.getElementById("pre_smoothID").value="3";
        document.getElementById("post_smoothID").value="3";
        document.getElementById("smootherID").value="gs";
        document.getElementById("laplace_orderID").value="6";
        document.getElementById("grad_orderID").value="6";
    }
    
    function ResetPoissonValues(){
        document.getElementById("fft_fineID").checked=false;
        document.getElementById("accuracyID").value="";
        document.getElementById("pre_smoothID").value="";
        document.getElementById("post_smoothID").value="";
        document.getElementById("smootherID").value="";
        document.getElementById("laplace_orderID").value="";
        document.getElementById("grad_orderID").value="";
    }
    
function ValidatePoissonValues(){
    alert("Controllare i parametri!");
}
</script>





