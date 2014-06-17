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

<script type="text/javascript">
<!--//
    //Script for SlideShow
    var i = 0; var path = new Array(); 
    // LIST OF IMAGES 
    path[0] = "<%=renderRequest.getContextPath()%>/images/img_1.jpg"; 
    path[1] = "<%=renderRequest.getContextPath()%>/images/img_2.jpg"; 
    path[2] = "<%=renderRequest.getContextPath()%>/images/img_3.jpg"; 
    path[3] = "<%=renderRequest.getContextPath()%>/images/img_4.jpg"; 
    path[4] = "<%=renderRequest.getContextPath()%>/images/img_5.jpg"; 
    path[5] = "<%=renderRequest.getContextPath()%>/images/img_6.jpg"; 

    function swapImage(){
        document.slide.src = path[i]; 
        if(i < path.length - 1) i++; 
        else i = 0; 
        setTimeout("swapImage()",3000); 
    } 

</script>

<%
// Below the descriptive area of the GATE web form 
%>
<table>
    <tr>
        <td valign="top">


            <img onload="swapImage();" src="<%=renderRequest.getContextPath()%>/images/img_1.jpg" width="0" heigh="0"/>
            <img align="left" style="padding:10px 10px;" name="slide" src="<%=renderRequest.getContextPath()%>/images/img_1.jpg" width="220" height="140"/>
        </td>
        <td>
           <!--This is an example portlet!
            <p><b>Exchange data between jsp page and java codeeee</b></p>-->
           
           <p style="font-size: small"> 
               GADGET is a freely available code for cosmological N-body/SPH<br/> 
               simulations on massively parallel computers with distributed memory.<br/> 
               GADGET uses an explicit communication model that is implemented<br/>
               with the standardized MPI communication interface. <br/>
               The code can be run on essentially all supercomputer systems presently in use,<br/>
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
                                        <label class="gadget2_label" id="labelBoxlengthID"  >Boxlength </label>
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
                                        <label class="gadget2_label" id="zstartLabelID" > Zstart </label>
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
                                        <label class="gadget2_label" id="levelminLabelID">Levelmin</label> 
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
                                        <label class="gadget2_label" id="levelmin_TFLabelID">Levelmin_TF</label>
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
                                        <label class="gadget2_label" id="levelmaxLabelID">Levelmax</label>
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
                                        <label class="gadget2_label" id="paddingLabelID" >Padding</label>
                                    </td>
                                    <td id="td_center">
                                        <label class="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="paddingID" name="padding" type="text" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">
                                        <label class="gadget2_label" id="overlapLabelID">overlap</label>
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
                                        <label class="gadget2_label" id="ref_centerLabelID">ref_center</label>
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
                                        <label class="gadget2_label" id="ref_extentLabelID">ref_extent</label>
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
                                        <label class="gadget2_label" id="ref_offsetLabelID">ref_offset</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>

                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="ref_offsetID" name="ref_offset" type="text" value=""/>
                                    </td>
                                </tr>


                                <tr>
                                    <td id="td_left">
                                        <label class="gadget2_label" id="align_top_LabelID">align_top</label>
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
                                        <label class="gadget2_label" id="baryons_LabelID">baryons</label>
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
                                        <label class="gadget2_label" id="use_2LPT_LabelID">use_2LPT</label>
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
                                        <label class="gadget2_label" id="use_LLA_LabelID">use_LLA</label>
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
                                        <label class="gadget2_label" id="periodic_TF_LabelID">periodic_TF</label>
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
                                        <input type="button" value="Reset" onclick="ResetSetupValue()">
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
                                        <label class="gadget2_label"  id="Omega_mLabelID">Omega_m </label>
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
                                        <label class="gadget2_label" id="Omega_LlabelID"> Omega_L </label>
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
                                        <label class="gadget2_label" id="Omega_bLabelID">Omega_b</label> 
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
                                        <label class="gadget2_label" id="H0LabelID">H0</label>
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
                                        <label class="gadget2_label" id ="sigma_8LabelID">sigma_8</label>
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
                                        <label class="gadget2_label" id="nspecLabelID">nspec</label>
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
                                        <label class="gadget2_label" id="transferLabelID">transfer</label>
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
                                        <label class="gadget2_label" id="seed7LabelID">seed[7] </label>
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
                                        <label class="gadget2_label" id="seed8LabelID"> seed[8] </label>
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
                                        <label class="gadget2_label" id="seed9LabelID">seed[9]</label> 

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
                                        <label class="gadget2_label" id="seed10LabelID">seed[10]</label>
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
                                        <label class="gadget2_label" id="seed11LabelID">seed[11]</label>
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
                                        <label class="gadget2_label" id="seed12LabelID">seed[12]</label>

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
                                        <label class="gadget2_label" id="fft_fineLabelID">fft_fine </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>

                                    <td id="td_right">
                                        <input  type="radio" name="fft_fine" id="fft_fine_Y_ID" value="Y"> Y 
                                        <input type="radio" name="fft_fine" id="fft_fine_N_ID" value="N"> N
                                    </td>


                                </tr>


                                <tr>
                                    <td id="td_left">
                                        <label class="gadget2_label" id="accuracyLabelID"> accuracy </label>
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
                                        <label class="gadget2_label" id="pre_smoothLabelID">pre_smooth</label> 
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
                                        <label class="gadget2_label" id="post_smoothLabelID">post_smooth</label>
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
                                        <label class="gadget2_label" id="smootherLabelID">smoother</label>
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
                                        <label class="gadget2_label" id="laplace_orderLabelID">laplace_order</label>
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
                                        <label class="gadget2_label" id="grad_orderLabelID">grad_order</label>
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




