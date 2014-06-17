<%
    /**
     * Copyright (c) 2000-2011 Liferay, Inc. All rights reserved.
     *
     * This library is free software; you can redistribute it and/or modify it
     * under the terms of the GNU Lesser General Public License as published by
     * the Free Software Foundation; either version 2.1 of the License, or (at
     * your option) any later version.
     *
     * This library is distributed in the hope that it will be useful, but
     * WITHOUT ANY WARRANTY; without even the implied warranty of
     * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser
     * General Public License for more details.
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
<form id="form_music" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_SUBMIT_GADGET"/></portlet:actionURL>" method="post">



<div id="container">
    <table>
        <tr>

            <td>
                <!-- <div id="gadget2_setup1">Click to add the setup value</div>-->
                <div id="gadget">
                    <center>
                        <fieldset class="gadget2_fieldset" >

                            <legend class="gadget2_legend"> GADGET VALUES </legend>
                            <table>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelPERIODIC"  >PERIODIC *</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="PERIODIC" id="PERIODIC_Y_ID" value="Y"> Y 
                                        <input type="radio" name="PERIODIC" id="PERIODIC_N_ID" value="N"> N
                                    </td>
                                </tr>


                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelUNEQUALSOFTENINGS"  >UNEQUALSOFTENINGS </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="UNEQUALSOFTENINGS" id="UNEQUALSOFTENINGS_Y_ID" value="Y"> Y 
                                        <input type="radio" name="UNEQUALSOFTENINGS" id="UNEQUALSOFTENINGS_N_ID" value="N"> N
                                    </td>
                                </tr>


                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelPEANOHILBERT"  >PEANOHILBERT </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="PEANOHILBERT" id="PEANOHILBERT_Y_ID" value="Y"> Y 
                                        <input type="radio" name="PEANOHILBERT" id="PEANOHILBERT_N_ID" value="N"> N
                                    </td>
                                </tr>


                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelWALLCLOCK"  >WALLCLOCK </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="WALLCLOCK" id="WALLCLOCK_Y_ID" value="Y"> Y 
                                        <input type="radio" name="WALLCLOCK" id="WALLCLOCK_N_ID" value="N"> N
                                    </td>
                                </tr>

                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelWALLCLOCK"  >WALLCLOCK </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="WALLCLOCK" id="WALLCLOCK_Y_ID" value="Y"> Y 
                                        <input type="radio" name="WALLCLOCK" id="WALLCLOCK_N_ID" value="N"> N
                                    </td>

                                </tr>
                                
                                <tr>
                                    
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelPMGRID"  >PMGRID </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="PMGRID" id="PMGRID_Y_ID" value="Y"> Y 
                                        <input type="radio" name="PMGRID" id="PMGRID_N_ID" value="N"> N
                                    </td>
                                        
                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelPLACEHIGHRESREGION"  >PLACEHIGHRESREGION </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                       <input class="gadget2_textbox" id="PLACEHIGHRESREGIONID" name="PLACEHIGHRESREGION" type="text" value=""/>
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelENLARGEREGION"  >ENLARGEREGION </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="ENLARGEREGIONID" name="ENLARGEREGION" type="text" value=""/>
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelASMTH"  >ASMTH </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="ASMTHID" name="ASMTH" type="text" value=""/>
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelRCUT"  >RCUT </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="RCUTID" name="RCUT" type="text" value=""/>
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelDOUBLEPRECISION"  >DOUBLEPRECISION </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                         <input  type="radio" name="DOUBLEPRECISION" id="DOUBLEPRECISION_Y_ID" value="Y"> Y 
                                        <input type="radio" name="DOUBLEPRECISION" id="DOUBLEPRECISION_Y_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelDOUBLEPRECISION_FFTW"  >DOUBLEPRECISION_FFTW </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="DDOUBLEPRECISION_FFTW" id="DDOUBLEPRECISION_FFTW_Y_ID" value="Y"> Y 
                                        <input type="radio" name="DOUBLEPRECISION_FFTW" id="DOUBLEPRECISION_FFTW_Y_ID" value="N"> N
                                    </td>

                                </tr>
                                
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelSYNCHRONIZATION"  >SYNCHRONIZATION </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="checkbox" name="SYNCHRONIZATION" id="DOUBLEPRECISION_FFTW_Y_ID" value="">  
                                       
                                        
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelFLEXSTEPS"  >FLEXSTEPS </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="FLEXSTEPS" id="FLEXSTEPS_Y_ID" value="Y"> Y 
                                        <input type="radio" name="FLEXSTEPS" id="FLEXSTEPS_Y_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelPSEUDOSYMMETRIC"  >PSEUDOSYMMETRIC </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="PSEUDOSYMMETRIC" id="PSEUDOSYMMETRIC_Y_ID" value="Y"> Y 
                                        <input type="radio" name="PSEUDOSYMMETRIC" id="PSEUDOSYMMETRIC_Y_ID" value="N"> N
                                    </td>

                                </tr>
                                   <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelNOSTOP_WHEN_BELOW_MINTIMESTEP"  >NOSTOP_WHEN_BELOW_MINTIMESTEP </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="NOSTOP_WHEN_BELOW_MINTIMESTEP" id="NOSTOP_WHEN_BELOW_MINTIMESTEP_Y_ID" value="Y"> Y 
                                        <input type="radio" name="NOSTOP_WHEN_BELOW_MINTIMESTEP" id="NOSTOP_WHEN_BELOW_MINTIMESTEP_Y_ID" value="N"> N
                                    </td>

                                </tr>
                                 <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelNOPMSTEPADJUSTMENT"  >NOPMSTEPADJUSTMENT </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="NOPMSTEPADJUSTMENT" id="NOPMSTEPADJUSTMENT_Y_ID" value="Y"> Y 
                                        <input type="radio" name="NOPMSTEPADJUSTMENT" id="NOPMSTEPADJUSTMENT_Y_ID" value="N"> N
                                    </td>

                                </tr>
                                 <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelHAVE_HDF5"  >HAVE_HDF5 </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="HAVE_HDF5" id="HAVE_HDF5_Y_ID" value="Y"> Y 
                                        <input type="radio" name="HAVE_HDF5" id="HAVE_HDF5_Y_ID" value="N"> N
                                    </td>

                                </tr>
                                
                                     <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelOUTPUTPOTENTIAL"  >OUTPUTPOTENTIAL </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="OUTPUTPOTENTIAL" id="OUTPUTPOTENTIAL_Y_ID" value="Y"> Y 
                                        <input type="radio" name="OUTPUTPOTENTIAL" id="OUTPUTPOTENTIAL_Y_ID" value="N"> N
                                    </td>

                                </tr>
                                     <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelOUTPUTACCELERATION"  >OUTPUTACCELERATION </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="OUTPUTACCELERATION" id="OUTPUTACCELERATION_Y_ID" value="Y"> Y 
                                        <input type="radio" name="OUTPUTACCELERATION" id="OUTPUTACCELERATION_Y_ID" value="N"> N
                                    </td>

                                </tr>
                                     <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelOUTPUTCHANGEOFENTROPY"  >OUTPUTCHANGEOFENTROPY </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="OUTPUTCHANGEOFENTROPY" id="OUTPUTCHANGEOFENTROPY_Y_ID" value="Y"> Y 
                                        <input type="radio" name="OUTPUTCHANGEOFENTROPY" id="OUTPUTCHANGEOFENTROPY_Y_ID" value="N"> N
                                    </td>

                                </tr>
                                 <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelOUTPUTTIMESTEP"  >OUTPUTTIMESTEP </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="OUTPUTTIMESTEP" id="OUTPUTTIMESTEP_Y_ID" value="Y"> Y 
                                        <input type="radio" name="OUTPUTTIMESTEP" id="OUTPUTTIMESTEP_Y_ID" value="N"> N
                                    </td>

                                </tr>
                                
                                
                            </table>
                        </fieldset>
                    </center>
                </div>




                <div align="center"><input type="button" value="Submit" onClick="Submit()"></div>
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
     
                        var  b1= true; //bool
        
                        if(document.getElementById("boxlengthID").value== null || document.getElementById("boxlengthID").value==""){
 
          
                            document.getElementById("boxlengthID").value="";
                            document.getElementById("labelBoxlengthID").style.color="red";
                            b1=false;
                        }
                        else{
                            document.getElementById("labelBoxlengthID").style.color="black";
                            //type control param and range control param
                        }
        
        
                        if(document.getElementById("zstartID").value== null || document.getElementById("zstartID").value==""){
 
          
                            document.getElementById("zstartID").value="";
                            document.getElementById("zstartLabelID").style.color="red";
                            b1=false;
                        }
                        else{
                            document.getElementById("zstartLabelID").style.color="black";
                        }
        
                        if(document.getElementById("levelminID").value== null || document.getElementById("levelminID").value==""){
 
          
                            document.getElementById("levelminID").value="";
                            document.getElementById("levelminLabelID").style.color="red";
                            b1=false;
                        }
                        else{
                            document.getElementById("levelminLabelID").style.color="black";
                        }
                        if(document.getElementById("levelmin_TFID").value== null || document.getElementById("levelmin_TFID").value==""){
 
          
                            document.getElementById("levelmin_TFID").value="";
                            document.getElementById("levelmin_TFLabelID").style.color="red";
                            b1=false;
                        }
                        else{
                            document.getElementById("levelmin_TFLabelID").style.color="black";
                        }
        
                        if(document.getElementById("levelmaxID").value== null || document.getElementById("levelmaxID").value==""){
 
          
                            document.getElementById("levelmaxID").value="";
                            document.getElementById("levelmaxLabelID").style.color="red";
                            b1=false;
                        }
                        else{
                            document.getElementById("levelmaxLabelID").style.color="black";
                        }
                        if(document.getElementById("paddingID").value== null || document.getElementById("paddingID").value==""){
 
          
                            document.getElementById("paddingID").value="";
                            document.getElementById("paddingLabelID").style.color="red";
                            b1=false;
                        } 
                        else{
                            document.getElementById("paddingLabelID").style.color="black";
                        }
                        if(document.getElementById("overlapID").value== null || document.getElementById("overlapID").value==""){
 
          
                            document.getElementById("overlapID").value="";
                            document.getElementById("overlapLabelID").style.color="red";
                            b1=false;
                        } else{
                            document.getElementById("overlapLabelID").style.color="black";
                        }

        
                        if(document.getElementById("ref_centerID").value== null || document.getElementById("ref_centerID").value==""){
 
          
                            document.getElementById("ref_centerID").value="";
                            document.getElementById("ref_centerLabelID").style.color="red";
                            b1=false;
       
                        }else{
                            document.getElementById("ref_centerLabelID").style.color="black";
                        }
                        if(document.getElementById("ref_extentID").value== null || document.getElementById("ref_extentID").value==""){
 
          
                            document.getElementById("ref_extentID").value="";
                            document.getElementById("ref_extentLabelID").style.color="red";
                            b1=false;
       
                        }else{
                            document.getElementById("ref_extentLabelID").style.color="black";
                        }
        
                        if(document.getElementById("ref_offsetID").value== null || document.getElementById("ref_offsetID").value==""){
 
          
                            document.getElementById("ref_offsetID").value="";
                            document.getElementById("ref_offsetLabelID").style.color="red";
                            b1=false;
       
                        }else{
                            document.getElementById("ref_extentLabelID").style.color="black";
                        }
        
        
                        if(document.getElementById("align_top_N_ID").checked==false && document.getElementById("align_top_Y_ID").checked==false){
          
                            document.getElementById("align_top_LabelID").style.color="red";
                            b1=false;
                        }
                        else{
                            document.getElementById("align_top_LabelID").style.color="black";
                        }
        
       
       
       
                        if(document.getElementById("use_2LPT_N_ID").checked==false && document.getElementById("use_2LPT_Y_ID").checked==false){
                            document.getElementById("use_2LPT_LabelID").style.color="red";
                            b1=false;
                        }
                        else{
                            document.getElementById("use_2LPT_LabelID").style.color="black";
                        }
        
        
    
       
                        if(document.getElementById("baryons_N_ID").checked==false && document.getElementById("baryons_Y_ID").checked==false){ 
                            document.getElementById("baryons_LabelID").style.color="red";
                            b1=false;
                        }
                        else{
                            document.getElementById("baryons_LabelID").style.color="black";
                        }
                        //type control param and range control param
        
       
                        if(document.getElementById("use_LLA_N_ID").checked==false && document.getElementById("use_LLA_Y_ID").checked==false){
                            document.getElementById("use_LLA_LabelID").style.color="red";
                            b1=false;    
                        }
                        else{
                            document.getElementById("use_LLA_LabelID").style.color="black";
                        }
                        //type control param and range control param 
       
                        if(document.getElementById("periodic_TF_Y_ID").checked==false && document.getElementById("periodic_TF_N_ID").checked==false){
                            document.getElementById("periodic_TF_LabelID").style.color="red";
                            b1=false;
                        }
                        else{
                            document.getElementById("periodic_TF_LabelID").style.color="black";
                        }
                        //type control param and range control param 
            
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
                        if(document.getElementById("Omega_mID").value== null || document.getElementById("Omega_mID").value==""){
 
          
                            document.getElementById("Omega_mID").value="";
                            document.getElementById("Omega_mLabelID").style.color="red";
                            bool=false;
                        }
                        else{
                            document.getElementById("Omega_mLabelID").style.color="black";
                            //type control param and range control param
                        }
        
        
                        if(document.getElementById("Omega_LID").value== null || document.getElementById("Omega_LID").value==""){
 
          
                            document.getElementById("Omega_LID").value="";
                            document.getElementById("Omega_LlabelID").style.color="red";
                            bool=false;
                        }
                        else{
                            document.getElementById("Omega_LlabelID").style.color="black";
                        }
        
                        if(document.getElementById("Omega_bID").value== null || document.getElementById("Omega_bID").value==""){
 
          
                            document.getElementById("Omega_bID").value="";
                            document.getElementById("Omega_bLabelID").style.color="red";
                            bool=false;
                        }
                        else{
                            document.getElementById("Omega_bLabelID").style.color="black";
                        }
        
                        if(document.getElementById("H0ID").value== null || document.getElementById("H0ID").value==""){
 
          
                            document.getElementById("H0ID").value="";
                            document.getElementById("H0LabelID").style.color="red";
                            bool=false;
                        }
                        else{
                            document.getElementById("H0LabelID").style.color="black";
                        }
        
                        if(document.getElementById("sigma_8ID").value== null || document.getElementById("sigma_8ID").value==""){
 
          
                            document.getElementById("sigma_8ID").value="";
                            document.getElementById("sigma_8LabelID").style.color="red";
                            bool=false;
                        }
                        else{
                            document.getElementById("sigma_8LabelID").style.color="black";
                        }
                        if(document.getElementById("nspecID").value== null || document.getElementById("nspecID").value==""){
 
          
                            document.getElementById("nspecID").value="";
                            document.getElementById("nspecLabelID").style.color="red";
                            bool=false;
                        } 
                        else{
                            document.getElementById("nspecLabelID").style.color="black";
                        }
                        if(document.getElementById("transferID").value== null || document.getElementById("transferID").value==""){
 
          
                            document.getElementById("transferID").value="";
                            document.getElementById("transferLabelID").style.color="red";
                            bool=false;
                        } else{
                            document.getElementById("transferLabelID").style.color="black";
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
                        if(document.getElementById("seed7ID").value== null || document.getElementById("seed7ID").value==""){
 
          
                            document.getElementById("seed7ID").value="";
                            document.getElementById("seed7LabelID").style.color="red";
                            bool=false;
                        }
                        else{
                            document.getElementById("seed7LabelID").style.color="black";
                            //type control param and range control param
                        }
        
        
                        if(document.getElementById("seed8ID").value== null || document.getElementById("seed8ID").value==""){
 
          
                            document.getElementById("seed8ID").value="";
                            document.getElementById("seed8LabelID").style.color="red";
                            bool=false;
                        }
                        else{
                            document.getElementById("seed8LabelID").style.color="black";
                        }
        
                        if(document.getElementById("seed9ID").value== null || document.getElementById("seed9ID").value==""){
 
          
                            document.getElementById("seed9ID").value="";
                            document.getElementById("seed9LabelID").style.color="red";
                            bool=false;
                        }
                        else{
                            document.getElementById("seed9LabelID").style.color="black";
                        }
        
                        if(document.getElementById("seed10ID").value== null || document.getElementById("seed10ID").value==""){
 
          
                            document.getElementById("seed10ID").value="";
                            document.getElementById("seed10LabelID").style.color="red";
                            bool=false;
                        }
                        else{
                            document.getElementById("seed10LabelID").style.color="black";
                        }
        
                        if(document.getElementById("seed11ID").value== null || document.getElementById("seed11ID").value==""){
 
          
                            document.getElementById("seed11ID").value="";
                            document.getElementById("seed11LabelID").style.color="red";
                            bool=false;
                        }
                        else{
                            document.getElementById("seed11LabelID").style.color="black";
                        }
                        if(document.getElementById("seed12ID").value== null || document.getElementById("seed12ID").value==""){
 
          
                            document.getElementById("seed12ID").value="";
                            document.getElementById("seed12LabelID").style.color="red";
                            bool=false;
                        } 
                        else{
                            document.getElementById("seed12LabelID").style.color="black";
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
                        if(document.getElementById("fft_fine_N_ID").checked== false && document.getElementById("fft_fine_Y_ID").checked== false){
 
                            document.getElementById("fft_fineLabelID").style.color="red";
                            bool=false;
                        }
                        else{
                            document.getElementById("fft_fineLabelID").style.color="black";
                            //type control param and range control param
                        }
        
        
                        if(document.getElementById("accuracyID").value== null || document.getElementById("accuracyID").value==""){
 
          
                            document.getElementById("accuracyID").value="";
                            document.getElementById("accuracyLabelID").style.color="red";
                            bool=false;
                        }
                        else{
                            document.getElementById("accuracyLabelID").style.color="black";
                        }
        
                        if(document.getElementById("pre_smoothID").value== null || document.getElementById("pre_smoothID").value==""){
 
          
                            document.getElementById("pre_smoothID").value="";
                            document.getElementById("pre_smoothLabelID").style.color="red";
                            bool=false;
                        }
                        else{
                            document.getElementById("pre_smoothLabelID").style.color="black";
                        }
        
                        if(document.getElementById("post_smoothID").value== null || document.getElementById("post_smoothID").value==""){
 
          
                            document.getElementById("post_smoothID").value="";
                            document.getElementById("post_smoothLabelID").style.color="red";
                            bool=false;
                        }
                        else{
                            document.getElementById("post_smoothLabelID").style.color="black";
                        }
        
                        if(document.getElementById("smootherID").value== null || document.getElementById("smootherID").value==""){
 
          
                            document.getElementById("smootherID").value="";
                            document.getElementById("smootherLabelID").style.color="red";
                            bool=false;
                        }
                        else{
                            document.getElementById("smootherLabelID").style.color="black";
                        }
                        if(document.getElementById("laplace_orderID").value== null || document.getElementById("laplace_orderID").value==""){
 
          
                            document.getElementById("laplace_orderID").value="";
                            document.getElementById("laplace_orderLabelID").style.color="red";
                            bool=false;
                        } 
                        else{
                            document.getElementById("laplace_orderLabelID").style.color="black";
                        }
        
                        if(document.getElementById("grad_orderID").value== null || document.getElementById("grad_orderID").value==""){
 
          
                            document.getElementById("grad_orderID").value="";
                            document.getElementById("grad_orderLabelID").style.color="red";
                            bool=false;
                        } 
                        else{
                            document.getElementById("grad_orderLabelID").style.color="black";
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