<div align="center"><input type="button" value="Submit" onClick="preSubmit()"></div>
</form>

<script>
    
    var setupIsValidate=false;
    var cosmologyIsValidate=false;
    var randomIsValidate=false;
    var poissonIsValidate=false;
    
    function SetDemoSetupValue(){
        document.getElementById("boxlengthID").value="100";
        document.getElementById("labelBoxlengthID").style.color="black";
        
        document.getElementById("zstartID").value="50";
        document.getElementById("zstartLabelID").style.color="black";
        
        
        document.getElementById("levelminID").value="7";
        document.getElementById("levelminLabelID").style.color="black";
        
        document.getElementById("levelmin_TFID").value="7";
        document.getElementById("levelmin_TFLabelID").style.color="black";
        
        
        document.getElementById("levelmaxID").value="8";
        document.getElementById("levelmaxLabelID").style.color="black";
        
        
        document.getElementById("paddingID").value="8";
        document.getElementById("paddingLabelID").style.color="black";
        
        document.getElementById("overlapID").value="4";
        document.getElementById("overlapLabelID").style.color="black";
        
        document.getElementById("ref_centerID").value="0.5,0.5,0.5";
        document.getElementById("ref_centerLabelID").style.color="black";
        
        document.getElementById("ref_extentID").value="0.2,0.2,0.2";
        document.getElementById("ref_extentLabelID").style.color="black";
        
        document.getElementById("ref_offsetID").value="0.4,0.4,0.4";
        document.getElementById("ref_offsetLabelID").style.color="black";
        
        
        if(document.getElementById("align_top_Y_ID").value=="Y"){
            document.getElementById("align_top_Y_ID").checked=true;
            document.getElementById("align_top_LabelID").style.color="black";
        }
       
       
       
        if(document.getElementById("use_2LPT_N_ID").value=="N"){
            document.getElementById("use_2LPT_N_ID").checked=true;
            document.getElementById("use_2LPT_LabelID").style.color="black";
        }
    
       
        if(document.getElementById("baryons_N_ID").value=="N"){
            document.getElementById("baryons_N_ID").checked=true;
            document.getElementById("baryons_LabelID").style.color="black";
        }
        if(document.getElementById("use_LLA_Y_ID").value=="Y"){
            document.getElementById("use_LLA_Y_ID").checked=true;
            document.getElementById("use_LLA_LabelID").style.color="black";
        }
       
       
        if(document.getElementById("periodic_TF_Y_ID").value=="Y"){
            document.getElementById("periodic_TF_Y_ID").checked=true;
            document.getElementById("periodic_TF_LabelID").style.color="black";
        }
       
       
       
        

        
      
    }
    function ResetSetupValue(){
        document.getElementById("boxlengthID").value="";
        document.getElementById("zstartID").value="";
        document.getElementById("levelminID").value="";
        document.getElementById("levelmaxID").value="";
        document.getElementById("paddingID").value="";
        document.getElementById("overlapID").value="";
        document.getElementById("levelmin_TFID").value="";
        document.getElementById("ref_centerID").value="";
        document.getElementById("ref_extentID").value="";
        document.getElementById("ref_offsetID").value="";
        

        
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
        
        
        
        document.getElementById("labelBoxlengthID").style.color="black";
        document.getElementById("zstartLabelID").style.color="black";
        document.getElementById("levelminLabelID").style.color="black";
        document.getElementById("levelmaxLabelID").style.color="black";
        document.getElementById("paddingLabelID").style.color="black";
        document.getElementById("overlapLabelID").style.color="black";
        document.getElementById("levelmin_TFLabelID").style.color="black";
        document.getElementById("ref_centerLabelID").style.color="black";
        document.getElementById("ref_extentLabelID").style.color="black";
        document.getElementById("ref_offsetLabelID").style.color="black";
        document.getElementById("align_top_LabelID").style.color="black";
        document.getElementById("use_2LPT_LabelID").style.color="black";
        document.getElementById("baryons_LabelID").style.color="black";
        document.getElementById("use_LLA_LabelID").style.color="black";
        document.getElementById("periodic_TF_LabelID").style.color="black";
        
    }
    function ValidateSetupValue(){
     
        if(document.getElementById("periodic_TF_Y_ID").checked==false && document.getElementById("periodic_TF_N_ID").checked==false){
            document.getElementById("periodic_TF_LabelID").style.color="red";
            b1=false;
            document.getElementById("periodic_TF_Y_ID").focus();
        }
        else{
            document.getElementById("periodic_TF_LabelID").style.color="black";
        }
        //type control param and range control param

        if(document.getElementById("use_LLA_N_ID").checked==false && document.getElementById("use_LLA_Y_ID").checked==false){
            document.getElementById("use_LLA_LabelID").style.color="red";
            b1=false;    
            document.getElementById("use_LLA_Y_ID").focus();
        }
        else{
            document.getElementById("use_LLA_LabelID").style.color="black";
        }
        //type control param and range control param 

        if(document.getElementById("use_2LPT_N_ID").checked==false && document.getElementById("use_2LPT_Y_ID").checked==false){
            document.getElementById("use_2LPT_LabelID").style.color="red";
            b1=false;
            document.getElementById("use_2LPT_Y_ID").focus();
        }
        else{
            document.getElementById("use_2LPT_LabelID").style.color="black";
        }

        if(document.getElementById("baryons_N_ID").checked==false && document.getElementById("baryons_Y_ID").checked==false){ 
            document.getElementById("baryons_LabelID").style.color="red";
            b1=false;
            document.getElementById("baryons_Y_ID").focus();
        }
        else{
            document.getElementById("baryons_LabelID").style.color="black";
        }
        //type control param and range control param

        if(document.getElementById("align_top_N_ID").checked==false && document.getElementById("align_top_Y_ID").checked==false){
            document.getElementById("align_top_LabelID").style.color="red";
            b1=false;
            document.getElementById("align_top_Y_ID").focus();
        }
        else{
            document.getElementById("align_top_LabelID").style.color="black";
        }

        if(document.getElementById("ref_offsetID").value== null || document.getElementById("ref_offsetID").value==""){
            document.getElementById("ref_offsetID").value="";
            document.getElementById("ref_offsetLabelID").style.color="red";
            b1=false;
            document.getElementById("ref_offsetID").focus();       
        }else{
            document.getElementById("ref_offsetLabelID").style.color="black";
        }

        if(document.getElementById("ref_extentID").value== null || document.getElementById("ref_extentID").value==""){
            document.getElementById("ref_extentID").value="";
            document.getElementById("ref_extentLabelID").style.color="red";
            b1=false;
            document.getElementById("ref_extentID").focus();
       
        }else{
            document.getElementById("ref_extentLabelID").style.color="black";
        }        

        if(document.getElementById("ref_centerID").value== null || document.getElementById("ref_centerID").value==""){
            document.getElementById("ref_centerID").value="";
            document.getElementById("ref_centerLabelID").style.color="red";
            b1=false;
            document.getElementById("ref_centerID").focus();
        }else{
            document.getElementById("ref_centerLabelID").style.color="black";
        }

        if(document.getElementById("overlapID").value== null || document.getElementById("overlapID").value==""){
            document.getElementById("overlapID").value="";
            document.getElementById("overlapLabelID").style.color="red";
            b1=false;
            document.getElementById("overlapID").focus();
        } else{
            document.getElementById("overlapLabelID").style.color="black";
        }

        if(document.getElementById("paddingID").value== null || document.getElementById("paddingID").value==""){
            document.getElementById("paddingID").value="";
            document.getElementById("paddingLabelID").style.color="red";
            b1=false;
            document.getElementById("paddingID").focus();
        } 
        else{
            document.getElementById("paddingLabelID").style.color="black";
        }

        if(document.getElementById("levelmaxID").value== null || document.getElementById("levelmaxID").value==""){
            document.getElementById("levelmaxID").value="";
            document.getElementById("levelmaxLabelID").style.color="red";
            b1=false;
            document.getElementById("levelmaxID").focus();
        }
        else{
            document.getElementById("levelmaxLabelID").style.color="black";
        }

        if(document.getElementById("levelmin_TFID").value== null || document.getElementById("levelmin_TFID").value==""){
            document.getElementById("levelmin_TFID").value="";
            document.getElementById("levelmin_TFLabelID").style.color="red";
            b1=false;
            document.getElementById("levelmin_TFID").focus();
        }
        else{
            document.getElementById("levelmin_TFLabelID").style.color="black";
        }
        
        if(document.getElementById("levelminID").value== null || document.getElementById("levelminID").value==""){
            document.getElementById("levelminID").value="";
            document.getElementById("levelminLabelID").style.color="red";
            b1=false;
            document.getElementById("levelminID").focus();
        }
        else{
            document.getElementById("levelminLabelID").style.color="black";
        }

        if(document.getElementById("zstartID").value== null || document.getElementById("zstartID").value==""){
            document.getElementById("zstartID").value="";
            document.getElementById("zstartLabelID").style.color="red";
            b1=false;
            document.getElementById("zstartID").focus();
        }
        else{
            document.getElementById("zstartLabelID").style.color="black";
        }        

        if(document.getElementById("boxlengthID").value== null || document.getElementById("boxlengthID").value==""){
            document.getElementById("boxlengthID").value="";
            document.getElementById("labelBoxlengthID").style.color="red";
            b1=false;
            document.getElementById("boxlengthID").focus();
        }
        else{
            document.getElementById("labelBoxlengthID").style.color="black";
            //type control param and range control param
        }

        if(b1==false){
            alert("Attention! \n Enter the parameters highlighted in red");
        }
        else{
            setupIsValidate=true;
            
            alert("Setup values validate "+ setupIsValidate);
            document.getElementById("setup_fieldset").style.border.color="black";
        }


    }
   
    


    
    
   
    
    function DemoCosmologyValues(){
        document.getElementById("Omega_mID").value="0.276";
        document.getElementById("Omega_mLabelID").style.color="black";
        
        document.getElementById("Omega_LID").value="0.724";
        document.getElementById("Omega_LlabelID").style.color="black";
        
        document.getElementById("Omega_bID").value="0.045";
        document.getElementById("Omega_bLabelID").style.color="black";
        
        document.getElementById("H0ID").value="70.3";
        document.getElementById("H0LabelID").style.color="black";
        
        document.getElementById("sigma_8ID").value="0.811";
        document.getElementById("sigma_8LabelID").style.color="black";
        
        document.getElementById("nspecID").value="0.961";
        document.getElementById("nspecLabelID").style.color="black";
        
        document.getElementById("transferID").value="eisenstein";
        document.getElementById("transferLabelID").style.color="black";
        
    }
    function ResetCosmologyValues(){
        document.getElementById("Omega_mID").value="";
        document.getElementById("Omega_LID").value="";
        document.getElementById("Omega_bID").value="";
        document.getElementById("H0ID").value="";
        document.getElementById("sigma_8ID").value="";
        document.getElementById("nspecID").value="";
        document.getElementById("transferID").value=""; 
        
        document.getElementById("Omega_mLabelID").style.color="black";
        document.getElementById("Omega_LlabelID").style.color="black";
        document.getElementById("Omega_bLabelID").style.color="black";
        document.getElementById("H0LabelID").style.color="black";
        document.getElementById("sigma_8LabelID").style.color="black";
        document.getElementById("nspecLabelID").style.color="black";
        document.getElementById("transferLabelID").style.color="black";
    }
    
    function ValidateCosmologyValues(){
        var  bool= true; //bool

        if(document.getElementById("transferID").value== null || document.getElementById("transferID").value==""){
            document.getElementById("transferID").value="";
            document.getElementById("transferLabelID").style.color="red";
            bool=false;
            document.getElementById("transferID").focus();
        } else{
            document.getElementById("transferLabelID").style.color="black";
        }

        if(document.getElementById("nspecID").value== null || document.getElementById("nspecID").value==""){
            document.getElementById("nspecID").value="";
            document.getElementById("nspecLabelID").style.color="red";
            bool=false;
            document.getElementById("nspecID").focus();
        } 
        else{
            document.getElementById("nspecLabelID").style.color="black";
        }

        if(document.getElementById("sigma_8ID").value== null || document.getElementById("sigma_8ID").value==""){
            document.getElementById("sigma_8ID").value="";
            document.getElementById("sigma_8LabelID").style.color="red";
            bool=false;
            document.getElementById("sigma_8ID").focus();
        }
        else{
            document.getElementById("sigma_8LabelID").style.color="black";
        }

        if(document.getElementById("H0ID").value== null || document.getElementById("H0ID").value==""){
            document.getElementById("H0ID").value="";
            document.getElementById("H0LabelID").style.color="red";
            bool=false;
            document.getElementById("H0ID").focus();
        }
        else{
            document.getElementById("H0LabelID").style.color="black";
        }

        if(document.getElementById("Omega_bID").value== null || document.getElementById("Omega_bID").value==""){
            document.getElementById("Omega_bID").value="";
            document.getElementById("Omega_bLabelID").style.color="red";
            bool=false;
            document.getElementById("Omega_bID").focus();
        }
        else{
            document.getElementById("Omega_bLabelID").style.color="black";
        }

        if(document.getElementById("Omega_LID").value== null || document.getElementById("Omega_LID").value==""){
            document.getElementById("Omega_LID").value="";
            document.getElementById("Omega_LlabelID").style.color="red";
            bool=false;
            document.getElementById("Omega_LID").focus();
        }
        else{
            document.getElementById("Omega_LlabelID").style.color="black";
        }

        if(document.getElementById("Omega_mID").value== null || document.getElementById("Omega_mID").value==""){
            document.getElementById("Omega_mID").value="";
            document.getElementById("Omega_mLabelID").style.color="red";
            bool=false;
            document.getElementById("Omega_mID").focus();
        }
        else{
            document.getElementById("Omega_mLabelID").style.color="black";
            //type control param and range control param
        }

        if(bool==false){
            alert("Attention! \n Enter the parameters highlighted in red");
        }
        else{
            cosmologyIsValidate=true;
            alert("Cosmology values validate "+cosmologyIsValidate);
        }

        
        
    }
    



    function DemoRandomValues(){
        document.getElementById("seed7ID").value="12345";
        document.getElementById("seed7LabelID").style.color="black";
        
        document.getElementById("seed8ID").value="23456";
        document.getElementById("seed8LabelID").style.color="black";
        
        document.getElementById("seed9ID").value="34567";
        document.getElementById("seed9LabelID").style.color="black";
        
        document.getElementById("seed10ID").value="45678";
        document.getElementById("seed10LabelID").style.color="black";
        
        document.getElementById("seed11ID").value="56789";
        document.getElementById("seed11LabelID").style.color="black";
        
        document.getElementById("seed12ID").value="67890";
        document.getElementById("seed12LabelID").style.color="black";
         
        
    }
    function ResetRandomValues(){
        document.getElementById("seed7ID").value="";
        document.getElementById("seed8ID").value="";
        document.getElementById("seed9ID").value="";
        document.getElementById("seed10ID").value="";
        document.getElementById("seed11ID").value="";
        document.getElementById("seed12ID").value=""; 
        
        document.getElementById("seed7LabelID").style.color="black";
        document.getElementById("seed8LabelID").style.color="black";
        document.getElementById("seed9LabelID").style.color="black";
        document.getElementById("seed10LabelID").style.color="black";
        document.getElementById("seed11LabelID").style.color="black";
        document.getElementById("seed12LabelID").style.color="black";
    }
    function ValidateRandomValues(){
        var  bool= true; //bool              

        if(document.getElementById("seed12ID").value== null || document.getElementById("seed12ID").value==""){
            document.getElementById("seed12ID").value="";
            document.getElementById("seed12LabelID").style.color="red";
            bool=false;
            document.getElementById("seed12ID").focus();
        } 
        else{
            document.getElementById("seed12LabelID").style.color="black";
        }
        
        if(document.getElementById("seed11ID").value== null || document.getElementById("seed11ID").value==""){
            document.getElementById("seed11ID").value="";
            document.getElementById("seed11LabelID").style.color="red";
            bool=false;
            document.getElementById("seed11ID").focus();
        }
        else{
            document.getElementById("seed11LabelID").style.color="black";
        }
        
        if(document.getElementById("seed10ID").value== null || document.getElementById("seed10ID").value==""){
            document.getElementById("seed10ID").value="";
            document.getElementById("seed10LabelID").style.color="red";
            bool=false;
            document.getElementById("seed10ID").focus();
        }
        else{
            document.getElementById("seed10LabelID").style.color="black";
        }
        
        if(document.getElementById("seed9ID").value== null || document.getElementById("seed9ID").value==""){
            document.getElementById("seed9ID").value="";
            document.getElementById("seed9LabelID").style.color="red";
            bool=false;
            document.getElementById("seed9ID").focus();
        }
        else{
            document.getElementById("seed9LabelID").style.color="black";
        }

        if(document.getElementById("seed8ID").value== null || document.getElementById("seed8ID").value==""){
            document.getElementById("seed8ID").value="";
            document.getElementById("seed8LabelID").style.color="red";
            bool=false;
            document.getElementById("seed8ID").focus();
        }
        else{
            document.getElementById("seed8LabelID").style.color="black";
        }

        if(document.getElementById("seed7ID").value== null || document.getElementById("seed7ID").value==""){
            document.getElementById("seed7ID").value="";
            document.getElementById("seed7LabelID").style.color="red";
            bool=false;
            document.getElementById("seed7ID").focus();
        }
        else{
            document.getElementById("seed7LabelID").style.color="black";
            //type control param and range control param
        }
                   
        if(bool==false){
            alert("Attention! \n Enter the parameters highlighted in red");
        }
        else{
            randomIsValidate=true;
            alert("Random values validate "+randomIsValidate);
        }
            
            
        
    }
    

    
    function DemoPoissonValues(){
       
        if(document.getElementById("fft_fine_Y_ID").value=="Y"){
            document.getElementById("fft_fine_Y_ID").checked=true;
            document.getElementById("fft_fineLabelID").style.color="black";
        }
        document.getElementById("accuracyID").value="1e-5";
        document.getElementById("accuracyLabelID").style.color="black";
        
        document.getElementById("pre_smoothID").value="3";
        document.getElementById("pre_smoothLabelID").style.color="black";
        
        document.getElementById("post_smoothID").value="3";
        document.getElementById("post_smoothLabelID").style.color="black";
        
        document.getElementById("smootherID").value="gs";
        document.getElementById("smootherLabelID").style.color="black";
        
        document.getElementById("laplace_orderID").value="6";
        document.getElementById("laplace_orderLabelID").style.color="black";
        
        document.getElementById("grad_orderID").value="6";
        document.getElementById("grad_orderLabelID").style.color="black";
    }
    
    function ResetPoissonValues(){
        
        if(document.getElementById("fft_fine_N_ID").checked)
            document.getElementById("fft_fine_N_ID").checked=false;
        if(document.getElementById("fft_fine_Y_ID").checked)
            document.getElementById("fft_fine_Y_ID").checked=false;
        document.getElementById("accuracyID").value="";
        document.getElementById("pre_smoothID").value="";
        document.getElementById("post_smoothID").value="";
        document.getElementById("smootherID").value="";
        document.getElementById("laplace_orderID").value="";
        document.getElementById("grad_orderID").value="";
        
        document.getElementById("fft_fineLabelID").style.color="black";
        document.getElementById("accuracyLabelID").style.color="black";
        document.getElementById("pre_smoothLabelID").style.color="black";
        document.getElementById("post_smoothLabelID").style.color="black";
        document.getElementById("smootherLabelID").style.color="black";
        document.getElementById("laplace_orderLabelID").style.color="black";
        document.getElementById("grad_orderLabelID").style.color="black";
        
    }
    
    function ValidatePoissonValues(){
        var  bool= true; //bool

        if(document.getElementById("grad_orderID").value== null || document.getElementById("grad_orderID").value==""){
            document.getElementById("grad_orderID").value="";
            document.getElementById("grad_orderLabelID").style.color="red";
            bool=false;
            document.getElementById("grad_orderID").focus();
        } 
        else{
            document.getElementById("grad_orderLabelID").style.color="black";
        }

        if(document.getElementById("laplace_orderID").value== null || document.getElementById("laplace_orderID").value==""){
            document.getElementById("laplace_orderID").value="";
            document.getElementById("laplace_orderLabelID").style.color="red";
            bool=false;
            document.getElementById("laplace_orderID").focus();
        } 
        else{
            document.getElementById("laplace_orderLabelID").style.color="black";
        }

        if(document.getElementById("smootherID").value== null || document.getElementById("smootherID").value==""){
            document.getElementById("smootherID").value="";
            document.getElementById("smootherLabelID").style.color="red";
            bool=false;
            document.getElementById("smootherID").focus();
        }
        else{
            document.getElementById("smootherLabelID").style.color="black";
        }

        if(document.getElementById("post_smoothID").value== null || document.getElementById("post_smoothID").value==""){
            document.getElementById("post_smoothID").value="";
            document.getElementById("post_smoothLabelID").style.color="red";
            bool=false;
            document.getElementById("post_smoothID").focus();
        }
        else{
            document.getElementById("post_smoothLabelID").style.color="black";
        }

        if(document.getElementById("pre_smoothID").value== null || document.getElementById("pre_smoothID").value==""){
            document.getElementById("pre_smoothID").value="";
            document.getElementById("pre_smoothLabelID").style.color="red";
            bool=false;
            document.getElementById("pre_smoothID").focus();
        }
        else{
            document.getElementById("pre_smoothLabelID").style.color="black";
        }
        
        if(document.getElementById("accuracyID").value== null || document.getElementById("accuracyID").value==""){
            document.getElementById("accuracyID").value="";
            document.getElementById("accuracyLabelID").style.color="red";
            bool=false;
            document.getElementById("accuracyID").focus();
        }
        else{
            document.getElementById("accuracyLabelID").style.color="black";
        }
        
        if(document.getElementById("fft_fine_N_ID").checked== false && document.getElementById("fft_fine_Y_ID").checked== false){
            document.getElementById("fft_fineLabelID").style.color="red";
            bool=false;
            document.getElementById("fft_fine_Y_ID").focus();
        }
        else{
            document.getElementById("fft_fineLabelID").style.color="black";
            //type control param and range control param
        }
        
            
        if(bool==false){
            alert("Attention! \n Enter the parameters highlighted in red");
        }
        else{
            
            poissonIsValidate=true;
            alert("Poisson values validate "+poissonIsValidate);
        }
    }
    
    function Submit(){
        var s="";
        var c="";
        var r="";
        var p="";
        if(setupIsValidate && cosmologyIsValidate && randomIsValidate && poissonIsValidate )
            document.getElementById("form_music").submit();
        else{
            if(!setupIsValidate)
                s="Validate setup values!\n"
            
            if(!cosmologyIsValidate)
                c="Validate cosmology values!\n"
           
            if(!randomIsValidate)
                r="Validate random values!\n"
       
            if(!poissonIsValidate)
                p="Validate poisson values!"
            
            
            alert(""+s+c+r+p+""); 
        }
            
        
    } 
    
</script>




=======
>>>>>>> 1931a4726ef79260d7372b34f3809c5e147f6831




